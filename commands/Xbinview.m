% Xbinview(B,E,c,g)
%
% Toolbox Xvis:
%   Display gray or color image I overimposed by color pixels determined
%   by binary image E. Useful to display the edges of an image.
%   Variable c is the color vector [r g b] indicating the color to be displayed 
%   (default: c = [1 0 0], i.e., red), cc could be 'r' for red, 'b' for
%   blue, 'g' for green, etc. (see colors of plot function).
%   Variable g is the number of pixels for the dilation of the binary image
%   default g = 1
%
% Example to display a red edge of a food: 
%    I = imread('testimg2.jpg');   % Input image
%    [R,E] = Bsegbalu(I);          % Segmentation
%    Bedgeview(I,E)

function Xbinview(B,E,cc,g)

if not(exist('cc','var'))
    cc = [1 0 0];
end

if ischar(cc)
switch lower(cc)
    case 'r'
        cc = [1 0 0];
    case 'g'
        cc = [0 1 0];
    case 'b'
        cc = [0 0 1];
    case 'y'
        cc = [1 1 0];
    case 'c'
        cc = [0 1 1];
    case 'm'
        cc = [1 0 1];
    case 'k'
        cc = [0 0 0];
    case 'w'
        cc = [1 1 1];
end    
end
if not(exist('g','var'))
    g = 1;
end


B = double(B);
if max(B(:))>1
    B = B/256;
end

if (size(B,3)==1)
    [N,M] = size(B);
    J = zeros(N,M,3);
    J(:,:,1) = B;
    J(:,:,2) = B;
    J(:,:,3) = B;
    B = J;
end

B1 = B(:,:,1);
B2 = B(:,:,2);
B3 = B(:,:,3);

Z = B1==0;
Z = and(Z,B2==0);
Z = and(Z,B3==0);
ii = find(Z==1);
if not(isempty(ii))
    B1(ii) = 1/256;
    B2(ii) = 1/256;
    B3(ii) = 1/256;
end
warning off
E = imdilate(E,ones(g,g));
ii       = find(E==1);
B1(ii)   = cc(1)*255;
B2(ii)   = cc(2)*255;
B3(ii)   = cc(3)*255;
Y        = double(B);
Y(:,:,1) = B1;
Y(:,:,2) = B2;
Y(:,:,3) = B3;
imshow(uint8(Y*256))
drawnow
warning on
