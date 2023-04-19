function scImg = im2sc_dev(image, threshes, varargin)
%IM2SC Summary of this function goes here
%   Detailed explanation goes here

defaultNegThresh = -.04;
defaultPosThresh  = .04;
defaultKernelSize = 3;
defaultMethod = 'adaptive';

p = inputParser;
validThresh = @(x) isnumeric(x) && (abs(x) < 1) && (abs(x) > 0);
validKernel = @(x) isnumeric(x) && (x > 1) && (mod(x,2) ~= 0);
validMethod = @(x) strcmp(x, 'YCbCr') || strcmp(x, 'adaptive' );

addRequired(p, 'image');
addOptional(p, 'NegThresh', defaultNegThresh, validThresh);
addOptional(p, 'PosThresh', defaultPosThresh, validThresh);
addOptional(p, 'KernelSize', defaultKernelSize, validKernel);
addOptional(p, 'Method', defaultMethod, validMethod);

parse(p, image, varargin{:});

img         = p.Results.image;
negThresh   = p.Results.NegThresh;
posThresh   = p.Results.PosThresh;
kSize       = p.Results.KernelSize;
method      = p.Results.Method;



if strcmp(method, 'adaptive')
    img = im2double(rgb2gray(img));
    
    segImg = medfilt2(img,[kSize kSize]);
    segments = 6;
    cuts = 1:-(1/segments):0;
    %threshes = cuts.*posThresh;
    %threshes = [.02 .04 .06 .08 .1 .12];
    threshImg = zeros(size(img));
    for cut = 1:segments
        threshImg(cuts(cut) > segImg) = threshes(cut);
    end
    
    % create kernel based on specifications
    kernel = (1/(kSize^2 - 1)).*ones(kSize);
    kernel(ceil(kSize/2), ceil(kSize/2)) = 0;
    
    spatDiffImg = img - imfilter(img, kernel, 'replicate');
    spatDiffImg = spatDiffImg./img;
    spatDiffImg(spatDiffImg == -Inf) = 0;
    
    scImg = .5.*ones(size(img));
    
    scImg(spatDiffImg > threshImg) = 1;
    scImg(spatDiffImg < -threshImg) = 0;
    
    scImg = im2uint8(scImg);
    
elseif strcmp(method,'YCbCr')
    posThresh = .001;
    negThresh = -.001;
    
    img = rgb2ntsc(im2double(img));
    img = img(:,:,1);
    
    % create kernel based on specifications
    kernel = (1/(kSize^2 - 1)).*ones(kSize);
    kernel(ceil(kSize/2), ceil(kSize/2)) = 0;
    
    spatDiffImg = img - imfilter(img, kernel, 'replicate');
    relDiffImg = spatDiffImg./img;
%     figure; imshow(img);
%     figure; imshow(spatDiffImg,[]);
%     figure; imshow(relDiffImg,[]);
    scImg = .5.*ones(size(img));
    
    scImg(spatDiffImg > posThresh) = 1;
    scImg(spatDiffImg < negThresh) = 0;
    
    scImg = im2uint8(scImg);
    
    img = imgaussfilt(img,2);
    scImg = edge(img, 'canny');
end

end