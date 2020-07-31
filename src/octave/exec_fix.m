arg_list = argv();
script_path = fileparts(mfilename("fullpath"));
addpath(script_path);
pkg load image;

if (length(arg_list) < 2)
	printf("Wrong number of arguments");
	exit();
else
	fix_image(arg_list{1}, arg_list{2});
end


