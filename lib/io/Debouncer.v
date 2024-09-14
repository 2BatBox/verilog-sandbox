/////////////////////////////////////////////////////
//
//  A synchronous switch debouncer.
//
/////////////////////////////////////////////////////

module Debouncer
	#(
	parameter integer WIDTH = 1,          // The input/output vector width.
	parameter integer CNT_WIDTH = 1,      // The counter width. The tolerance period is 2^CNT_WIDTH.
	parameter [WIDTH-1:0] INIT_VALUE = 0  // The value that ov_output takes before the very first clock cycle happens.
	)

	(
	input i_clk,                  // Clock signal.
	input [WIDTH-1:0] iv_input,   // Input value.
	output [WIDTH-1:0] ov_output  // The output value cannot change more than once per the tolerance period.
	);

reg [CNT_WIDTH-1:0] rv_cnt = ~0;
reg [WIDTH-1:0] rv_output = {WIDTH{INIT_VALUE}};

wire w_eq = iv_input == ov_output;
wire w_cnt_full = &rv_cnt;

assign ov_output = rv_output;

always@(posedge i_clk) begin
	rv_cnt <= w_eq ? 0 : rv_cnt + 1;

	if(w_cnt_full)
		rv_output <= iv_input;
end

endmodule
