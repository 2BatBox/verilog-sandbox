
/////////////////////////////////////////////////////
//
//  Period counter.
//
/////////////////////////////////////////////////////
module CounterPeriod
	#(
		parameter p_PERIOD = 4 // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		output o_period
	);
	
localparam lp_WIDTH = $clog2(p_PERIOD);
localparam lp_RESET = p_PERIOD - 1;

reg [lp_WIDTH-1:0] rv_counter;

wire w_reset = i_reset | o_period;

assign o_period = rv_counter == lp_RESET;

always @(posedge i_clk) begin
	if(w_reset)
		rv_counter <= 0;
	else
		rv_counter <= rv_counter + 1;
end
	
endmodule // CounterPeriod



/////////////////////////////////////////////////////
//
//  Half and full period counter.
//
/////////////////////////////////////////////////////
module CounterHalfPeriod
	#(
		parameter p_PERIOD = 4 // Must be greater than three.
	)(
		input i_clk,
		input i_reset,
		output o_half_period,
		output o_period
	);
	
localparam lp_WIDTH = $clog2(p_PERIOD);
localparam lp_RESET = p_PERIOD - 1;
localparam lp_HALF_PERIOD = (p_PERIOD / 2) - 1;

reg [lp_WIDTH-1:0] rv_counter;

wire w_reset = i_reset | o_period;

assign o_half_period = rv_counter == lp_HALF_PERIOD;
assign o_period = rv_counter == lp_RESET;

always @(posedge i_clk) begin
	if(w_reset)
		rv_counter <= 0;
	else
		rv_counter <= rv_counter + 1;
end
	
endmodule // CounterHalfPeriod


