
// ===================================================
//
// __CmpCompressorCellUnsigned
//
// ===================================================
//
// 1. iX < iY        ->  oX < oY
// 2. iX > iY        ->  oX > oY
// 3. iX == iY == 0  ->  oX == oY == 0
// 3. iX == iY != 0  ->  oX == oY == 1
//
// U - unsigned bit
// 
// ---------------------
// | UU | UU |  U |  U |
// ---------------------
// | iX | iY | oX | oY |
// ---------------------
// | 00 | 00 |  0 |  0 |
// | 00 | 01 |  0 |  1 |
// | 00 | 10 |  0 |  1 |
// | 00 | 11 |  0 |  1 |
// | 01 | 00 |  1 |  0 |
// | 01 | 01 |  1 |  1 |
// | 01 | 10 |  0 |  1 |
// | 01 | 11 |  0 |  1 |
// | 10 | 00 |  1 |  0 |
// | 10 | 01 |  1 |  0 |
// | 10 | 10 |  1 |  1 |
// | 10 | 11 |  0 |  1 |
// | 11 | 00 |  1 |  0 |
// | 11 | 01 |  1 |  0 |
// | 11 | 10 |  1 |  0 |
// | 11 | 11 |  1 |  1 |
// ---------------------
module __CmpCompressorCellUnsigned
	(
	input [1:0] iv_x,
	input [1:0] iv_y,
	output o_x,
	output o_y
	);
	
assign o_x = (iv_x[0] & ~iv_y[1]) | (iv_x[1] & ~iv_y[0]) | (iv_x[1] & iv_x[0]) | (iv_x[1] & ~iv_y[1]);
assign o_y = (iv_y[1] & iv_y[0]) | (~iv_x[0] & iv_y[1]) | (~iv_x[1] & iv_y[0]) | (~iv_x[1] & iv_y[1]);

endmodule // __CmpCompressorCellUnsigned


// ===================================================
//
// __CmpCompressorCellSigned
//
// ===================================================
//
// 1. iX < iY        ->  oX < oY
// 2. iX > iY        ->  oX > oY
// 3. iX == iY == 0  ->  oX == oY == 0
// 3. iX == iY != 0  ->  oX == oY == 1
//
// S - signed bit
// U - unsigned bit
// 
// ---------------------
// | SU | SU |  S |  S |
// ---------------------
// | iX | iY | oX | oY |
// ---------------------
// | 00 | 00 |  0 |  0 |
// | 00 | 01 |  1 |  0 |
// | 00 | 10 |  0 |  1 |
// | 00 | 11 |  0 |  1 |
// | 01 | 00 |  0 |  1 |
// | 01 | 01 |  1 |  1 |
// | 01 | 10 |  0 |  1 |
// | 01 | 11 |  0 |  1 |
// | 10 | 00 |  1 |  0 |
// | 10 | 01 |  1 |  0 |
// | 10 | 10 |  1 |  1 |
// | 10 | 11 |  1 |  0 |
// | 11 | 00 |  1 |  0 |
// | 11 | 01 |  1 |  0 |
// | 11 | 10 |  0 |  1 |
// | 11 | 11 |  1 |  1 |
// ---------------------
module __CmpCompressorCellSigned
	(
	input [1:0] iv_x,
	input [1:0] iv_y,
	output o_x,
	output o_y
	);
	
assign o_x = (~iv_x[0] & iv_x[1]) | (iv_y[0] & ~iv_y[1]) | (iv_x[1] & ~iv_y[1]) | (iv_x[1] & iv_y[0]);
assign o_y = (iv_x[0] & ~iv_x[1]) | (~iv_y[0] & iv_y[1]) | (~iv_x[1] & iv_y[1]) | (iv_x[0] & iv_y[1]);

endmodule // __CmpCompressorCellSigned



//===================================================
//
// __CmpCompressor
//
// Size  : O(N)
// Depth : O(log(N))
//
//===================================================
module __CmpCompressorUnsigned
	#(
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iv_x,
	input [WIDTH-1:0] iv_y,
	output o_x,
	output o_y
	);
	
	localparam lpairs = WIDTH / 2;
	localparam ltail = WIDTH % 2;
	localparam lwires = lpairs + ltail;
	
generate

	if(WIDTH == 1) begin
	
		assign o_x = iv_x[0];
		assign o_y = iv_y[0];
		
	end else begin
	
		genvar p;
	
		wire [lwires - 1 : 0] wv_x;
		wire [lwires - 1 : 0] wv_y;
	
		for(p = 0; p < lpairs; p = p + 1) begin : gen_cells
			localparam idx = p * 2;
			__CmpCompressorCellUnsigned gen_cells_0(iv_x[idx + 1 : idx], iv_y[idx + 1 : idx], wv_x[p], wv_y[p]);
		end
		
		if(ltail) begin
			assign wv_x[lwires - 1] = iv_x[WIDTH - 1];
			assign wv_y[lwires - 1] = iv_y[WIDTH - 1];
		end
		
		__CmpCompressorUnsigned #(.WIDTH(lwires)) cmgen_0(wv_x, wv_y, o_x, o_y);
		
	end

endgenerate

endmodule // __CmpCompressorUnsigned


//===================================================
// 
// Size  : O(N)
// Depth : O(log(N))
// 
//===================================================
module CmpCompressorUnsigned
	#(
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input unsigned [WIDTH-1:0] iv_x,
	input unsigned [WIDTH-1:0] iv_y,
	output o_zero,
	output o_equal,
	output o_less,
	output o_greater
	);
	
wire w_x;
wire w_y;

__CmpCompressorUnsigned #(.WIDTH(WIDTH)) cmp0(iv_x, iv_y, w_x, w_y);

assign o_zero = ~w_x & ~w_y;
assign o_equal = ~(w_x ^ w_y);
assign o_less = ~w_x & w_y;
assign o_greater = w_x & ~w_y;

endmodule // CmpCompressorUnsigned


//===================================================
// 
// Size  : O(N)
// Depth : O(log(N))
// 
//===================================================
module CmpCompressorSigned
	#(
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input signed [WIDTH-1:0] iv_x,
	input signed [WIDTH-1:0] iv_y,
	output o_zero,
	output o_equal,
	output o_less,
	output o_greater
	);
	
wire w_x;
wire w_y;

generate

	if(WIDTH == 1) begin
	
		assign w_x = iv_x[0];
		assign w_y = iv_y[0];
		
	end else if(WIDTH == 2) begin
	
		__CmpCompressorCellSigned cmpc0(iv_x, iv_y, w_x, w_y);
		
	end else if(WIDTH > 2) begin
	
		wire wv_ux;
		wire wv_uy;
	
		__CmpCompressorUnsigned #(.WIDTH(WIDTH - 1)) cmp0(iv_x[WIDTH-2:0], iv_y[WIDTH-2:0], wv_ux, wv_uy);
		__CmpCompressorCellSigned cmpc0({iv_x[WIDTH-1], wv_ux}, {iv_y[WIDTH-1], wv_uy}, w_x, w_y);
	
	end

endgenerate

assign o_zero = ~w_x & ~w_y;
assign o_equal = ~(w_x ^ w_y);
assign o_less = w_x & ~w_y;
assign o_greater = ~w_x & w_y;

endmodule // CmpCompressorSigned

