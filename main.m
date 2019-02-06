clear all;

% Parameters (play around with different images and different parameters)
N = 400;
alpha = 0.1;
beta = 0.5;
gamma = 0.5;
kappa = 0.15;
Wline = 0.5;
Wedge = 1.0;
Wterm = 1.0;
sigma = 0.5;

% Load image
I = imread('images/square.jpg');
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);

% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrix(size(x,2), alpha, beta, gamma);

% Iterate and update positions
displaySteps = floor(N/10);
%[fx,fy]=gradient(Eext);
x=x';
y=y';
for i=1:N
    % Iterate
    hold all;
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);

    % Plot intermediate result
    imshow(I); 
    hold on;
    plot([x;x(1)], [y;y(1)], 'r');
    hold off;
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.0001)
 end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end