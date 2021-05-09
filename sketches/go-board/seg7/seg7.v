`default_nettype none

module top(
	input CLK,
	input SW2, SW4,
	inout PMOD1, PMOD2,
	output LED1, LED2, LED3, LED4
	);

// Buttons
reg r_sw_data;
reg r_sw_data_pulse;
reg r_sw_clk;
reg r_sw_clk_pulse;

Debouncer #(.p_WIDTH(2), .p_CNT_WIDTH(16)) deb(CLK, {SW2, SW4}, {r_sw_data, r_sw_clk});
EdgeDetector #(.p_WIDTH(2)) edetector (CLK, {r_sw_data, r_sw_clk}, {r_sw_data_pulse, r_sw_clk_pulse});

// I2C lines
reg r_i2c_data = 1'b1;
reg r_i2c_clk = 1'b1;

always @(posedge CLK) begin
	r_i2c_data <= r_sw_data_pulse ? ~r_i2c_data : r_i2c_data;
	r_i2c_clk <= r_sw_clk_pulse ? ~r_i2c_clk : r_i2c_clk;
end

assign PMOD2 = r_i2c_data ? 1'bZ : 1'b0;
assign PMOD1 = r_i2c_clk ? 1'bZ : 1'b0;

// Indication
assign LED1 = r_i2c_data;
assign LED2 = r_i2c_clk;
assign LED3 = PMOD2;
assign LED4 = PMOD1;

endmodule
