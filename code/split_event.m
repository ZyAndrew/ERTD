% test.m
clear,clc;

%%
fid = fopen('E:\ERID\raw_event\night\multi-modal_33\events.txt','r');
event = fscanf(fid,'%f %d %d %d',[4,Inf])';
fclose(fid);
total_size = size(event,1);
bag_size = 10000000;
num = ceil(total_size / bag_size);
for i=1:num
    idx0 = (i - 1) * bag_size + 1;
    idx1 = i * bag_size;
    idx1 = min(idx1,total_size);
    filename = ['E:\ERID\raw_event\night\multi-modal_33\',num2str(i),'.txt'];
    fid = fopen(filename,'w');
    fprintf(fid,'%.6f %d %d %d\n',event(idx0:idx1,:)');
    fclose(fid);
    fprintf('½ø¶È: %d/%d\n',i,num);
end