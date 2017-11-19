function output_MSRCR = simplest_color_balance(MSRCR,s1,s2)
%SIMPLEST_COLOR_BALANCE balances the color of the image MSRCR by cliping a
%certain percentage of pixels
%   ARGUMENTS:
%   	MSRCR: image to be color balances
%   	s1: percentage of clipping pixels for low values
%   	s2: percentage of clipping pixels for high values
%   OUTPUT:
%       output_MSRCR: balanced image

% Cliping the extreme pixels
s_min = prctile(MSRCR(:),s1);
s_max = prctile(MSRCR(:),100-s2);

% Simplest color balancing
output_MSRCR = 255*(MSRCR-s_min)/(s_max-s_min);
output_MSRCR(MSRCR<=s_min) = 0;
output_MSRCR(MSRCR>=s_max) = 255;