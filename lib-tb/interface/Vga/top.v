`include "lib-tb/assert.v"
`include "lib/interface/Vga.v"

module top();

localparam LP_COUNTER_WIDTH = 10;
localparam LP_CLOCK_PERIOD = 1;

reg uut_clk = 0;

wire uut_vga_hsync;
wire uut_vga_vsync;

always begin
	#LP_CLOCK_PERIOD uut_clk = ~uut_clk;
end

VgaAreaTracker
	#(
		.P_CNT_WIDTH(LP_COUNTER_WIDTH),
		
		.P_H_VISIBLE(1),
		.P_H_BACK_PORCH(2),
		.P_H_SYNC(3),
		.P_H_FRONT_PORCH(4)

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
