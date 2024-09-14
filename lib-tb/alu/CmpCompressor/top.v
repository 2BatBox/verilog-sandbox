`include "lib-tb/assert.v"
`include "lib/alu/CmpCompressor.v"

module CmpCompressorInstanceUnsigned #(
	parameter ARG_WIDTH = 1
) ();

localparam ARG_RANGE = $pow(2, ARG_WIDTH);

wire w_zero;
wire w_equal;
wire w_less;
wire w_greater;

reg unsigned [ARG_WIDTH-1:0] rv_x;
reg unsigned [ARG_WIDTH-1:0] rv_y;

CmpCompressorUnsigned #(.WIDTH(ARG_WIDTH)) uut(.iv_x(rv_x), .iv_y(rv_y), .o_zero(w_zero), .o_equal(w_equal), .o_less(w_less), .o_greater(w_greater));

wire w_zero_ok = ((rv_x == 0) & (rv_y == 0)) == w_zero;
wire w_equal_ok = (rv_x == rv_y) == w_equal;
wire w_less_ok = (rv_x < rv_y) == w_less;
wire w_greater_ok = (rv_x > rv_y) == w_greater;
wire o_pass = w_zero_ok & w_equal_ok & w_less_ok & w_greater_ok;

integer i;
integer j;

initial begin

for(i = 0; i < ARG_RANGE; ++i) begin
	for(j = 0; j < ARG_RANGE; ++j) begin
		rv_x = i;
		rv_y = j;
		#1;
		
		$display("UNSIGNED | %b (%d) | %b (%d) |  Z=%b | E=%b | L=%b | G=%b |", rv_x, rv_x, rv_y, rv_y, w_zero, w_equal, w_less, w_greater);
		`assert_eq(o_pass, 1);

	end
end

end

endmodule // CmpCompressorInstanceUnsigned
	

	
module CmpCompressorInstanceSigned #(
	parameter ARG_WIDTH = 1
) ();

localparam ARG_RANGE = $pow(2, ARG_WIDTH);

wire w_zero;
wire w_equal;
wire w_less;
wire w_greater;

reg signed [ARG_WIDTH-1:0] rv_x;
reg signed [ARG_WIDTH-1:0] rv_y;

CmpCompressorSigned #(.WIDTH(ARG_WIDTH)) uut(.iv_x(rv_x), .iv_y(rv_y), .o_zero(w_zero), .o_equal(w_equal), .o_less(w_less), .o_greater(w_greater));

wire w_zero_ok = ((rv_x == 0) & (rv_y == 0)) == w_zero;
wire w_equal_ok = (rv_x == rv_y) == w_equal;
wire w_less_ok = (rv_x < rv_y) == w_less;
wire w_greater_ok = (rv_x > rv_y) == w_greater;
wire o_pass = w_zero_ok & w_equal_ok & w_less_ok & w_greater_ok;

integer i;
integer j;

initial begin

for(i = 0; i < ARG_RANGE; ++i) begin
	for(j = 0; j < ARG_RANGE; ++j) begin
		rv_x = i;
		rv_y = j;
		#1;
		
		$display("SIGNED | %b (%d) | %b (%d) |  Z=%b | E=%b | L=%b | G=%b |", rv_x, rv_x, rv_y, rv_y, w_zero, w_equal, w_less, w_greater);
		`assert_eq(o_pass, 1);

	end
end

end

endmodule // CmpCompressorInstanceSigned	


module top();

localparam WIDTH_MAX = 3;

CmpCompressorInstanceUnsigned #(.ARG_WIDTH(WIDTH_MAX)) cminst_unsigned();
//CmpCompressorInstanceSigned #(.ARG_WIDTH(WIDTH_MAX)) cminst_signed();

endmodule // top
