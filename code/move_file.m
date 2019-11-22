%changename.m
clear,clc;

%% 文件夹路径
day_or_night = '0';
modal = 'event';
src_label_path = 'E:\111';
src_image_path = 'E:\ERTD\time_stamp\night';
dst_label_path = 'E:\day\annotation';
dst_image_path = 'E:\ERID\total_image\day';

%% 遍历所有文件夹
src_label_list = dir(src_label_path);
src_label_list = src_label_list(3:end);
num_folfer = numel(src_label_list);
for i=1:num_folfer
    foldername = src_label_list(i).name;
    full_folder = [src_label_path,'\',foldername,'\','DVS_rgb'];
    file_list = dir([full_folder,'\*.json']);
    num_file = numel(file_list);
    folder_id = foldername(end-1:end);
    for j=1:num_file
        filename = file_list(j).name;
        src_label = [src_label_path,'\',foldername,'\','DVS_rgb','\',filename];
        filename = filename(1:end-5);
        file_id = str2double(filename(6:end));
%         file_id = str2double(filename(1:9));
        file_id = num2str(file_id,'%03d');
        dst_label = [dst_label_path,'\',modal,'\',day_or_night,'_',folder_id,'_',file_id,'.json'];
        copyfile(src_label,dst_label);
        fprintf('进度: %d/%d\t%d/%d\n',i,num_folfer,j,num_file);
    end
end

% %% 
% src_list = dir(src_image_path);
% src_list = src_list(3:end);
% num_folfer = numel(src_list);
% for i=1:num_folfer
%     folder_name = src_list(i).name;
%     src_folder = [src_image_path,'\',folder_name,'\infrared_time.txt'];
%     dst_folder = [src_image_path,'\',folder_name,'\thermal_time.txt'];
%     movefile(src_folder,dst_folder);
%     fprintf('进度: %d/%d\t%s -> %s\n',i,num_folfer,src_folder,dst_folder);
% end