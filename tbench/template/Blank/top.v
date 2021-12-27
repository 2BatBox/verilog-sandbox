`include "tbench/assert.v"

module top();

parameter CLOCK_PERIOD = 1;

initial begin

	$display("data=%b", 7'b1 << 7);
	#1;
	`assert_pass;
end

initial begin
	$dumpfile("Blank.vcd");
	$dumpvars(0, top);
end

endmodule // top
