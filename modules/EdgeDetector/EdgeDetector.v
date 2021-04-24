module EdgeDetector
	#(
	parameter p_WIDTH = 1,
	parameter p_RISE_DETECTOR = 1	// (0 - fall detector, 1 - rise detector)
	)
	(
	input i_clk,
	input [p_WIDTH-1:0] iv_input,
	output [p_WIDTH-1:0] ov_output
	);

reg [p_WIDTH-1:0] rv_state = {p_WIDTH{p_RISE_DETECTOR > 0}};
reg [p_WIDTH-1:0] rv_output = 0;

assign ov_output = rv_output;

always@(posedge i_clk) begin
	rv_state <= iv_input;
	if(p_RISE_DETECTOR)
		rv_output <= ~rv_state & iv_input;
	else
		rv_output <= rv_state & ~iv_input;
end

endmodule
