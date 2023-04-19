
clear
close all
warning('off');
tic;

root = 'baseline';

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
    
    
    threshes = dir(fullfile(root,set.name));
    for thresh = threshes'
        if strcmp(thresh.name,'.') || strcmp(thresh.name,'..') || strcmp(thresh.name,'other-sign'); continue; end
        disp(['counting ',fullfile(root,set.name,thresh.name)]);
        files = dir(fullfile(root,set.name,thresh.name,'*.jpg'));
        %disp(['processing ',fullfile(root,set.name,thresh.name,class.name)]);
        for file = files'
            try
                img = imread(fullfile(root, set.name, thresh.name,file.name));
                pixels(idx) = size(img,1)*size(img,2);
                idx = idx + 1;
            catch
                disp('ERROR ***********');
                continue
            end
            
        end
    end
    
end



disp(toc/60)
