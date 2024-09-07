`include "lib-tb/assert.v"
`include "lib/protocol/Uart.v"

module top();

parameter CLOCK_PERIOD = 1;

reg r_clk = 0;
reg r_reset = 1;
reg r_input = 1;
reg r_sample = 0;

wire [3:0] wv_output;
wire w_data_ready;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

/*
__UartShiftAccumulator
	#(
		.p_WIDTH(4)
	) uut(
	.i_clk(r_clk),
	.i_reset(r_reset),
	.i_input(r_input),
	.i_sample(r_sample),
	.o_data(wv_output),
	.o_data_ready(w_data_ready)
);


__UartRxSampleGenerator
	#(
		.p_HALF_PERIOD_CLK(3)
	)
	uut(
		.i_clk(r_clk),
		.i_enable(r_enable),
		.o_output(w_output)
	);
	*/


initial begin

	repeat(3) begin
		@(negedge r_clk);
	end
	
	r_reset <= 0;
	
	repeat(3) begin
		@(negedge r_clk);
	end

	r_sample <= 1;
	
	repeat(8) begin
		@(negedge r_clk);
	end
	
	r_input <= 0;
	
	repeat(8) begin
		@(negedge r_clk);
	end

	
	#10;
	`assert_pass;

end

initial begin
	$dumpfile("Uart.vcd");
	$dumpvars(0, top);
end

endmodule // top
