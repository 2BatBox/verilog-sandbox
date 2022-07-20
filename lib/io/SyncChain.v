/////////////////////////////////////////////////////
//
//  A synchronization chain.
// 
/////////////////////////////////////////////////////

module SyncChain
	#(
		parameter p_WIDTH = 1,
		parameter p_DEPTH = 2
	)
	
	(
		input wire iw_clk,
		input wire iw_reset,
		input wire [p_WIDTH - 1 : 0] iwv_input,
		output wire [p_WIDTH - 1 : 0] owv_output
	);
	
	reg [p_WIDTH - 1 : 0] rvv_chain[0 : p_DEPTH];

	assign owv_output = rvv_chain[p_DEPTH - 1];
	
	always@(posedge iw_clk) begin
		rvv_chain[0] <= iw_reset ? 0 : iwv_input;
	end
	
	// TODO: are there any differences in generating many always blocks with the same trigger condition and generating just one?
	genvar i;
	generate
		for(i = 1; i < p_DEPTH; i = i + 1) begin : gen_for
			always@(posedge iw_clk) begin
				rvv_chain[i] <= iw_reset ? 0 : rvv_chain[i - 1];
			end
		end	
	endgenerate

endmodule // SyncChain

