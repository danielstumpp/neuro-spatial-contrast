clear
close all
id = {'keepRight', 'pedestrianCrossing', 'speedLimit35', 'stop'};
grp = {'Test','Train','Validation'};

folders = dir();
for folder = folders'
    cnt = 0;
    imcnt = 0;
    for j = 1:3
        for i = 1:4
            files = dir(['./',folder.name,'/full/',grp{j},'/', id{i} ,'/*.png']);
            for file = files'
                img = imread(fullfile(folder.name,'full',grp{j},id{i},file.name));
                img(img == 0) = 255;
                cnt = cnt + length(find(img == 255));
                imcnt = imcnt + 1;
            end
        end
    end
    
    avg_events = cnt / imcnt;
    disp([folder.name, ': ',num2str(avg_events)]);
    
end
