function MSRCP = MSRCP(image,sigmas,s1,s2)
%MSRCP offers an implementation of the MSRCR which is applied to the three
%intensity channels with chromacity preservation
%   ARGUMENTS:
%   	image: image to be modified
%   	sigmas: scales
%   	s1: percentage of clipping pixels for low values
%   	s2: percentage of clipping pixels for high values
%   OUTPUT:
%       output_image: modified image

% Initialization
[n_rows,n_columns,n_colors] = size(image);

% Computing the intensity channel
intensity = sum(image,3);

% Single scale retinex
diff = zeros(n_rows,n_columns,length(sigmas));
dim = 1;
for sigma = sigmas
    convoluted_image = convolution(intensity,sigma^2/2);
    diff(:,:,dim) = log(intensity)-log(convoluted_image);
    dim = dim + 1;
end

% Multiscale retinex
MSR = 1/3*sum(diff,3);

% Simplest color balance
intensity_balanced = simplest_color_balance(MSR,s1,s2);

% Computing the amplification factor
B = max(image,[],3);
A = min(255./B,intensity_balanced./intensity);
% Compute each color channel
MSRCP = zeros(n_rows,n_columns,n_colors);
for color=1:n_colors
    MSRCP(:,:,color) = A.*image(:,:,color);
end