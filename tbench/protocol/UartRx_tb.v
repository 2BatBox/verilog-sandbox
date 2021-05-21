`include "assert.v"
`include "protocol/UartRx.v"

module UartRx_tb();

localparam integer CLOCK_PERIOD = 1;
localparam integer CLOCK_FREQ = 2;
localparam integer BIT_RATE = 1;

reg r_clk = 0;
reg r_input = 1'b1;

wire w_data;
wire w_data_ready;

//reg r_watch_dog = 0;
//wire w_output;

// setup clock
always begin
	#CLOCK_PERIOD r_clk = ~r_clk;
end

// setup watchdog
//always @(w_output) begin
//	if(r_watch_dog)
//		`assert_fail;
//end

UartRx #(.p_BITSLOT_HALF_PERIOD(CLOCK_PERIOD),.p_DATA_BITS(1), .p_STOP_BITS(3)) uut(r_clk, r_input, w_data, w_data_ready);


initial begin

	#10;
	r_input = ~r_input;
	#4;
	r_input = ~r_input;
	#100;
//	r_input = ~r_input;
//	#10;

/*
	// Toggle the the input every clock posedge.
	// No changes of w_output are allowed in this section.
	#TOLERANCE_PERIOD;
	r_watch_dog <= 1;
	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
	end
	r_input = w_output;

	// Operate in the tolerance period minus one clock cycle.
	// No changes of w_output are allowed in this section.
	#TOLERANCE_PERIOD;
	r_watch_dog <= 1;
	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (TOLERANCE_PERIOD / 2)
			@(posedge r_clk);	
	end
	r_input = w_output;

	// Operate in a half a tolerance period.
	// No changes of w_output are allowed in this section.
	#TOLERANCE_PERIOD;
	r_watch_dog <= 1;
	repeat (ATTEMPT_CNT) begin
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (TOLERANCE_PERIOD - 1)
			@(posedge r_clk);	
	end
	r_input = w_output;

	// Operate out of the tolerance period.
	// w_output changes should occure in this section.
	#TOLERANCE_PERIOD;
	repeat (ATTEMPT_CNT) begin
		r_watch_dog <= 1;
		@(negedge r_clk);
		r_input = ~r_input;
		repeat (TOLERANCE_PERIOD - 1)
			@(posedge r_clk);
		r_watch_dog <= 0;
		@(posedge r_clk);
		@(negedge r_clk);
		`assert_eq(w_output, r_input);
	end

	#TOLERANCE_PERIOD;
	*/
	#1
	`assert_pass;
end

initial begin
	$dumpfile("UartRx_tb.vcd");
	$dumpvars(0, UartRx_tb);
end

endmodule
