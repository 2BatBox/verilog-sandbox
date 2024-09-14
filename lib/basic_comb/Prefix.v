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
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);

__GenericPrefixReferenceXor #(.WIDTH(WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // __PrefixReferenceXor


module PrefixXor
	#(
	parameter WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);
	
GenericPrefixXor #(.WIDTH(WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

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
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);

__GenericPrefixReferenceAnd #(.WIDTH(WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // __PrefixReferenceAnd


module PrefixAnd
	#(
	parameter WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);
	
GenericPrefixAnd #(.WIDTH(WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

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
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);

__GenericPrefixReferenceOr #(.WIDTH(WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // __PrefixReferenceOr


module PrefixOr
	#(
	parameter WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);
	
GenericPrefixOr #(.WIDTH(WIDTH)) impl(.iwv_in(iwv_in), .owv_out(owv_out));	

endmodule // PrefixOr
