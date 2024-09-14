module VgaLineTracker
	#(
		parameter CNT_WIDTH = 8,
		
		parameter VISIBLE = 1,
		parameter BACK_PORCH = 1,
		parameter SYNC = 1,
		parameter FRONT_PORCH = 1
	)
	
	(
		input i_clk,
		input i_count,
		output [CNT_WIDTH - 1 : 0] oa_coord,
		output o_visible,
		output o_sync,
		output o_reset_counter
	);
	
	// State
	localparam [1 : 0] STATE_VISIBLE = 0;
	localparam [1 : 0] STATE_BACK_PORCH = 1;
	localparam [1 : 0] STATE_SYNC = 2;
	localparam [1 : 0] STATE_FRONT_PORCH = 3;
	
	// Triggers
	localparam [CNT_WIDTH - 1 : 0] OFFSET_VIS_2_BP = VISIBLE - 1;
	localparam [CNT_WIDTH - 1 : 0] OFFSET_B2_SYNC = OFFSET_VIS_2_BP + BACK_PORCH;
	localparam [CNT_WIDTH - 1 : 0] OFFSET_SYNC_2_FP = OFFSET_B2_SYNC + SYNC;
	localparam [CNT_WIDTH - 1 : 0] OFFSET_F2_VIS = OFFSET_SYNC_2_FP + FRONT_PORCH;

	reg [CNT_WIDTH - 1 : 0] ra_coord = 0;
	
	reg [1 : 0] ra_state = STATE_VISIBLE;

	wire trig_state_next =
		o_reset_counter |
		(ra_coord == OFFSET_VIS_2_BP) |
		(ra_coord == OFFSET_B2_SYNC) |
		(ra_coord == OFFSET_SYNC_2_FP);
		
	always@(posedge i_clk) begin
		if(i_count) begin
			ra_coord <= o_reset_counter ? 0 : ra_coord + 1;
			ra_state <= ra_state + trig_state_next;
		end
	end
	
	assign oa_coord = ra_coord;
	assign o_visible = (ra_state == STATE_VISIBLE);
	assign o_sync = ( ra_state == STATE_SYNC );
	assign o_reset_counter = (ra_coord == OFFSET_F2_VIS);
	
endmodule // VgaPixelTracker




module VgaAreaTracker
	#(
		parameter CNT_WIDTH = 8,
		
		parameter H_VISIBLE = 1,
		parameter H_BACK_PORCH = 1,
		parameter H_SYNC = 1,
		parameter H_FRONT_PORCH = 1,
		
		parameter V_VISIBLE = 1,
		parameter V_BACK_PORCH = 1,
		parameter V_SYNC = 1,
		parameter V_FRONT_PORCH = 1
	)
	
	(
		input i_clk,
		output [CNT_WIDTH - 1 : 0] oa_h_coord,
		output [CNT_WIDTH - 1 : 0] oa_v_coord,
		output o_visible,
		output o_h_sync,
		output o_v_sync,
		output o_frame_sync
	);
	
	wire h_reset_counter;
	wire h_visible;
	wire v_visible;
	
	VgaLineTracker
		#(
			.CNT_WIDTH(CNT_WIDTH),
			
			.VISIBLE(H_VISIBLE),
			.BACK_PORCH(H_BACK_PORCH),
			.SYNC(H_SYNC),
			.FRONT_PORCH(H_FRONT_PORCH)
		)
		vga_h_pixel_tracker
		(
			.i_clk(i_clk),
			.i_count(1'b1),
			.oa_coord(oa_h_coord),
			.o_visible(h_visible),
			.o_sync(o_h_sync),
			.o_reset_counter(h_reset_counter)
		);
		
	VgaLineTracker
		#(
			.CNT_WIDTH(CNT_WIDTH),
			
			.VISIBLE(V_VISIBLE),
			.BACK_PORCH(V_BACK_PORCH),
			.SYNC(V_SYNC),
			.FRONT_PORCH(V_FRONT_PORCH)
		)
		vga_v_pixel_tracker
		(
			.i_clk(i_clk),
			.i_count(h_reset_counter),
			.oa_coord(oa_v_coord),
			.o_visible(v_visible),
			.o_sync(o_v_sync),
			.o_reset_counter(o_frame_sync)
		);
		
	assign o_visible = h_visible & v_visible;

endmodule // VgaAreaTracker
