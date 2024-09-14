`default_nettype none

`include "../../../lib/interface/Vga.v"

module top(
	input CLK,
	output VGA_HS,
	output VGA_VS,
	
	output VGA_R0,
	output VGA_R1,
	output VGA_R2,
	
	output VGA_G0,
	output VGA_G1,
	output VGA_G2,
	
	output VGA_B0,
	output VGA_B1,
	output VGA_B2,
	);
	
	localparam CNT_WIDTH = 10;
	
	reg [31 : 0] ra_time = 0;
	
	wire visible;
	
	wire [CNT_WIDTH - 1 : 0] x;
	wire [CNT_WIDTH - 1 : 0] y;
	
	wire [2:0] out_r = { VGA_R2, VGA_R1, VGA_R0 };
	wire [2:0] out_g = { VGA_G2, VGA_G1, VGA_G0 };
	wire [2:0] out_b = { VGA_B2, VGA_B1, VGA_B0 };
	
//	wire [2:0] in_r = x[2:0] + y[2:0] + ra_time[21:20];
//	wire [2:0] in_g = x[5:3] + y[5:3] + ra_time[24:23];
//	wire [2:0] in_b = x[8:6] + y[8:6] + ra_time[25:24];
	
	wire [2:0] in_r;
	wire [2:0] in_g;
	wire [2:0] in_b;
	
/////////////////////////////////////////////////////////////////////////////////
// AHTUNG ALARMA WARNING //// AHTUNG ALARMA WARNING //// AHTUNG ALARMA WARNING //
// ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  | //
//
//	assign {in_r, in_g, in_b} = (x ^ y) + ra_time[24:16];
//
// ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  |  ZOR.DE  | //
// AHTUNG ALARMA WARNING //// AHTUNG ALARMA WARNING //// AHTUNG ALARMA WARNING //
/////////////////////////////////////////////////////////////////////////////////

	assign {in_r, in_g, in_b} = (x ^ y) + ra_time[28:20];
	
	assign out_r = visible ? in_r : 3'b0;
	assign out_g = visible ? in_g : 3'b0;
	assign out_b = visible ? in_b : 3'b0;
	
	VgaAreaTracker
	#(
		.CNT_WIDTH(CNT_WIDTH),
		
		.H_VISIBLE(640),
		.H_BACK_PORCH(50),
		.H_SYNC(92),
		.H_FRONT_PORCH(18),

		.V_VISIBLE(480),
		.V_BACK_PORCH(33),
		.V_SYNC(2),
		.V_FRONT_PORCH(10)
	)
	
	uut
	(
	.i_clk(CLK),
	.oa_h_coord(x),
	.oa_v_coord(y),
	.o_visible(visible),
	.o_h_sync(VGA_HS),
	.o_v_sync(VGA_VS)
	);
	
	always@(posedge CLK) begin
		ra_time <= ra_time + 1;
	end
	
endmodule
