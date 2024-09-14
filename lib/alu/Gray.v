/////////////////////////////////////////////////////
// 
// Gray to Binary Positional Code translator.
//
/////////////////////////////////////////////////////

`define GRAY2BIN_SEQUENTAL

module Gray2Bin
	#(
		parameter WIDTH = 1 // The data bus width. MUST BE greater than zero.
	)
	
	(
		input wire  [WIDTH - 1 : 0] iwv_gray,
		output wire [WIDTH - 1 : 0] owv_bin
	);
	
	genvar i;
	
`ifdef GRAY2BIN_SEQUENTAL

	assign owv_bin[WIDTH - 1] = iwv_gray[WIDTH - 1];
	generate
		for(i = 0; i < WIDTH - 1; i = i + 1) begin : gen_for // TODO: find out why 'i++' makes iverilog unhappy but 'i = i + 1' works just fine.
			assign owv_bin[i] = iwv_gray[i] ^ owv_bin[i + 1];
		end
	endgenerate	
	
`else

	generate
		for(i = 0; i < WIDTH; i = i + 1) begin : gen_for
			assign owv_bin[i] = ^iwv_gray[WIDTH - 1 : i];
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
		parameter WIDTH = 1 // The data bus width. MUST BE greater than zero.
	)
	
	(
		input wire [WIDTH - 1 : 0] iwv_bin,
		output wire [WIDTH - 1 : 0] owv_gray
	);
	
	assign owv_gray[WIDTH - 1] = iwv_bin[WIDTH - 1];

	genvar i;
	generate
		for(i = 0; i < WIDTH - 1; i = i + 1) begin : gen_for
			assign owv_gray[i] = iwv_bin[i] ^ iwv_bin[i + 1];
		end
	endgenerate
	
endmodule // Bin2Gray



/////////////////////////////////////////////////////
// 
// Gray synchronous incremental counter.
//
/////////////////////////////////////////////////////

module GrayIncCounter
	#(
		parameter WIDTH = 1 // The data bus width. MUST BE greater than zero.
	)
	
	(
		input wire iw_clk,
		input wire iw_reset,
		input wire iw_inc,
		output wire [WIDTH - 1 : 0] owv_bin,
		output wire [WIDTH - 1 : 0] owv_gray
	);
	
	reg [WIDTH - 1 : 0] rv_gray;
	wire [WIDTH - 1 : 0] wv_gray_next;
	wire [WIDTH - 1 : 0] wv_bin_next = owv_bin + iw_inc;
	
	assign owv_gray = rv_gray;
	
	Bin2Gray #(.WIDTH(WIDTH)) bin2gray (wv_bin_next, wv_gray_next);
	Gray2Bin #(.WIDTH(WIDTH)) grey2bin (rv_gray, owv_bin);
	
	always@(posedge iw_clk) begin
		rv_gray <= iw_reset ? 0 : wv_gray_next;
	end
	
endmodule // GrayIncCounter
	
