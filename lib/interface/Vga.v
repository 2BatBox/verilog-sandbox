module VgaLineTracker
	#(
		parameter P_CNT_WIDTH = 8,
		
		parameter P_VISIBLE = 1,
		parameter P_BACK_PORCH = 1,
		parameter P_SYNC = 1,
		parameter P_FRONT_PORCH = 1
	)
	
	(
		input i_clk,
		input i_count,
		output [P_CNT_WIDTH - 1 : 0] oa_coord,
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
	localparam [P_CNT_WIDTH - 1 : 0] LP_OFFSET_VIS_2_BP = P_VISIBLE - 1;
	localparam [P_CNT_WIDTH - 1 : 0] LP_OFFSET_BP_2_SYNC = LP_OFFSET_VIS_2_BP + P_BACK_PORCH;
	localparam [P_CNT_WIDTH - 1 : 0] LP_OFFSET_SYNC_2_FP = LP_OFFSET_BP_2_SYNC + P_SYNC;
	localparam [P_CNT_WIDTH - 1 : 0] LP_OFFSET_FP_2_VIS = LP_OFFSET_SYNC_2_FP + P_FRONT_PORCH;

	reg [P_CNT_WIDTH - 1 : 0] ra_coord = 0;
	
	reg [1 : 0] ra_state = STATE_VISIBLE;

	wire trig_state_next =
		o_reset_counter |
		(ra_coord == LP_OFFSET_VIS_2_BP) |
		(ra_coord == LP_OFFSET_BP_2_SYNC) |
		(ra_coord == LP_OFFSET_SYNC_2_FP);
		
	always@(posedge i_clk) begin
		if(i_count) begin
			ra_coord <= o_reset_counter ? 0 : ra_coord + 1;
			ra_state <= ra_state + trig_state_next;
		end
	end
	
	assign oa_coord = ra_coord;
	assign o_visible = (ra_state == STATE_VISIBLE);
	assign o_sync = ( ra_state == STATE_SYNC );
	assign o_reset_counter = (ra_coord == LP_OFFSET_FP_2_VIS);
	
endmodule // VgaPixelTracker




module VgaAreaTracker
	#(
		parameter P_CNT_WIDTH = 8,
		
		parameter P_H_VISIBLE = 1,
		parameter P_H_BACK_PORCH = 1,
		parameter P_H_SYNC = 1,
		parameter P_H_FRONT_PORCH = 1,
		
		parameter P_V_VISIBLE = 1,
		parameter P_V_BACK_PORCH = 1,
		parameter P_V_SYNC = 1,
		parameter P_V_FRONT_PORCH = 1
	)
	
	(
		input i_clk,
		output [P_CNT_WIDTH - 1 : 0] oa_h_coord,
		output [P_CNT_WIDTH - 1 : 0] oa_v_coord,
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
			.P_CNT_WIDTH(P_CNT_WIDTH),
			
			.P_VISIBLE(P_H_VISIBLE),
			.P_BACK_PORCH(P_H_BACK_PORCH),
			.P_SYNC(P_H_SYNC),
			.P_FRONT_PORCH(P_H_FRONT_PORCH)
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
			.P_CNT_WIDTH(P_CNT_WIDTH),
			
			.P_VISIBLE(P_V_VISIBLE),
			.P_BACK_PORCH(P_V_BACK_PORCH),
			.P_SYNC(P_V_SYNC),
			.P_FRONT_PORCH(P_V_FRONT_PORCH)
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
