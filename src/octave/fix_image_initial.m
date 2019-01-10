function [im_fix, im_float] = fix_image_initial(image_in, image_out)
  im_rgb = imread(image_in);
  im_gray = rgb2gray(im_rgb);
  im_fix = imclose(im_gray, ones(8, 8));
  %bg = imfilter(im_gray, ones(50, 50) ./ (50*50));
  %bg = imcomplement(max(im_gray, (mean(im_gray(:))/255.0) * im_fix));
  bg = imcomplement(medfilt2(im_gray, [20 20]));
  im_fix = im_fix - (im_gray + bg);
  im_float = double(im_fix);
  [nn, xx] = hist(im_float);
  [m, i] = second_max(max(nn'));
  mid_val = xx(i);
  min_val = max(0, mid_val - var(im_float(:)) * 0.75);
  %min_val = min(im_float(:));
  printf(" - min_val: %f\n", min_val);
  max_val = mid_val + var(im_float(:)) * 0.1;
  %max_val = max(im_float(:));
  %min_val = median(im_float(:)) + var(im_float(:)) * 0.025;
  %max_val = median(im_float(:)) + var(im_float(:)) * 0.075;
  im_float = (im_float - min_val) ./ (max_val - min_val);
  im_float = max(0, im_float);
  im_fix = imcomplement(uint8(im_float * 255));
  imwrite(im_fix, image_out);
endfunction