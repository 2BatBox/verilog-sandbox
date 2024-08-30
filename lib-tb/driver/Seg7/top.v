`include "lib-tb/assert.v"
`include "lib/io/Seg7.v"

module top();

parameter CLOCK_PERIOD = 1;
integer i;

reg r_clk = 0;
reg [3:0] rv_input;
wire [6:0] wv_output;
wire [6:0] wv_output_alt;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

Seg7 uut(rv_input, wv_output);
Seg7Alt uut_alt(rv_input, wv_output_alt);

initial begin

	for(i = 0; i < 'h0F; ++i) begin
		@(negedge r_clk);
		rv_input <= i;
		@(negedge r_clk);
		`assert_eq(wv_output, wv_output_alt);
	end

	`assert_pass;
end

initial begin
	$dumpfile("Seg7.vcd");
	$dumpvars(0, top);
end

endmodule // top
