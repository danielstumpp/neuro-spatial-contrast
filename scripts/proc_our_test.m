% process raw images and convert to sc images

clear
close all
clc

tic;

% setings
%dest = 'Adaptive-.02-.12-evenStep-6bin';
%threshes = [.01 .05 .1 .15 .20 .25 .3 .4 .5 .6 .7 .8 .9 1 3 6 10 15 25 50];
threshes = {[.02 .04 .06 .08 .1 .12], [.05 .1 .15 .25, .30 .35], [.2 .25 .35 .5 .75 1]};
method = 'adaptive';
cnt = 0;
for i = 1:length(threshes)
    cnt = cnt + 1;
    thresh = threshes{i};
    dest = [method,'-',num2str(cnt)];
    
    mkdir('../OURS/proc/',dest);
    mkdir(['../OURS/proc/',dest],'full');
    mkdir(['../OURS/proc/',dest],'extracted');
    mkdir(['../OURS/proc/',dest, '/full'],'Train');
    mkdir(['../OURS/proc/',dest, '/full'],'Validation');
    mkdir(['../OURS/proc/',dest, '/full'],'Test');
    mkdir(['../OURS/proc/',dest, '/extracted'],'Train');
    mkdir(['../OURS/proc/',dest, '/extracted'],'Validation');
    mkdir(['../OURS/proc/',dest, '/extracted'],'Test');
    
    
    % keep right images
    process_imgs('keepRight','keep right', dest, method, thresh);
    
    % pedestrian crossing images
    process_imgs('pedestrianCrossing','pedestrian crossing', dest, method, thresh);
    
    % signal ahead images
    %process_imgs('signalAhead','signal ahead', dest);
    
    % speed limit 35 images
    process_imgs('speedLimit35','speed limit 35', dest, method, thresh);
    
    % stop sign images
    process_imgs('stop','stop', dest, method, thresh);
    
    t = toc;
    disp(['completed in ',num2str(t/60), ' minutes']);
    
end

%% functions
function process_imgs(id, str, dest, method, thresh)
cnt = 1;
files = dir(['../OURS/raw/Train_Raw/',id,'/*.png']);
mkdir(fullfile('../OURS/proc',dest,'full/Train'),id);
for file = files'
    disp(['processing ', str,' train image ',num2str(cnt), ' of ',num2str(length(files))]);
    img = imread(fullfile('../OURS/raw/Train_Raw',id,file.name));
    %sc_img = im2sc(img, 'Method',method,'PosThresh', thresh, 'NegThresh', -thresh);
    sc_img = im2sc_dev(img, thresh, 'Method',method);
    imwrite(sc_img, fullfile('../OURS/proc',dest,'full/Train',id,file.name));
    cnt = cnt + 1;
end

mkdir(fullfile('../OURS/proc',dest,'extracted/Train'),id);
extract_signs(fullfile('../OURS/proc',dest,'full/Train',id), ...
    fullfile('../OURS/proc',dest,'extracted/Train',id), ...
    ['../OURS/raw/Train_Raw/',id,'/annotation.csv']);

cnt = 1;
files = dir(['../OURS/raw/Validation_Raw/',id,'/*.png']);
mkdir(fullfile('../OURS/proc',dest,'full/Validation'),id);
for file = files'
    disp(['processing ', str,' validation image ',num2str(cnt), ' of ',num2str(length(files))]);
    img = imread(fullfile('../OURS/raw/Validation_Raw',id,file.name));
    %sc_img = im2sc(img, 'Method',method,'PosThresh', thresh, 'NegThresh', -thresh);
    sc_img = im2sc_dev(img, thresh, 'Method',method);
    imwrite(sc_img, fullfile('../OURS/proc',dest,'full/Validation',id,file.name));
    cnt = cnt + 1;
end

mkdir(fullfile('../OURS/proc',dest,'extracted/Validation'),id);
extract_signs(fullfile('../OURS/proc',dest,'full/Validation',id), ...
    fullfile('../OURS/proc',dest,'extracted/Validation',id), ...
    ['../OURS/raw/Validation_Raw/',id,'/annotation.csv']);

cnt = 1;
files = dir(['../OURS/raw/Test_Raw/',id,'/*.png']);
mkdir(fullfile('../OURS/proc',dest,'full/Test'),id);
for file = files'
    disp(['processing ', str,' test image ',num2str(cnt), ' of ',num2str(length(files))]);
    img = imread(fullfile('../OURS/raw/Test_Raw',id,file.name));
    %sc_img = im2sc(img, 'Method',method,'PosThresh', thresh, 'NegThresh', -thresh);
    sc_img = im2sc_dev(img, thresh, 'Method',method);
    imwrite(sc_img, fullfile('../OURS/proc',dest,'full/Test',id,file.name));
    cnt = cnt + 1;
end

mkdir(fullfile('../OURS/proc',dest,'extracted/Test'),id);
extract_signs(fullfile('../OURS/proc',dest,'full/Test',id), ...
    fullfile('../OURS/proc',dest,'extracted/Test',id), ...
    ['../OURS/raw/Test_Raw/',id,'/annotation.csv']);

disp([str,' signs DONE!']);
disp('###################################');
end




