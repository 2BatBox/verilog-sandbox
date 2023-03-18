`default_nettype none

module top(
	input BTN1,
	output LED1,
	);

assign LED1 = BTN1;

/*

reg r_led1 = 1'b0;

always @(posedge CLK) begin
	if(CLK & SW1) begin
		r_led1 <= 1'b1;
	end
end
*/

endmodule
