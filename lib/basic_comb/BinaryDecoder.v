// ==================================================================
//
// Binary decoder.
// 
// Truth table for WIDTH = 5
// ----------------------------------
// | iv_addr | i_enable | ov_output |
// ----------------------------------
// |     xxx |        0 |     00000 | 
// |     000 |        1 |     00001 |
// |     001 |        1 |     00010 |
// |     010 |        1 |     00100 |
// |     011 |        1 |     01000 |
// |     100 |        1 |     10000 |
// |     101 |        1 |     00000 |
// |     110 |        1 |     00000 |
// |     111 |        1 |     00000 |
// ----------------------------------
//
// ==================================================================
module BinaryDecoder 
		#(
			parameter WIDTH = 2 // Must be greater than one.
		) (
			input [ADDR_WIDTH - 1 : 0] iv_addr,
			input i_enable,
			output [WIDTH - 1 : 0] ov_output
		);

localparam ADDR_WIDTH = $clog2(WIDTH);

generate

	genvar i;
	
	for(i = 0; i < WIDTH; i = i + 1) begin : gen_out
		assign ov_output[i] = (iv_addr == i) & i_enable;
	end
	
endgenerate

endmodule // BinaryDecoder


