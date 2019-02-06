
function [x, y] = initializeSnake(I)

% Show figure

figure;
imshow(I)

height=size(I,1);
width=size(I,2);
% Get initial points
[x,y]=getpts();

x=x';
y=y';

xy=[x;y];
pts=[x(1);y(1)];
xy=[xy,pts];
coord = 1:length(xy);
query_pts = 1:0.1:length(xy);
interpolated_pts = spline(coord,xy,query_pts);
x = interpolated_pts(1,:);
y = interpolated_pts(2,:);

plot(x,y,'-b','LineWidth',2);

for i=1:x
    for j=1:y
        x=(x.*(x>1)) + (x<1);
        y=(y.*(y>1)) + (y<1);
        x=(x.* (x < (width-1))) + ((x >(width-1)) .* (width-1));
        y=(y.* (y < (height-1))) + ((y > (height-1)).*(height-1));
    end
end



end

