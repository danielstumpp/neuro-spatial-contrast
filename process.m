clear
close all
warning('off');
tic;

base = 'baseline_extract/baseline/';
root = 'sc_relative_test';
method = 'relative';
% [.0025 .0075 .01 .02 .03 .04 .05 .06 .07 .08]
for thresh = [.2]%[.005 .01 .05 .075 .1 .15 .2 .25 .3 .4 .5]
    name = [method,'-',num2str(thresh)];
    
    % setup top file structure
    mkdir(fullfile(root,name));
    copyfile(fullfile(base,'*.csv'),fullfile(root,name))
    
    err_cnt = 0;
    
    for set = {'Test'}
        mkdir(fullfile(root,name,set{:}));
        files = dir(fullfile(base,set{:},'*.png'));
        for file = files'
            try
                img = imread(fullfile(base,set{:},file.name));
                %img = imresize(img,[64 64],'Method','bicubic');
                sc_img = im2sc(img, 'PosThresh',thresh, 'NegThresh', -thresh, 'Method',method);
                imwrite(sc_img, fullfile(root,name,set{:},file.name));
            catch
                disp('ERROR******************************************************************');
                err_cnt = err_cnt + 1;
            end
            
            
        end
    end
    
    % loop through all the subfolders in validationa and train
    for set = {'Train'}
        folders = dir(fullfile(base,set{:}));
        for folder = folders'
            mkdir(fullfile(root,name,set{:},folder.name));
            disp(['Processing ',fullfile(root,name,set{:},folder.name)]);
            if strcmp(folder.name, 'other-sign'); continue; end
            files = dir(fullfile(base,set{:},folder.name,'*.png'));
            for file = files'
                try
                    img = imread(fullfile(base,set{:},folder.name,file.name));
                    %img = imresize(img,[64 64],'Method','bicubic');
                    sc_img = im2sc(img, 'PosThresh',thresh, 'NegThresh', -thresh, 'Method',method);
                    imwrite(sc_img, fullfile(root,name,set{:},folder.name,file.name));
                catch
                    disp('ERROR******************************************************************');
                    err_cnt = err_cnt + 1;
                end
                
            end
        end
    end
    
    
end
disp(toc/60)
disp(err_cnt);