%find_common.m
clear,clc;

%% 文件夹路径
src_label_path = 'E:\day\annotation';
src_image_path = 'E:\ERID\total_image\day';
dst_label_path = 'E:\ERID\segmentation\day\annotation';
dst_image_path = 'E:\ERID\segmentation\day\image';

%% 遍历所有文件夹
src_label_list = dir([src_label_path,'\event\*.json']);
num_file = numel(src_label_list);
for i=1:num_file
    filename = src_label_list(i).name(1:end-5);
    fold_id = filename(3:4);
    src_event_label = [src_label_path,'\event\',filename,'.json'];
    src_rgb_label = [src_label_path,'\rgb\',filename,'.json'];
    src_infrared_label = [src_label_path,'\infrared\',filename,'.json'];    
    src_event_image = [src_image_path,'\multi-modal_',fold_id,'\event\',filename,'.jpg'];
    src_rgb_image = [src_image_path,'\multi-modal_',fold_id,'\rgb\',filename,'.jpg'];
    src_infrared_image = [src_image_path,'\multi-modal_',fold_id,'\infrared\',filename,'.jpg'];
    if exist(src_event_label,'file') && exist(src_rgb_label,'file') && exist(src_infrared_label,'file') &&...
            exist(src_event_image,'file') && exist(src_rgb_image,'file') && exist(src_infrared_image,'file')
        dst_event_label = [dst_label_path,'\event\',filename,'.json'];
        dst_rgb_label = [dst_label_path,'\rgb\',filename,'.json'];
        dst_infrared_label = [dst_label_path,'\infrared\',filename,'.json'];    
        dst_event_image = [dst_image_path,'\event\',filename,'.jpg'];
        dst_rgb_image = [dst_image_path,'\rgb\',filename,'.jpg'];
        dst_infrared_image = [dst_image_path,'\infrared\',filename,'.jpg'];
        
        copyfile(src_event_label,dst_event_label);
        copyfile(src_rgb_label,dst_rgb_label);
        copyfile(src_infrared_label,dst_infrared_label);
        copyfile(src_event_image,dst_event_image);
        copyfile(src_rgb_image,dst_rgb_image);
        copyfile(src_infrared_image,dst_infrared_image);
    end
    fprintf('进度: %d/%d\n',i,num_file);
end