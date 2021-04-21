module inc_encoder_hw(
	input CLK,
	input P1B1,
	input P1B2,
	input P1B3,
	input P1B4,
	output P1A1,
	output P1A2,
	output P1A3,
	output P1A4,
	output LED_RED_N,
	output LED_GRN_N,
	output LED_BLU_N
);

wire w_phase_a = P1B1;
wire w_phase_b = P1B3;

wire w_button = P1B4;
wire w_button_sync;
wire w_button_sync_deb;
reg r_button_sync_deb = 0;

reg [3:0] rv_cnt = 0;
reg [3:0] rv_rgb = 0;

wire w_cnt;
wire w_cnt_cw;

SyncChain #(.p_WIDTH(1)) m_sync_chain (CLK, w_button, w_button_sync);
Debouncer #(.p_CNT_WIDTH(16)) m_db(CLK, w_button_sync, w_button_sync_deb);
IRotaryEncoder m_ire(CLK, w_phase_a, w_phase_b, w_cnt, w_cnt_cw);

always@(posedge CLK) begin
	r_button_sync_deb <= w_button_sync_deb;
	if(w_cnt)
		rv_cnt <= rv_cnt + (w_cnt_cw ? 1 : -1);
	if(r_button_sync_deb == 1'b0 && w_button_sync_deb == 1'b1)
		rv_rgb <= rv_rgb + 1;
end


assign {P1A1, P1A2, P1A3, P1A4} = rv_cnt;
assign {LED_RED_N, LED_GRN_N, LED_BLU_N} = rv_rgb;

endmodule
