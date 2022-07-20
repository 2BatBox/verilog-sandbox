`include "lib-tb/assert.v"
`include "lib/alu/Gray.v"

module TopGeneric
	#(
		parameter p_WIDTH = 1
	);

	localparam COUNTER_RANGE = 1 << p_WIDTH;

	reg  [p_WIDTH - 1 : 0] rv_input_bin;
	wire [p_WIDTH - 1 : 0] wv_output_gray;
	wire [p_WIDTH - 1 : 0] wv_output_bin;

	reg  [p_WIDTH : 0] rv_cnt;

	Bin2Gray #(.p_WIDTH(p_WIDTH)) bin2gray (rv_input_bin, wv_output_gray);
	Gray2Bin #(.p_WIDTH(p_WIDTH)) gray2bin (wv_output_gray, wv_output_bin);

	initial begin

		`assert(p_WIDTH > 0);
		
		rv_input_bin = 0;
		for(rv_cnt = 0; rv_cnt < COUNTER_RANGE; rv_cnt++) begin
			#1;
//			$display("%b -> %b -> %b", rv_input_bin, wv_output_gray, wv_output_bin);
			
			// input/output
			`assert_eq(rv_input_bin, wv_output_bin);
			
			// gray parity value
			`assert_eq(^wv_output_gray, rv_input_bin[0]);
			
			rv_input_bin++;
		end
		
	end

endmodule // TopGeneric


module top();

	localparam WIDTH_MAX = 5;
	localparam CLK_MAX = (1 << WIDTH_MAX) + 1;

	genvar i;	
	for(i = 1; i <= WIDTH_MAX; i = i + 1) begin
		TopGeneric #(.p_WIDTH(i)) uut();
	end	

	initial begin
		$dumpfile("Gray.vcd");
		$dumpvars(0, top);
		#CLK_MAX;
		`assert_pass;
	end

endmodule // top
