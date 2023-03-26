//===================================================
//
// __ParityPrexixReference
// 
// Size  : O(N)
// Depth : O(N)
//
//===================================================
module __ParityPrexixReference
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
generate

	genvar i;

	if(p_WIDTH > 0) begin
	
		assign owv_out[0] = iwv_in[0];

		for(i = 1; i < p_WIDTH; i = i + 1) begin : gen_prefix
			assign owv_out[i] = iwv_in[i] ^ owv_out[i - 1];
		end
	
	end

endgenerate

endmodule // __ParityPrexixReference




//===================================================
//
// ParityPrefix
// 
// Size  : O(N)
// Depth : O(log(N))
//
//===================================================
module ParityPrefix
	#(
	parameter p_WIDTH = 2, // MUST BE greater than zero.
	parameter p_BLOCK_SIZE = 1   // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
generate

	genvar i;

	if(p_BLOCK_SIZE >= p_WIDTH) begin
	
		assign owv_out = iwv_in;
		
	end else begin
	
		wire [p_WIDTH-1:0] wv_next;
		
		for(i = 0; i < p_WIDTH; i = i + 1) begin : gen_prefix
			localparam block_idx = (i / p_BLOCK_SIZE);
			if((block_idx % 2) == 0) begin
				assign wv_next[i] = iwv_in[i];
			end else begin
				assign wv_next[i] = iwv_in[i] ^ iwv_in[block_idx * p_BLOCK_SIZE - 1];
			end
		end
			
		ParityPrefix #(.p_WIDTH(p_WIDTH), .p_BLOCK_SIZE(p_BLOCK_SIZE * 2)) prefix_tree_0(wv_next, owv_out);
		
	end

endgenerate

endmodule // ParityPrefix
