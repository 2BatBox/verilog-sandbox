`default_nettype none

`include "../../../lib/io/IRotaryEncoder.v"
`include "../../../lib/io/SyncChain.v"
`include "../../../lib/io/Seg7Async.v"
`include "../../../lib/io/Seg7Sync.v"

module top(
	input CLK,
	input PMOD2, // Phase B
	input PMOD3, // Phase A
	output S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G, // Seg7 first
	output S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G // Seg7 second
	);

wire w_phase_a;
wire w_phase_b;
wire w_cnt;
wire w_cnt_cw;
wire w_cnt_err;

reg [7:0] rv_cnt_value = 0;
reg [3:0] rv_cnt_error = 0;

SyncChain #(.p_WIDTH(2)) sync0(CLK, {PMOD3, PMOD2}, {w_phase_a, w_phase_b});
IRotaryEncoder irenc0(CLK, w_phase_a, w_phase_b, w_cnt, w_cnt_cw, w_cnt_err);
Seg7Async s0(rv_cnt_value[7:4], {S1_A, S1_B, S1_C, S1_D, S1_E, S1_F, S1_G});
Seg7Async s2(rv_cnt_value[3:0], {S2_A, S2_B, S2_C, S2_D, S2_E, S2_F, S2_G});


always @(posedge CLK) begin
	if(w_cnt)
		rv_cnt_value <= rv_cnt_value + (w_cnt_cw ? 1 : -1);
end

always @(posedge w_cnt_err) begin
	rv_cnt_error <= rv_cnt_error + 1;
end

endmodule
