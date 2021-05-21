#!/usr/bin/env python3

# Include standard modules
import sys
import os

INCLUDE_DIR = "../lib";
BUILD_DIR = "./_build";
CURRENT_DIR = os.getcwd();

os.system("mkdir -p " + BUILD_DIR);

for path in sys.argv[1:]:
	os.chdir(CURRENT_DIR);

	file_name = os.path.basename(path);
	dir_name = os.path.dirname(path);
	output_dir_name = BUILD_DIR + "/" + dir_name;
	vvp_name = file_name + ".vvp";
	vcd_name = file_name + ".vcd";
	output_vvp = output_dir_name + "/" + vvp_name;
	output_vcd = output_dir_name + "/" + vcd_name;

	os.system("mkdir -p " + output_dir_name);

	cmd_iverilog = "iverilog";
	cmd_iverilog += " -I " + INCLUDE_DIR
	cmd_iverilog += " -o " + output_vvp;
	cmd_iverilog += " " + path;
	print(cmd_iverilog);
	if(os.system(cmd_iverilog) == 0):
		os.chdir(output_dir_name);
		os.system("./" + vvp_name);
		os.chdir(".");
