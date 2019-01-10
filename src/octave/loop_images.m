function loop_images(from, to)
  for i = from:to
    fpath = sprintf("../../verser/%d.jpg", i);
    tpath = sprintf("../../fix_verser/%d.png", i);
    printf("%s\n", fpath);
    fix_image(fpath, tpath);
  endfor
endfunction
