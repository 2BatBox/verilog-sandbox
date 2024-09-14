module EdgeDetector
	#(
	parameter integer WIDTH = 1,
	parameter [0:0] RISE_DETECTOR = 1'b1  // (0 - fall detector, 1 - rise detector)
	)
	(
	input i_clk,
	input [WIDTH-1:0] iv_input,
	output [WIDTH-1:0] ov_output
	);

reg [WIDTH-1:0] rv_state = {WIDTH{RISE_DETECTOR}};
reg [WIDTH-1:0] rv_output = 0;

assign ov_output = rv_output;

always@(posedge i_clk) begin
	rv_state <= iv_input;
	if(RISE_DETECTOR)
		rv_output <= ~rv_state & iv_input;
	else
		rv_output <= rv_state & ~iv_input;
end

endmodule
