/////////////////////////////////////////////////////
//
//  A synchronization chain.
// 
/////////////////////////////////////////////////////

module SyncChain
	#(parameter p_WIDTH = 1)
	(
	input i_clk,
	input [p_WIDTH-1:0] iv_input,
	output [p_WIDTH-1:0] ov_output
	);

reg [p_WIDTH-1:0] rv_step0;
reg [p_WIDTH-1:0] rv_step1;

assign ov_output = rv_step1;

always@(posedge i_clk) begin
	rv_step0 <= iv_input;
	rv_step1 <= rv_step0;
end

endmodule
