/////////////////////////////////////////////////////
// 
// Gray to Binary Positional Code translator.
//
/////////////////////////////////////////////////////

`define GRAY2BIN_SEQUENTAL

module Gray2Bin
	#(
	parameter p_WIDTH = 1 // The data bus width. MUST BE greater than zero.
	)
	
	(
	input wire  [p_WIDTH - 1 : 0] iwv_gray,
	output wire [p_WIDTH - 1 : 0] owv_bin
	);
	
	genvar i;
	
`ifdef GRAY2BIN_SEQUENTAL

	assign owv_bin[p_WIDTH - 1] = iwv_gray[p_WIDTH - 1];
	generate
		for(i = 0; i < p_WIDTH - 1; i = i + 1) begin : gen_for // TODO: find out why 'i++' makes iverilog unhappy but 'i = i + 1' works just fine.
			assign owv_bin[i] = iwv_gray[i] ^ owv_bin[i + 1];
		end
	endgenerate	
	
`else

	generate
		for(i = 0; i < p_WIDTH; i = i + 1) begin : gen_for
			assign owv_bin[i] = ^iwv_gray[p_WIDTH - 1 : i];
		end
	endgenerate
	
`endif //  GRAY2BIN_SEQUENTAL
	
endmodule // Gray2Bin




/////////////////////////////////////////////////////
// 
// Binary Positional Code to Gray code translator.
//
/////////////////////////////////////////////////////

module Bin2Gray
	#(
	parameter p_WIDTH = 1 // The data bus width. MUST BE greater than zero.
	)
	
	(
	input wire [p_WIDTH - 1 : 0] iwv_bin,
	output wire [p_WIDTH - 1 : 0] owv_gray
	);
	
	assign owv_gray[p_WIDTH - 1] = iwv_bin[p_WIDTH - 1];

	genvar i;
	generate
		for(i = 0; i < p_WIDTH - 1; i = i + 1) begin : gen_for
			assign owv_gray[i] = iwv_bin[i] ^ iwv_bin[i + 1];
		end
	endgenerate
	
endmodule // Bin2Gray

