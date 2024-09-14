`include "lib-tb/assert.v"
`include "lib/interface/Vga.v"

module top();

localparam COUNTER_WIDTH = 10;
localparam CLOCK_PERIOD = 1;

reg uut_clk = 0;

wire uut_vga_hsync;
wire uut_vga_vsync;

always begin
	#CLOCK_PERIOD uut_clk = ~uut_clk;
end

VgaAreaTracker
	#(
		.CNT_WIDTH(COUNTER_WIDTH),
		
		.H_VISIBLE(1),
		.H_BACK_PORCH(2),
		.H_SYNC(3),
		.H_FRONT_PORCH(4)

	)
	
	uut
	(
	.i_clk(uut_clk),
	.o_h_sync(uut_vga_hsync)
	);


initial begin
	#100;
	`assert_pass;
end

initial begin
	$dumpfile("Vga.vcd");
	$dumpvars(0, top);
end

endmodule // top
