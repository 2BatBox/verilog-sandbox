`default_nettype none

//-- Template for the top entity
module top(
	input CLK,
	input SW1,
	input SW2,
	input SW3,
	input SW4,

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

reg [3:0] cnt = 0;

reg [3:0] rv_sw = 0;
wire [3:0] wv_sw;
wire [3:0] wv_sw_clk = (~rv_sw) & wv_sw;

Debouncer #(.p_INPUT_WIDTH(4), .p_CNT_WIDTH(16)) m_debouncer(CLK, {SW4, SW3, SW2, SW1}, wv_sw);

Seg7Sync m_7seg_sync(CLK, cnt, {S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G});
Seg7Async m_7seg_async(cnt, {S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G});


always @(posedge CLK) begin
	rv_sw <= wv_sw;
	if(wv_sw_clk)
		cnt <= cnt + (wv_sw[0] ? 1 : -1);
end

assign {LED1, LED2, LED3, LED4} = cnt;

endmodule
