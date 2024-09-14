`include "lib-tb/assert.v"
`include "lib/basic_comb/BinaryDecoder.v"
`include "lib/basic_comb/BinaryEncoder.v"

module top();

parameter DELAY_PERIOD = 1;
parameter DECODED_WIDTH = 5;
parameter ADDR_WIDTH = $clog2(DECODED_WIDTH);

reg [ADDR_WIDTH-1:0] rv_input_addr;
reg r_input_enable;

wire [DECODED_WIDTH-1:0] wv_decoder_output;

wire [ADDR_WIDTH-1:0] wv_output_addr;
wire w_output_enable;

BinaryDecoder #(.WIDTH(DECODED_WIDTH)) dec(rv_input_addr, r_input_enable, wv_decoder_output);
BinaryEncoder #(.WIDTH(DECODED_WIDTH)) enc(wv_decoder_output, w_output_enable, wv_output_addr);

initial begin

	rv_input_addr = 0;
	r_input_enable = 0;
	#DELAY_PERIOD;
	
	repeat(DECODED_WIDTH) begin
		`assert(wv_output_addr == 0);
		`assert(w_output_enable == 0);
		rv_input_addr = rv_input_addr + 1;
		#DELAY_PERIOD;
	end
	
	rv_input_addr = 0;
	r_input_enable = 1;
	#DELAY_PERIOD;
	
	repeat(DECODED_WIDTH) begin
		`assert(wv_output_addr == rv_input_addr);
		`assert(w_output_enable == r_input_enable);
		rv_input_addr = rv_input_addr + 1;
		#DELAY_PERIOD;
	end
	
	#DELAY_PERIOD;
	`assert_pass;

end

endmodule // top
