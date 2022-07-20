`include "lib-tb/assert.v"
`include "lib/io/Fifo.v"

module top();

localparam CLOCK_PERIOD = 1;
localparam CAPACITY = 0;
localparam CNT_WIDTH = $clog2(CAPACITY + 1);

reg [CNT_WIDTH - 1 : 0] rv_a = 0;
reg [CNT_WIDTH - 1 : 0] rv_b = 0;

initial begin

	$display("CAPACITY  = %d", CAPACITY);
	$display("CNT_WIDTH = %d", CNT_WIDTH);

	repeat(CAPACITY) begin
		$display("a=%b b=%b a-b=%d", rv_a, rv_b, rv_a - rv_b);
		#1;
		rv_a++;
//		rv_b++;
	end
	$display("a=%b b=%b a-b=%d", rv_a, rv_b, rv_a - rv_b);
	
	
	repeat(CAPACITY) begin
		$display("a=%b b=%b a-b=%d", rv_a, rv_b, rv_a - rv_b);
		#1;
		rv_b++;
	end
	$display("a=%b b=%b a-b=%d", rv_a, rv_b, rv_a - rv_b);
	
	`assert_pass;
end

initial begin
	$dumpfile("Fifo.vcd");
	$dumpvars(0, top);
end

endmodule // top
