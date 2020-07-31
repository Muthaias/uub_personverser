function loop_images(from, to, inpath_template, outpath_template)
  for i = from:to
    fpath = sprintf(inpath_template, i);
    tpath = sprintf(outpath_template, i);
    printf("%s\n", fpath);
    fix_image(fpath, tpath);
  endfor
endfunction
