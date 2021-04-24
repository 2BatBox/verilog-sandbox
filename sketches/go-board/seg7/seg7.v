`default_nettype none

//-- Template for the top entity
module top(
	input CLK,
	input SW1,
	input SW2,
	input SW3,
	input SW4,

	input PMOD1, // button
	input PMOD2, // phase A
	input PMOD3, // phase B

	output LED1,
	output LED2,
	output LED3,
	output LED4,

	output S1_A,
	output S1_B,
	output S1_C,
	output S1_D,
	output S1_E,
	output S1_F,
	output S1_G,

	output S2_A,
	output S2_B,
	output S2_C,
	output S2_D,
	output S2_E,
	output S2_F,
	output S2_G

	);

reg [7:0] cnt_led = 0;
reg [7:0] cnt_7seg = 0;

wire [3:0] wv_sw;
wire [3:0] wv_sw_click;

Debouncer #(.p_WIDTH(4), .p_CNT_WIDTH(16)) m_debouncer(CLK, {SW4, SW3, SW2, SW1}, wv_sw);
EdgeDetector #(.p_WIDTH(4), .p_RISE_DETECTOR(1)) uut(CLK, wv_sw, wv_sw_click);

Seg7Sync m_7seg_sync(CLK, cnt_7seg[7:4], {S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G});
Seg7Async m_7seg_async(cnt_7seg[3:0], {S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G});

wire w_irot_cnt;
wire w_irot_cnt_cw;
wire w_irot_phase_a;
wire w_irot_phase_b;

SyncChain #(.p_WIDTH(2)) m_sync_chain(CLK, {PMOD2, PMOD3}, {w_irot_phase_b, w_irot_phase_a});
IRotaryEncoder m_irot(CLK, w_irot_phase_a, w_irot_phase_b, w_irot_cnt, w_irot_cnt_cw);

always @(posedge CLK) begin
	if(w_irot_cnt)
		cnt_led <= cnt_led + (w_irot_cnt_cw ? 1 : -1);
end

always @(posedge CLK) begin
	case (wv_sw_click)
	4'b0001: cnt_7seg <= cnt_7seg + 16;
	4'b0010: cnt_7seg <= cnt_7seg - 16;
	4'b0100: cnt_7seg <= cnt_7seg + 1;
	4'b1000: cnt_7seg <= cnt_7seg - 1;
	endcase;
end


assign {LED1, LED2, LED3, LED4} = cnt_led;

endmodule
