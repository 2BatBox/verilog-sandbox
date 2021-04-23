`include "../assert.v"

module Dummy_tb();

Dummy uut();

reg [1:0] rv_int2 = 0;
reg [31:0] rv_int32 = ~0;
reg [64:0] rv_int65 = ~0;

parameter c_MULTIPLIER = 4'b0011;
integer i;

initial begin
	$display("Just a %s", "string");
	$display("rv_int32 bin: %b", rv_int32);
	$display("rv_int32 hex: %h", rv_int32);
	$display("rv_int32 dec: %d", rv_int32);
	$display("\n");

	$display("rv_int65 bin: %b", rv_int65);
	$display("rv_int65 hex: %h", rv_int65);
	$display("rv_int65 dec: %d", rv_int65);
	$display("\n");

	$display("replecation {3{1'b1}}: %b", {3{1'b1}});
	$display("replecation {c_MULTIPLIER{1'b1}}: %b", {c_MULTIPLIER{1'b1}});

	for(i = 0; i < 3'b100; ++i) begin
		case (i)
			'b00: $display("'b00");
			'bxx: $display("'bxx");
		endcase;
	end
	

end

initial begin
	#1;
	`assert_pass;
end

initial begin
	$dumpfile("Dummy_tb.vcd");
	$dumpvars(0, Dummy_tb);
end

endmodule
