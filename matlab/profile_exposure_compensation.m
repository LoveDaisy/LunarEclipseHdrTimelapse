clear; clc; close all;


work_path = '/Volumes/ZJJ-4TB/Photos/18.01.31 Lunar Eclipse by Wang Letian/';
input_image_path = [work_path, '02/'];

img = im2double(imread([input_image_path, 'IMG_20687.ppm']));
img = exposure_compensation(img, 0.7);

figure(1); clf;
imshow(img);