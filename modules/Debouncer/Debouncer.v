/////////////////////////////////////////////////////
//
//  A synchronous switch debouncer.
// 
/////////////////////////////////////////////////////

module Debouncer
	#(parameter p_CNT_WIDTH = 1)
	(
	input i_clk,
	input i_input,
	output o_output
	);

reg [p_CNT_WIDTH-1:0] rv_cnt = ~0;
reg r_output = 0;

wire w_eq = i_input == o_output;
wire w_cnt_full = &rv_cnt;

assign o_output = r_output;

always@(posedge i_clk) begin
	rv_cnt <= w_eq ? 0 : rv_cnt + 1;

	if(w_cnt_full)
		r_output <= i_input;
end

endmodule
