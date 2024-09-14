
// ==================================================================
//
// Binary priority encoder.
//
// Truth table for WIDTH = 5
// ----------------------------------
// | iv_input | o_enable |  ov_addr |
// ----------------------------------
// |    00000 |        0 |      000 |
// |    00001 |        1 |      000 |
// |    0001x |        1 |      001 |
// |    001xx |        1 |      010 |
// |    01xxx |        1 |      011 |
// |    1xxxx |        1 |      100 |
// ----------------------------------
//
// ==================================================================
module BinaryProirityEncoder
		#(
			parameter WIDTH = 5 // Must be greater than one.
		) (
			input [WIDTH - 1 : 0] iv_input,
			output o_enable,
			output [ADDR_WIDTH - 1 : 0] ov_addr
		);

localparam ADDR_WIDTH = $clog2(WIDTH);

assign o_enable = |ov_addr | iv_input[0];

generate

	genvar i;
	genvar j;
	
	for(i = 0; i < ADDR_WIDTH; i = i + 1) begin : iterate_addr
	
		wire [WIDTH-1:0] wv_en;
		wire [WIDTH-1:0] wv_p;
		
		for(j = 0; j < WIDTH; j = j + 1) begin : gen_out
			if(j + 1 < WIDTH) begin
				assign wv_en[j] = ~(|iv_input[WIDTH-1: j+1]);
				assign wv_p[j] = ((j >> i) % 2) ? (iv_input[j] & wv_en[j]) : 1'b0;
			end else begin
				assign wv_p[j] = ((j >> i) % 2) ? iv_input[j] : 1'b0;
			end
		end
		
		assign ov_addr[i] = |wv_p;
		
	end
	
endgenerate

endmodule // BinaryProirityEncoder

