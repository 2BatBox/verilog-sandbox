/////////////////////////////////////////////////////
//
//  A synchronous 7 segment display driver.
// 
/////////////////////////////////////////////////////

module Seg7Sync(
	input i_clk,
	input [3:0] iv_input,
	output [6:0] ov_output
	);

reg [6:0] rv_output = 0;

assign ov_output = rv_output;

always@(posedge i_clk) begin
	case (iv_input)
		'h00 : rv_output <= ~7'b1111110;
		'h01 : rv_output <= ~7'b0110000;
		'h02 : rv_output <= ~7'b1101101;
		'h03 : rv_output <= ~7'b1111001;
		'h04 : rv_output <= ~7'b0110011;
		'h05 : rv_output <= ~7'b1011011;
		'h06 : rv_output <= ~7'b1011111;
		'h07 : rv_output <= ~7'b1110000;
		'h08 : rv_output <= ~7'b1111111;
		'h09 : rv_output <= ~7'b1110011;
		'h0a : rv_output <= ~7'b1110111;
		'h0b : rv_output <= ~7'b0011111;
		'h0c : rv_output <= ~7'b1001110;
		'h0d : rv_output <= ~7'b0111101;
		'h0e : rv_output <= ~7'b1001111;
		'h0f : rv_output <= ~7'b1000111;
	endcase;
end

endmodule



/////////////////////////////////////////////////////
//
//  An asynchronous 7 segment display driver.
// 
/////////////////////////////////////////////////////

module Seg7Async(
	input [3:0] iv_input,
	output [6:0] ov_output
	);

wire x = iv_input[3];
wire y = iv_input[2];
wire z = iv_input[1];
wire w = iv_input[0];

assign ov_output[6] = ((~x & ~y & ~z & w) | (~x & y & ~z & ~w) | (x & ~y & z & w) | (x & y & ~z & w));
assign ov_output[5] = ((x & z & w) | (x & y & ~w) | (y & z & ~w) + (~x & y & ~z & w));
assign ov_output[4] = ((x & y & ~w) | (x & y & z) | (~x & ~y & z & ~w));
assign ov_output[3] = ((y & z & w) | (~y & ~z & w) | (~x & y & ~z & ~w) | (x & ~y & z & ~w));
assign ov_output[2] = ((~x & w) | (~x & y & ~z) | (~y & ~z & w));
assign ov_output[1] = ((~x & ~y & w) | (~x & ~y & z) | (~x & z & w) | (x & y & ~z & w));
assign ov_output[0] = ((~x & ~y & ~z) | (~x & y & z & w) | (x & y & ~z & ~w));

endmodule
