/////////////////////////////////////////////////////
// 
// The module translates Reflected Binary Code (RBC)
// aka Gray code to Binary Positional Code.
//
/////////////////////////////////////////////////////

`define RBC2BIN_SEQUENTAL

module Rbc2Bin
	#(
	parameter p_WIDTH = 1 // io vectors width. MUST BE greater than zero.
	)
	
	(
	input wire  [p_WIDTH - 1 : 0] iwv_rbc,
	output wire [p_WIDTH - 1 : 0] owv_bin
	);
	
	genvar i;
	
`ifdef RBC2BIN_SEQUENTAL

	assign owv_bin[p_WIDTH - 1] = iwv_rbc[p_WIDTH - 1];
	
	for(i = 0; i < p_WIDTH - 1; i = i + 1) begin // TODO: find out why 'i++' makes iverilog unhappy but 'i = i + 1' works just fine.
		assign owv_bin[i] = iwv_rbc[i] ^ owv_bin[i + 1];
	end		
	
`else

	for(i = 0; i < p_WIDTH; i = i + 1) begin
		assign owv_bin[i] = ^iwv_rbc[p_WIDTH - 1 : i];
	end
	
`endif //  RBC2BIN_SEQUENTAL
	
endmodule // Rbc2Bin




/////////////////////////////////////////////////////
// 
// The module translates Binary Positional Code
// to Reflected Binary Code (RBC) aka Gray code.
//
/////////////////////////////////////////////////////

module Bin2Rbc
	#(
	parameter p_WIDTH = 1 // io vectors width. MUST BE greater than zero.
	)
	
	(
	input wire  [p_WIDTH - 1 : 0] iwv_bin,
	output wire [p_WIDTH - 1 : 0] owv_rbc
	);
	
	assign owv_rbc[p_WIDTH - 1] = iwv_bin[p_WIDTH - 1];

	genvar i;	
	for(i = 0; i < p_WIDTH - 1; i = i + 1) begin
		assign owv_rbc[i] = iwv_bin[i] ^ iwv_bin[i + 1];
	end		
	
endmodule // Bin2Rbc

