arg_list = argv();
script_path = fileparts(mfilename("fullpath"));
addpath(script_path);
pkg load image;

start = 1;
if (length(arg_list) > 0)
	start = str2num(arg_list{1});
end

stop = start;
if (length(arg_list) > 1)
	stop = str2num(arg_list{2});
end

inpath_root = "./verser";
outpath_root = "./fix_verser";
if (length(arg_list) > 2)
	inpath_root = arg_list{3};
end
if (length(arg_list) > 3)
	outpath_root = arg_list{4};
end

inpath_template = strcat(inpath_root, "/%d.jpg");
outpath_template = strcat(outpath_root, "/%d.png");

printf("Processing image: %d %d\n", start, stop);
loop_images(start, stop, inpath_template, outpath_template);
