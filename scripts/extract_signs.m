function extract_signs(src, dest, csvfn)
%EXTRACT_SIGNS Summary of this function goes here
%   Detailed explanation goes here

csv = readtable(csvfn);

for i = 1:size(csv,1)
    fn = csv{i,6}{:};
    try 
        frame = imread(fullfile(src,fn));

        x = csv{i,2};
        y = csv{i,3};
        w = csv{i,4};
        h = csv{i,5};

        img = frame(y:y+h, x:x+w, :);
        imwrite(img, fullfile(dest, fn)); 
    catch
       % who cares
    end

end

end

