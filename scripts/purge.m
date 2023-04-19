
csv = readtable('annotation.csv');
mkdir('correct');
for i = 1:size(csv,1)
    fn = csv{i,6}{:};
    if isfile(fn)
        movefile(fn, fullfile('./correct',fn));
    end
end