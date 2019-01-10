function [im_fix, im_float] = fix_image(image_in, image_out)
  im_rgb = imread(image_in);
  im_gray = rgb2gray(im_rgb);
  im_fix = imclose(im_gray, ones(8, 8));
  
  bg_close = imerode(imclose(im_gray, ones(2, 2)), ones(5, 5));
  bg_bw = im2bw(bg_close, double(mean(bg_close(:)) * 1) / 256);
  bg = im_gray;
  bg_border = im2bw(imfill(bg_close), 0.5);
  bg(not(bg_bw)) = mean(im_gray(:));
  bg(not(bg_bw)) = mean(bg(:));
  bg(not(bg_border)) = im_gray(not(bg_border));
  
  bg = imcomplement(bg);
  imshow(bg);

  hole_bw = im2bw(im_fix);
  im_fix = (im_gray + bg);
  im_fix(not(hole_bw)) = mean(im_gray(:)) + var(im_gray(:)) * 0.05;
  %im_float = double(im_fix);
  
  %[nn, xx] = hist(im_float);
  %[m, i] = second_max(max(nn'));
  
  %mid_val = xx(i);
  %min_val = max(0, mid_val - var(im_float(:)) * 0.25);
  %printf(" - min_val: %f\n", min_val);
  %max_val = min(min_val + var(im_float(:)) * 0.55, max(im_float(:)));
  
  %im_float = (im_float - min_val) ./ (max_val - min_val);
  %im_float = max(0, im_float);
  %im_fix = (uint8(im_float * 255));
  imwrite(im_fix, image_out);
endfunction