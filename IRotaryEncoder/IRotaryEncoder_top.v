module inc_encoder_hw(
	input CLK,
	input P1A1,
	input P1A2,
	input P1A3,
	input P1A4,
	output P1B1,
	output P1B2,
	output P1B3,
	output P1B4
);

reg [3:0] ra_cnt = 0;
wire w_cnt;
wire w_cnt_cw;

always@(posedge CLK) begin
	if(w_cnt)
		ra_cnt <= ra_cnt + (w_cnt_cw ? 1 : -1);
end

IRotaryEncoder uut(CLK, P1A1, P1A3, w_cnt, w_cnt_cw);

assign {P1B1, P1B2, P1B3, P1B4} = ra_cnt;

endmodule
