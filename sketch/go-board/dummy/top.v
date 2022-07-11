`default_nettype none

module top(
	input CLK,
	input SW1,
	output LED2
	);

reg r_led2 = 1'b0;

assign LED2 = r_led2;

always @(posedge CLK) begin
	if(CLK & SW1) begin
		r_led2 <= 1'b1;
	end
end

endmodule
