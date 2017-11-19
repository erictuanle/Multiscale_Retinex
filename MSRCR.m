function output_image = MSRCR(image,sigmas,s1,s2)
%MSRCR offers an implementation of the MSRCR proposed by Jobson et al.
%which is applied to the three color channels with color restoration
%   ARGUMENTS:
%   	image: image to be modified
%   	sigmas: scales
%   	s1: percentage of clipping pixels for low values
%   	s2: percentage of clipping pixels for high values
%   OUTPUT:
%       output_image: modified image

% Initialization
[n_rows,n_columns,n_colors] = size(image);
output_image = zeros(n_rows,n_columns,n_colors);

% Loop for each colors
for color = 1:n_colors
    diff = zeros(n_rows,n_columns,length(sigmas));
    dim = 1;
    % Loop for each scales
    for sigma = sigmas
        % Single scale retinex
        convoluted_image = convolution(image(:,:,color),sigma*2/2);
        diff(:,:,dim) = log(image(:,:,color))-log(convoluted_image);
        dim = dim + 1;
    end
    % Multiscale retinex
    MSR = 1/3*sum(diff,3);
    % Color restauration
    MSRCR = MSR.*(log(125*image(:,:,color))-log(sum(image,3)));
    output_image(:,:,color) = simplest_color_balance(MSR,s1,s2);
end