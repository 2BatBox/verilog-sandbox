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

reg [3:0] ra_cnt = 0;
reg r_button_dirty = 0;
reg r_button = 0;
wire w_button;
wire w_cnt;
wire w_cnt_cw;


/*
always@(posedge CLK) begin
	if(w_cnt)
		ra_cnt <= ra_cnt + (w_cnt_cw ? 1 : -1);
end
*/

/*
always@(posedge CLK) begin
	r_button_dirty <= P1B4;
	r_button <= r_button_dirty;
	if(r_button_dirty == 1'b1 && r_button == 1'b0)
		ra_cnt <= ra_cnt + 1;
end
*/

always@(posedge CLK) begin
	r_button <= w_button;
	if(r_button == 1'b0 && w_button == 1'b1)
		ra_cnt <= ra_cnt + 1;
end


//IRotaryEncoder ire(CLK, P1B1, P1B3, w_cnt, w_cnt_cw);
Debouncer #(.PERIOD(16000)) db(CLK, P1B4, w_button);

assign {P1A1, P1A2, P1A3, P1A4} = ra_cnt;
assign {LED_RED_N, LED_GRN_N, LED_BLU_N} = 3'b111;

endmodule
