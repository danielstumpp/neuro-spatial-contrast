clear 

num_train = 140;
num_val = 27;

files = dir('./*png');
p = randperm(length(files));

for i = 1:length(files)
    
    if i <= num_train
        movefile(files(p(i)).name,fullfile('./train',files(p(i)).name));
    elseif i <= num_train + num_val
        movefile(files(p(i)).name,fullfile('./val',files(p(i)).name));
    else
        movefile(files(p(i)).name,fullfile('./test',files(p(i)).name));
    end
    
end