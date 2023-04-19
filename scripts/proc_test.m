% process raw images and convert to sc images

clear 
close all
clc

% setings
dest = 'Adaptive-.02-.12-evenStep-6bin';

mkdir('../proc',dest);
mkdir(['../proc/',dest],'Train');
mkdir(['../proc/',dest],'Validation');
mkdir(['../proc/',dest],'Test');

% keep right images
process_imgs('keepRight','keep right', dest);

% pedestrian crossing images
process_imgs('pedestrianCrossing','pedestrian crossing', dest);

% signal ahead images
process_imgs('signalAhead','signal ahead', dest);

% speed limit 35 images
process_imgs('speedLimit35','speed limit 35', dest);

% stop sign images
process_imgs('stop','stop', dest);


%% functions
function process_imgs(id, str, dest)
cnt = 1;
files = dir(['../raw/Train_Raw/',id,'/*.png']);
mkdir(fullfile('../proc',dest,'Train'),id);
for file = files'
    disp(['processing ', str,' train image ',num2str(cnt), ' of ',num2str(length(files))]);
    img = imread(fullfile('../raw/Train_Raw',id,file.name));
    sc_img = im2sc_dev(img);
    imwrite(sc_img, fullfile('../proc',dest,'Train',id,['sc-',file.name]));
    cnt = cnt + 1;
end

cnt = 1;
files = dir(['../raw/Validation_Raw/',id,'/*.png']);
mkdir(fullfile('../proc',dest,'Validation'),id);
for file = files'
    disp(['processing ', str,' validation image ',num2str(cnt), ' of ',num2str(length(files))]);
    img = imread(fullfile('../raw/Validation_Raw',id,file.name));
    sc_img = im2sc_dev(img);
    imwrite(sc_img, fullfile('../proc',dest,'Validation',id,['sc-',file.name]));
    cnt = cnt + 1;
end

cnt = 1;
files = dir(['../raw/Test_Raw/',id,'/*.png']);
mkdir(fullfile('../proc',dest,'Test'),id);
for file = files'
    disp(['processing ', str,' test image ',num2str(cnt), ' of ',num2str(length(files))]);
    img = imread(fullfile('../raw/Test_Raw',id,file.name));
    sc_img = im2sc_dev(img);
    imwrite(sc_img, fullfile('../proc',dest,'Test',id,['sc-',file.name]));
    cnt = cnt + 1;
end
disp([str,' signs DONE!']);
disp('###################################');
end




