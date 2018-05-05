function i_new=LCS(itemp)
% clear all;
% clc;

i = itemp(:,:,1);
rtemp = min(i);         % find the min. value of pixels in all the columns (row vector)
rmin = min(rtemp);      % find the min. value of pixel in the image
rtemp = max(i);         % find the max. value of pixels in all the columns (row vector)
rmax = max(rtemp);      % find the max. value of pixel in the image
m = 255/(rmax - rmin);  % find the slope of line joining point (0,255) to (rmin,rmax)
c = 255 - m*rmax;       % find the intercept of the straight line with the axis
i_new = m*i + c;        % transform the image according to new slope
% figure,imshow(i);       % display original image
% figure,imshow(i_new);   % display transformed image
end