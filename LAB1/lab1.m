% taking image as input
i = imread('apple1-000-000.png');
% displaying the image
% subplot(2,2,1),imshow(i);

% seperating channels
imred = i(:,:,1);
% subplot(2,2,2),imshow(imred);
imgreen = i(:,:,2);
% subplot(2,2,3),imshow(imgreen);
imblue = i(:,:,3);
% subplot(2,2,4),imshow(imblue);

% normalizing values
% figure
nimred = im2double(imred);
% subplot(1,3,1),imshow(nimred);
nimgreen = im2double(imgreen);
% subplot(1,3,2),imshow(nimgreen);
nimblue = im2double(imblue);
% subplot(1,3,3),imshow(nimblue);

% max and min
maxred = max(nimred(:));
maxgreen = max(nimgreen(:));
maxblue = max(nimblue(:));

minred = min(nimred(:));
mingreen = min(nimgreen(:));
minblue = min(nimblue(:));

% mean
meanred = mean(nimred(:));
meangreen = mean(nimgreen(:));
meanblue = mean(nimblue(:));

% median
medianred = median(nimred(:));
mediangreen = median(nimgreen(:));
medianblue = median(nimblue(:));

% range
rangered = range(nimred(:));
rangegreen = range(nimgreen(:));
rangeblue = range(nimblue(:));

% standard deviation
stdred = std(nimred(:));
stdgreen = std(nimgreen(:));
stdblue = std(nimblue(:));

% midrange
midred = (maxred+minred)/2;
midgreen = (maxgreen+mingreen)/2;
midblue = (maxblue+minblue)/2;