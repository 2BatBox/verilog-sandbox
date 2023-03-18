/////////////////////////////////////////////////////
//
//  A synchronization chain.
// 
/////////////////////////////////////////////////////

module SyncChain
	#(
		parameter p_WIDTH = 1,
		parameter p_DEPTH = 2,
		parameter p_INIT_VALUE = 0
	)
	
	(
		input wire iw_clk,
		input wire [p_WIDTH - 1 : 0] iwv_input,
		output wire [p_WIDTH - 1 : 0] owv_output
	);
	
	reg [p_WIDTH - 1 : 0] rvv_chain[0 : p_DEPTH];
	
	assign owv_output = rvv_chain[p_DEPTH - 1];
	
	// Generating the chain items initialization.
	genvar i;
	generate
		for(i = 0; i < p_DEPTH; i = i + 1) begin
			initial begin
				rvv_chain[i] = p_INIT_VALUE;
			end
		end	
	endgenerate
	
	// Generating the chain items shifting.
	generate
		for(i = 1; i < p_DEPTH; i = i + 1) begin : gen_for
			always@(posedge iw_clk) begin
				rvv_chain[i] <= rvv_chain[i - 1];
			end
		end	
	endgenerate

	always@(posedge iw_clk) begin
		rvv_chain[0] <= iwv_input;
	end
	
	

endmodule // SyncChain

