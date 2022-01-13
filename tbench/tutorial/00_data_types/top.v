`include "tbench/assert.v"

module top();

parameter CLOCK_PERIOD = 1;

reg [1:0] r_a = 2'b01;
wire [1:0] w_a = 2'b01;

initial begin

	r_a++;
	w_a++;
	$display("r_a=%b", r_a);
	$display("w_a=%b", w_a);
	#1;
	`assert_pass;
end

initial begin
	$dumpfile("00_data_types.vcd");
	$dumpvars(0, top);
end

endmodule // top
