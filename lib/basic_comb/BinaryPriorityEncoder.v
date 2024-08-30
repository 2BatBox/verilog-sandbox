
// ==================================================================
//
// Binary priority encoder.
//
// Truth table for p_WIDTH = 5
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
			parameter p_WIDTH = 5 // Must be greater than one.
		) (
			input [p_WIDTH - 1 : 0] iv_input,
			output o_enable,
			output [p_ADDR_WIDTH - 1 : 0] ov_addr
		);

localparam p_ADDR_WIDTH = $clog2(p_WIDTH);

assign o_enable = |ov_addr | iv_input[0];

generate

	genvar i;
	genvar j;
	
	for(i = 0; i < p_ADDR_WIDTH; i = i + 1) begin : iterate_addr
	
		wire [p_WIDTH-1:0] wv_p_en;
		wire [p_WIDTH-1:0] wv_p;
		
		for(j = 0; j < p_WIDTH; j = j + 1) begin : gen_out
			if(j + 1 < p_WIDTH) begin
				assign wv_p_en[j] = ~(|iv_input[p_WIDTH-1: j+1]);
				assign wv_p[j] = ((j >> i) % 2) ? (iv_input[j] & wv_p_en[j]) : 1'b0;
			end else begin
				assign wv_p[j] = ((j >> i) % 2) ? iv_input[j] : 1'b0;
			end
		end
		
		assign ov_addr[i] = |wv_p;
		
	end
	
endgenerate

endmodule // BinaryProirityEncoder

