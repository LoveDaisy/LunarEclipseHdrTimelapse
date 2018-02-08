clear; close all; clc;

work_path = '/Volumes/ZJJ-4TB/Photos/18.01.31 Lunar Eclipse by Wang Letian/timelapse/';
input_image_path = [work_path, 'tiff/'];
output_image_path = [work_path, 'tmp1/'];

files = dir([input_image_path, '*.tiff']);
total_images = length(files);
% total_images = 5;
img_trans = zeros(total_images, 2);
for i = 1:total_images
    fprintf('Reading image %s...\n', files(i).name);
    img = imread([input_image_path, files(i).name]);

    if exist('img_v1', 'var')
        img_v2 = img_v1;
    else
        img_v2 = [];
    end
    img_v1 = mean(im2double(img), 3);

    if isempty(img_v2)
        continue;
    end

    fprintf('Estimating translation between (%d,%d)/%d...\n', i, i-1, total_images);
    t = estimate_translation(img_v1, img_v2);
    img_trans(i, :) = t;
end
img_trans = cumsum(img_trans);

%%
t0 = mean(img_trans);
for i = 1:total_images
    fprintf('Reading image %s...\n', files(i).name);
    img = imread([input_image_path, files(i).name]);
    [~, fn, fe] = fileparts(files(i).name);

    img = imtranslate(img, (img_trans(i, :) - t0));
    fprintf('Writing image %s...\n', fn);
    imwrite(uint8(img/255), sprintf('%s%s%s', output_image_path, fn, ".jpg"));
end