function convoluted_image = convolution(image,sigma2)
%SIMPLEST_COLOR_BALANCE balances the color of the image MSRCR by cliping a
%certain percentage of pixels
%   ARGUMENTS:
%   	image: image to be convoluted with the gaussian
%   	sigma: scale of the gaussian
%   OUTPUT:
%       convoluted_image: convoluted image

% Initialization
[n_rows,n_columns] = size(image);

% Quadruplicating by symmetrization the image
image = [image,image(:,end:-1:1); 
    image(end:-1:1,:),image(end:-1:1,end:-1:1)];

% Computing the FFT of the modified image
fft_image = fftshift(fft2(image(:,:)));

% Multiplying the fft by the FT of the Gaussian
[frequencies_x,frequencies_y] = meshgrid(1:2*n_columns,1:2*n_rows);
frequencies_x = frequencies_x - (n_columns+1);
frequencies_y = frequencies_y - (n_rows+1);
frequencies_x = frequencies_x*pi/n_columns;
frequencies_y = frequencies_y*pi/n_rows;
fft_gaussian = exp(-sigma2*(frequencies_x.^2+frequencies_y.^2));
product_fft = fft_image.*fft_gaussian;

% Computing the IFFT of the product
convoluted_image = real(ifft2(ifftshift(product_fft)));

% Restricting the image to its domain
convoluted_image = convoluted_image(1:n_rows,1:n_columns);
