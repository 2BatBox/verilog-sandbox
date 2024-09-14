/////////////////////////////////////////////////////
//
//  A synchronization chain.
// 
/////////////////////////////////////////////////////

module SyncChain
	#(
		parameter WIDTH = 1,
		parameter DEPTH = 2,
		parameter INIT_VALUE = 0
	)
	
	(
		input wire i_clk,
		input wire [WIDTH - 1 : 0] iv_input,
		output wire [WIDTH - 1 : 0] ov_output
	);
	
	reg [WIDTH - 1 : 0] rvv_chain[0 : DEPTH];
	
	assign ov_output = rvv_chain[DEPTH - 1];
	
	// Generating the chain items initialization.
	genvar i;
	generate
		for(i = 0; i < DEPTH; i = i + 1) begin
			initial begin
				rvv_chain[i] = INIT_VALUE;
			end
		end	
	endgenerate
	
	// Generating the chain items shifting.
	generate
		for(i = 1; i < DEPTH; i = i + 1) begin : gen_for
			always@(posedge i_clk) begin
				rvv_chain[i] <= rvv_chain[i - 1];
			end
		end	
	endgenerate

	always@(posedge i_clk) begin
		rvv_chain[0] <= iv_input;
	end
	
	

endmodule // SyncChain

