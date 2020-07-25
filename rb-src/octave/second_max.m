function [m, i] = second_max(d)
  [fm, fi] = max(d);
  d(fi) = min(d);
  [m, i] = max(d);
endfunction
