//===================================================
//
// Xor
//
//===================================================

`define PRIFIX_NAME Xor
`define PRIFIX_OPERATION ^
`include "lib/basic_comb/PrefixGeneric.v"

module __PrefixReferenceXor
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);

__GenericPrefixReferenceXor #(.p_WIDTH(p_WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // __PrefixReferenceXor


module PrefixXor
	#(
	parameter p_WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
GenericPrefixXor #(.p_WIDTH(p_WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // PrefixXor


//===================================================
//
// And
//
//===================================================

`define PRIFIX_NAME And
`define PRIFIX_OPERATION &
`include "lib/basic_comb/PrefixGeneric.v"

module __PrefixReferenceAnd
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);

__GenericPrefixReferenceAnd #(.p_WIDTH(p_WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // __PrefixReferenceAnd


module PrefixAnd
	#(
	parameter p_WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
GenericPrefixAnd #(.p_WIDTH(p_WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // PrefixAnd

//===================================================
//
// Or
//
//===================================================

`define PRIFIX_NAME Or
`define PRIFIX_OPERATION |
`include "lib/basic_comb/PrefixGeneric.v"

module __PrefixReferenceOr
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);

__GenericPrefixReferenceOr #(.p_WIDTH(p_WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // __PrefixReferenceOr


module PrefixOr
	#(
	parameter p_WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
GenericPrefixOr #(.p_WIDTH(p_WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // PrefixOr
