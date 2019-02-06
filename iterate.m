function [newX, newY] = iterate(Ainv,x,y, Eext, gamma, kappa)

% Get fx and fy
[fx,fy]=gradient(Eext);

% Iterate
newX = Ainv* (gamma*x - kappa*interp2(fx,x,y,'linear'));
newY = Ainv * (gamma*y - kappa*interp2(fy,x,y,'linear'));

% Clamp to image size
height=size(fx,1);
width=size(fx,2);

%newX=newX';
%newY=newY';

for i=1:height
    for j=1:width
        newX=(newX.*(newX>1)) + (newX<1);
        newY=(newY.*(newY>1)) + (newY<1);
        newX=(newX.* (newX < (width-1))) + ((newX >(width-1)) .* (width-1));
        newY=(newY.* (newY < (height-1))) + ((newY > (height-1)).*(height-1));
    end
end

end

