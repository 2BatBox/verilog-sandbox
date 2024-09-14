`include "lib-tb/assert.v"
`include "lib/basic_comb/BinaryPriorityEncoder.v"

module top();

parameter DELAY_PERIOD = 1;
parameter DECODED_WIDTH = 5;
parameter ADDR_WIDTH = $clog2(DECODED_WIDTH);
parameter ARRD_RANGE = 1 << DECODED_WIDTH;

reg [DECODED_WIDTH-1:0] rv_input;

wire [ADDR_WIDTH-1:0] wv_output_addr;
wire w_output_enable;

BinaryProirityEncoder #(.WIDTH(DECODED_WIDTH)) enc(rv_input, w_output_enable, wv_output_addr);

initial begin

	rv_input = 0;
	#DELAY_PERIOD;
	`assert(w_output_enable == 0);
	`assert(wv_output_addr == 0);

	
	repeat(ARRD_RANGE) begin
		rv_input = rv_input + 1;
		#DELAY_PERIOD;
		$display("in=%b en=%b out=%b", rv_input, w_output_enable, wv_output_addr);
	end

/*	
	rv_input_addr = 0;
	#DELAY_PERIOD;
	
	repeat(DECODED_WIDTH) begin
		`assert(wv_output_addr == rv_input_addr);
		`assert(w_output_enable == r_input_enable);
		rv_input_addr = rv_input_addr + 1;
		#DELAY_PERIOD;
	end
	
	*/
	
	#DELAY_PERIOD;
	`assert_pass;

end

endmodule // top
