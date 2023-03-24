
//===================================================
// CmpZelgCompressorCell
//===================================================
//
// 1. iX < iY        ->  oX < oY
// 2. iX > iY        ->  oX > oY
// 3. iX == iY == 0  ->  oX == oY == 0
// 3. iX == iY != 0  ->  oX == oY == 1
// 
// -------------------
// | iX | iY | oX| oY|
// -------------------
// | 00 | 00 | 0 | 0 |
// | 00 | 01 | 0 | 1 |
// | 00 | 10 | 0 | 1 |
// | 00 | 11 | 0 | 1 |
// | 01 | 00 | 1 | 0 |
// | 01 | 01 | 1 | 1 |
// | 01 | 10 | 0 | 1 |
// | 01 | 11 | 0 | 1 |
// | 10 | 00 | 1 | 0 |
// | 10 | 01 | 1 | 0 |
// | 10 | 10 | 1 | 1 |
// | 10 | 11 | 0 | 1 |
// | 11 | 00 | 1 | 0 |
// | 11 | 01 | 1 | 0 |
// | 11 | 10 | 1 | 0 |
// | 11 | 11 | 1 | 1 |
// -------------------
module CmpZelgCompressorCell
	(
	input [1:0] iv_x,
	input [1:0] iv_y,
	output o_x,
	output o_y
	);
	
assign o_x = (iv_x[0] & ~iv_y[1]) | (iv_x[1] & ~iv_y[0]) | (iv_x[1] & iv_x[0]) | (iv_x[1] & ~iv_y[1]);
assign o_y = (iv_y[1] & iv_y[0]) | (~iv_x[0] & iv_y[1]) | (~iv_x[1] & iv_y[0]) | (~iv_x[1] & iv_y[1]);

endmodule // CmpZelgCompressorCell



//===================================================
// CmpZelgCompressor
//===================================================
module CmpZelgCompressor
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iv_x,
	input [p_WIDTH-1:0] iv_y,
	output o_x,
	output o_y
	);
	
	localparam lp_pairs = p_WIDTH / 2;
	localparam lp_tail = p_WIDTH % 2;
	localparam lp_wires = lp_pairs + lp_tail;
	
generate

	if(p_WIDTH == 1) begin
	
		assign o_x = iv_x[0];
		assign o_y = iv_y[0];
		
	end else if(p_WIDTH == 2) begin
	
		CmpZelgCompressorCell cell_gen_0(iv_x, iv_y, o_x, o_y);
	
	end else if(p_WIDTH > 2) begin
	
		genvar p;
	
		wire [lp_wires - 1 : 0] wv_x;
		wire [lp_wires - 1 : 0] wv_y;
	
		for(p = 0; p < lp_pairs; p = p + 1) begin : gen_cells
			CmpZelgCompressorCell cell_gen_1(iv_x[p * 2 + 1 : p * 2], iv_y[p * 2 + 1 : p * 2], wv_x[p], wv_y[p]);
		end
		
		if(lp_tail) begin
			assign wv_x[lp_wires - 1] = iv_x[p_WIDTH - 1];
			assign wv_y[lp_wires - 1] = iv_y[p_WIDTH - 1];
		end
		
		CmpZelgCompressor #(.p_WIDTH(lp_wires)) cmp_gen_0(wv_x, wv_y, o_x, o_y);
		
	end

endgenerate

endmodule // CmpZelgCompressor


//===================================================
// 
// CmpZelg
// 
// Size  : O(N)
// Depth : O(log(N))
// 
//===================================================
module CmpZelg
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iv_x,
	input [p_WIDTH-1:0] iv_y,
	output o_zero,
	output o_equal,
	output o_less,
	output o_greater
	);
	
wire w_x;
wire w_y;

CmpZelgCompressor #(.p_WIDTH(p_WIDTH)) cmp0(iv_x, iv_y, w_x, w_y);

assign o_zero = ~w_x & ~w_y;
assign o_equal = ~(w_x ^ w_y);
assign o_less = ~w_x & w_y;
assign o_greater = w_x & ~w_y;

endmodule // CmpZelg

