function scImg = im2sc(image, varargin)
%IM2SC Summary of this function goes here
%   Detailed explanation goes here

defaultNegThresh = -.05;
defaultPosThresh  = .05;
defaultKernelSize = 3;
defaultMethod = 'relative';

p = inputParser;
validThresh = @(x) isnumeric(x) && (abs(x) < 10000) && (abs(x) > 0);
validKernel = @(x) isnumeric(x) && (x > 1) && (mod(x,2) ~= 0);
validMethod = @(x) strcmp(x, 'relative') || strcmp(x, 'absolute');

addRequired(p, 'image');
addOptional(p, 'NegThresh', defaultNegThresh, validThresh);
addOptional(p, 'PosThresh', defaultPosThresh, validThresh);
addOptional(p, 'KernelSize', defaultKernelSize, validKernel);
addOptional(p, 'Method', defaultMethod, validMethod);

parse(p, image, varargin{:});

if size(image, 3) == 1
    img = im2double(p.Results.image);
else
    img = im2double(rgb2gray(p.Results.image));
end
negThresh   = p.Results.NegThresh;
posThresh   = p.Results.PosThresh;
kSize       = p.Results.KernelSize;
method      = p.Results.Method;

% create kernel based on specifications
kernel = (1/(kSize^2 - 1)).*ones(kSize);
kernel(ceil(kSize/2), ceil(kSize/2)) = 0;

spatDiffImg = img - filter2(kernel, img);

%relDiffImg = sign(spatDiffImg).*abs(spatDiffImg)./abs(img);
relDiffImg = spatDiffImg./img;
relDiffImg(relDiffImg == -Inf) = 0;

scImg = .5.*ones(size(img));

if strcmp(method,'relative')
    scImg(relDiffImg > posThresh) = 1;
    scImg(relDiffImg < negThresh) = 0;
elseif strcmp(method,'absolute')
    scImg(spatDiffImg > posThresh) = 1;
    scImg(spatDiffImg < negThresh) = 0;
end

scImg = im2uint8(scImg);

end

