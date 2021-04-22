/////////////////////////////////////////////////////
//
//  A synchronous switch debouncer.
// 
/////////////////////////////////////////////////////

module Debouncer
	#(parameter p_INPUT_WIDTH = 1, parameter p_CNT_WIDTH = 1)
	(
	input i_clk,
	input [p_INPUT_WIDTH-1:0] iv_input,
	output [p_INPUT_WIDTH-1:0] ov_output
	);

reg [p_CNT_WIDTH-1:0] rv_cnt = ~0;
reg [p_INPUT_WIDTH-1:0] rv_output = 0;

wire w_eq = iv_input == ov_output;
wire w_cnt_full = &rv_cnt;

assign ov_output = rv_output;

always@(posedge i_clk) begin
	rv_cnt <= w_eq ? 0 : rv_cnt + 1;

	if(w_cnt_full)
		rv_output <= iv_input;
end

endmodule
