function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)

Image=I;
[h,w] = size(Image);
% Eline
Eline=Image;

% Eedge

[Gy,Gx] = imgradient(Image,'central');
Eedge=Gy;


% Eterm

cx = conv2(Image,[-1 1],'same');
cy = conv2(Image,[-1;1],'same');
cxx = conv2(Image,[1 -2 1],'same');
cyy = conv2(Image,[1;-2;1],'same');
cxy = conv2(Image,[1 -1;-1 1],'same');

for i = 1:h  
    for j= 1:w
        Eterm(i,j) = (cyy(i,j)*cx(i,j)*cx(i,j) -2 *cxy(i,j)*cx(i,j)*cy(i,j) + cxx(i,j)*cy(i,j)*cy(i,j))/((1+cx(i,j)*cx(i,j) + cy(i,j)*cy(i,j))^1.5);
    end
end

% Eext
Eext=Wline.*Eline + Wedge.*Eedge + Wterm.*Eterm;
figure;
imshow(Eext)
end

