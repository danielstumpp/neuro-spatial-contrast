
clear
close all
warning('off');
tic;

root = 'sc_absolute_extract/sc_absolute_extract';

sets = dir(root);
L = length(sets) - 2;
names = cell(L,1);
on_cnt_arr = zeros(L,1);
off_cnt_arr = zeros(L,1);
ev_per_img_arr = zeros(L,1);
perc_pixel_arr = zeros(L,1);
of_ration_arr = zeros(L,1);
idx = 1;

for set = sets'
    if strcmp(set.name,'.') || strcmp(set.name,'..'); continue; end
    
    on_event_cnt = 0;
    off_event_cnt = 0;
    total_event_cnt = 0;
    total_possible = 0;
    totalX = 0;
    totalY = 0;
    img_cnt = 0;
    
    threshes = dir(fullfile(root,set.name));
    for thresh = threshes'
        if strcmp(thresh.name,'.') || strcmp(thresh.name,'..'); continue; end
        disp(['counting ',fullfile(root,set.name,thresh.name)]);
        classes = dir(fullfile(root,set.name,thresh.name));
        for class = classes'
            if strcmp(class.name,'.') || strcmp(class.name,'..'); continue; end
            files = dir(fullfile(root,set.name,thresh.name,class.name,'*.png'));
            %disp(['processing ',fullfile(root,set.name,thresh.name,class.name)]);
            for file = files'
                try
                    img = imread(fullfile(root, set.name, thresh.name,class.name,file.name));
                    img = img(:,:,1);
                    on_event_cnt = on_event_cnt + sum(img == 255,'all');
                    off_event_cnt = off_event_cnt + sum(img == 0,'all');
                    total_event_cnt = on_event_cnt + off_event_cnt;
                    total_possible = total_possible + numel(img);
                    img_cnt = img_cnt + 1;
                    totalX = totalX + size(img,1);
                    totalY = totalY + size(img,2);
                catch
                    disp('ERROR ***********');
                    continue
                end
            end
        end
    end
    on_cnt_arr(idx) = on_event_cnt;
    off_cnt_arr(idx) = off_event_cnt;
    ev_per_img_arr(idx) = total_event_cnt/img_cnt;
    perc_pixel_arr(idx) = 100*total_event_cnt/total_possible;
    of_ration_arr(idx) = on_event_cnt/off_event_cnt;
    
    disp(['Results for ',set.name])
    disp(['Average Evts/Img: ',num2str(total_event_cnt/img_cnt)]);
    disp(['Percent Pixel Activation: ',num2str(100*total_event_cnt/total_possible),'%']);
    disp(['On/Off Ratio: ',num2str(on_event_cnt/off_event_cnt)])
%     totalX/img_cnt
%     totalY/img_cnt
%     total_possible
    idx = idx + 1;
end



disp(toc/60)
