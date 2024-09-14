
/////////////////////////////////////////////////////
//
//  Period counter.
//
/////////////////////////////////////////////////////
module CounterPeriod
	#(
		parameter PERIOD = 4 // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		output o_period
	);
	
localparam lWIDTH = $clog2(PERIOD);
localparam lRESET = PERIOD - 1;

reg [lWIDTH-1:0] rv_counter;

wire w_reset = i_reset | o_period;

assign o_period = rv_counter == lRESET;

always @(posedge i_clk) begin
	if(w_reset)
		rv_counter <= 0;
	else
		rv_counter <= rv_counter + 1;
end
	
endmodule // CounterPeriod



/////////////////////////////////////////////////////
//
//  SimpleSampler.
//
/////////////////////////////////////////////////////
module SimpleSampler
	#(
		parameter PERIOD = 4 // Must be greater than three.
	)(
		input i_clk,
		input i_reset,
		output o_sample,
		output o_reset
	);
	
localparam lWIDTH = $clog2(PERIOD);
localparam lRESET = PERIOD - 1;
localparam lHALF_PERIOD = (PERIOD / 2) - 1;

reg [lWIDTH-1:0] rv_counter;

wire w_reset = i_reset | o_reset;

assign o_sample = rv_counter == lHALF_PERIOD;
assign o_reset = rv_counter == lRESET;

always @(posedge i_clk) begin
	if(w_reset)
		rv_counter <= 0;
	else
		rv_counter <= rv_counter + 1;
end
	
endmodule // SimpleSampler


