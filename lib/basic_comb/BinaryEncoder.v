
// ==================================================================
//
// Binary encoder.
//
// Truth table for WIDTH = 5
// ----------------------------------
// | iv_input | o_enable |  ov_addr |
// ----------------------------------
// |    00000 |        0 |      000 |
// |    00001 |        1 |      000 |
// |    00010 |        1 |      001 |
// |    00100 |        1 |      010 |
// |    01000 |        1 |      011 |
// |    10000 |        1 |      100 |
// ----------------------------------
//
// ==================================================================
module BinaryEncoder
		#(
			parameter WIDTH = 2 // Must be greater than one.
		) (
			input [WIDTH - 1 : 0] iv_input,
			output o_enable, // Active HIGH
			output [ADDR_WIDTH - 1 : 0] ov_addr
		);

localparam ADDR_WIDTH = $clog2(WIDTH);

// TODO: Check for any difference in LUT consumption.

assign o_enable = |ov_addr | iv_input[0];
//assign o_enable = |iv_input;

generate

	genvar i;
	genvar j;
	
	for(i = 0; i < ADDR_WIDTH; i = i + 1) begin : iterate_addr
	
		wire [WIDTH-1:0] wv_p;
		
		for(j = 0; j < WIDTH; j = j + 1) begin : gen_out
			assign wv_p[j] = ((j >> i) % 2) ? iv_input[j] : 1'b0;
		end
		
		assign ov_addr[i] = |wv_p;
		
	end
	
endgenerate

endmodule // BinaryEncoder

