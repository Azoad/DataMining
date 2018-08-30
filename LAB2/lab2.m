clc;
% reading test images
tr_img_1 = imread('apple1-000-000.png');
tr_img_2 = imread('apple1-022-000.png');

% converting to gray scale image
gr_img_1 = im2double(rgb2gray(tr_img_1));
gr_img_2 = im2double(rgb2gray(tr_img_2));

% mean and standard deviation of training image
mean_img_1 = mean(gr_img_1(:));
std_img_1 = std(gr_img_1(:));
mean_img_2 = mean(gr_img_2(:));
std_img_2 = std(gr_img_2(:));

% test image
test_img = imread('apple10-000-000.png');
gr_test_img = im2double(rgb2gray(test_img));
mean_test_img = mean(gr_test_img(:));
std_test_img = std(gr_test_img(:));

% cityblock distance
cityblock_1 = abs(mean_img_1 - mean_test_img) + abs(std_img_1 - std_test_img);
cityblock_2 = abs(mean_img_2 - mean_test_img) + abs(std_img_2 - std_test_img);

% comparison

if(cityblock_1<cityblock_2)
    fprintf('Test image 1 is more similar\n')
else
    fprintf('Test image 2 is more similar\n')
end