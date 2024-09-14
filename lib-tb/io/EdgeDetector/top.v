`include "lib-tb/assert.v"
`include "lib/io/EdgeDetector.v"

module top();

parameter CLOCK_PERIOD = 1;

reg r_clk = 0;
reg r_input = 0;
wire w_output;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

EdgeDetector #(.RISE_DETECTOR(0)) uut(r_clk, r_input, w_output);

initial begin
	repeat(10) begin
		@(negedge r_clk);
		@(negedge r_clk);
		r_input = ~r_input;
	end
	#10;
	`assert_pass;
end

initial begin
	$dumpfile("EdgeDetector.vcd");
	$dumpvars(0, top);
end

endmodule // top
