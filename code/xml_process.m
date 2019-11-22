%xmlprocess.m
clear,clc;

%% 文件夹路径
modal = 'event';
src_path = ['E:\ERTD\detection\night\annotation\',modal];

%% 遍历所有文件夹
file_list = dir([src_path,'\*.xml']);
num_file= numel(file_list);
objectnum = struct('Car',0,'Cyclist',0,'Bus',0,'Sign',0,'Pedestrian',0);
fields = fieldnames(objectnum);
nclass = numel(fields);
cnt = 0;
for i=1:num_file
    filename = file_list(i).name;
    rootnode = xmlread([src_path,'\',filename]);
    mainnode = rootnode.getChildNodes.item(0);
    childNodes = mainnode.getChildNodes;
    numChildNodes = childNodes.getLength;
    for j=1:numChildNodes
        childNode = childNodes.item(j-1);
%         %% folder
%         if strcmp(childNode.getNodeName,'folder')
%             childNode = childNode.getChildNodes.item(0);
%             childNode.setData(modal);
%         %% filename
%         elseif strcmp(childNode.getNodeName,'filename')
%             childNode = childNode.getChildNodes.item(0);
%             childNode.setData(strrep(filename,'xml','jpg'));
%         %% path
%         elseif strcmp(childNode.getNodeName,'path')
%             childNode = childNode.getChildNodes.item(0);
%             childNode.setData(' ');
%         %% object
%         elseif strcmp(childNode.getNodeName,'object')
%             childNode = childNode.getChildNodes.item(1);
%             childNode = childNode.getChildNodes.item(0);
%             objectname = char(childNode.getData);  
%             for k=1:nclass
%                 field = fields{k};
%                 if contains(objectname,field,'IgnoreCase',true)
%                     %childNode.setData(field);
%                     num = getfield(objectnum,field);
%                     objectnum = setfield(objectnum,field,num+1);
%                     break;
%                 end
%             end
%         end
        if strcmp(childNode.getNodeName,'object')
            namechildNode = childNode.getChildNodes.item(1);
            namechildNode = namechildNode.getChildNodes.item(0);
            objectname = char(namechildNode.getData);  
            id = ' ';
            for k=1:nclass
                field = fields{k};
                if contains(objectname,field,'IgnoreCase',true)
                    namechildNode.setData(field);
                    num = getfield(objectnum,field);
                    objectnum = setfield(objectnum,field,num+1);
                    len = length(field);
                    id = objectname(len+1:end);
                    if isnan(str2double(id))
                        id = ' ';
                    end
                    break;
                end
            end
            idchildNode = rootnode.createElement('id');
            idchildNode.appendChild(rootnode.createTextNode(id));
            childNode.appendChild(idchildNode);
        end
    end
    xmlwrite([src_path,'\',filename],rootnode);
    fprintf('进度: %d/%d\n',i,num_file);
end