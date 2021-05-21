/////////////////////////////////////////////////////
// 
// LGEZ Comparator cell.
//
// A Less/Greater/Equal/Zero comparator module.
//
/////////////////////////////////////////////////////


///////////////////////////////
// Combinational definition. 
///////////////////////////////
module CmpLgezCellX
	(
	input i_Lx,  // less significant X bit
	input i_Ly,  // less significant Y bit
	input i_Mx,  // more significant X bit
	input i_My,  // more significant Y bit
	output o_Rx
	);
assign o_Rx = (i_Mx & ~i_My) | (i_Mx & ~i_Ly) | (~i_My & i_Lx) | (i_Mx & i_Lx);
endmodule

module CmpLgezCellY
	(
	input i_Lx,  // less significant X bit
	input i_Ly,  // less significant Y bit
	input i_Mx,  // more significant X bit
	input i_My,  // more significant Y bit
	output o_Ry
	);
assign o_Ry = (~i_Mx & i_Ly) | (i_My & i_Ly) | (i_My & ~i_Lx) | (~i_Mx & i_My);
endmodule


/////////////////////////////////////
// Switch level definitions.
/////////////////////////////////////
module CmpLgezCellXNMos
	(
	input i_X0,  // less significant X bit
	input i_Y0,  // less significant Y bit
	input i_X1,  // more significant X bit
	input i_Y1,  // more significant Y bit
	output o_Xr
	);

// input inverters
tri1 w_not_X0;
tri1 w_not_X1;
supply0 w_gnd;

nmos (w_not_X0, w_gnd, i_X0);
nmos (w_not_X1, w_gnd, i_X1);

// (i_Mx & ~i_My) | (i_Mx & ~i_Ly) | (~i_My & i_Lx) | (i_Mx & i_Lx);
wire w_0, w_1, w2;

nmos (o_Xr, w_0, w_not_X1);
nmos (w_0, w_gnd, i_Y1);
nmos (o_Xr, w_1, w_not_X0);
nmos (w_1, w_gnd, w_not_X1);
nmos (w_1, w_2, i_Y0);
nmos (w_2, w_gnd, i_Y1);

endmodule


module CmpLgezCellYNMos
	(
	input i_X0,  // less significant X bit
	input i_Y0,  // less significant Y bit
	input i_X1,  // more significant X bit
	input i_Y1,  // more significant Y bit
	output o_Yr
	);

// input inverters
tri1 w_not_Y0;
tri1 w_not_Y1;
supply0 w_gnd;

nmos (w_not_Y0, w_gnd, i_Y0);
nmos (w_not_Y1, w_gnd, i_Y1);

// (~i_Mx & i_Ly) | (i_My & i_Ly) | (i_My & ~i_Lx) | (~i_Mx & i_My);
wire w_0, w_1, w2;

nmos (o_Yr, w_0, i_X1);
nmos (w_0, w_gnd, w_not_Y1);
nmos (o_Yr, w_1, w_not_Y0);
nmos (w_1, w_gnd, w_not_Y1);
nmos (w_1, w_2, i_X1);
nmos (w_2, w_gnd, i_X0);

endmodule


///////////////////////////////////////
// Basic comparator cell.
// Combinational definition.
///////////////////////////////////////
module CmpLgezCell
	(
	input i_Lx,  // less significant X bit
	input i_Ly,  // less significant Y bit
	input i_Mx,  // more significant X bit
	input i_My,  // more significant Y bit
	output o_Rx,
	output o_Ry
	);

CmpLgezCellX m_x(i_Lx, i_Ly, i_Mx, i_My, o_Rx);
CmpLgezCellY m_y(i_Lx, i_Ly, i_Mx, i_My, o_Ry);

endmodule


///////////////////////////////////////
// N-Mos Basic comparator cell.
// Switch level definitions.
///////////////////////////////////////
module CmpLgezCellNMos
	(
	input i_Lx,  // less significant X bit
	input i_Ly,  // less significant Y bit
	input i_Mx,  // more significant X bit
	input i_My,  // more significant Y bit
	output o_Rx,
	output o_Ry
	);

tri1 w_pull_up_x;
tri1 w_pull_up_y;

assign o_Rx = w_pull_up_x;
assign o_Ry = w_pull_up_y;

CmpLgezCellXNMos m_x(i_Lx, i_Ly, i_Mx, i_My, o_Rx);
CmpLgezCellYNMos m_y(i_Lx, i_Ly, i_Mx, i_My, o_Ry);

endmodule


///////////////////////////////////////
// 
///////////////////////////////////////
module CmpLgez2Bit
	#(parameter p_NMOS = 0)
	(
	input [1:0] iv_x,
	input [1:0] iv_y,
	output o_Rx,
	output o_Ry
	);

if(p_NMOS)
	CmpLgezCellNMos d0(iv_x[0], iv_y[0], iv_x[1], iv_y[1], o_Rx, o_Ry);
else
	CmpLgezCell d0(iv_x[0], iv_y[0], iv_x[1], iv_y[1], o_Rx, o_Ry);

endmodule


module Dummy3Bit
	(
	input [2:0] iv_x,
	input [2:0] iv_y,
	output o_Rx,
	output o_Ry
	);

wire [1:0] wv_rx;
wire [1:0] wv_ry;

assign o_Rx = wv_rx[1];
assign o_Ry = wv_ry[1];

CmpLgezCell d0(iv_x[0], iv_y[0], iv_x[1], iv_y[1], wv_rx[0], wv_ry[0]);
CmpLgezCell d1(wv_rx[0], wv_ry[0], iv_x[2], iv_y[2], wv_rx[1], wv_ry[1]);

endmodule


module Dummy4Bit
	(
	input [3:0] iv_x,
	input [3:0] iv_y,
	output o_Rx,
	output o_Ry
	);

wire [1:0] wv_rx;
wire [1:0] wv_ry;

CmpLgezCell d0(iv_x[0], iv_y[0], iv_x[1], iv_y[1], wv_rx[0], wv_ry[0]);
CmpLgezCell d1(wv_rx[0], wv_ry[0], iv_x[2], iv_y[2], wv_rx[1], wv_ry[1]);
CmpLgezCell d2(wv_rx[1], wv_ry[1], iv_x[3], iv_y[3], o_Rx, o_Ry);

endmodule

module Dummy5Bit
	(
	input [4:0] iv_x,
	input [4:0] iv_y,
	output o_Rx,
	output o_Ry
	);

wire [3:0] wv_rx;
wire [3:0] wv_ry;

CmpLgezCell d0(iv_x[0], iv_y[0], iv_x[1], iv_y[1], wv_rx[0], wv_ry[0]);
CmpLgezCell d1(wv_rx[0], wv_ry[0], iv_x[2], iv_y[2], wv_rx[1], wv_ry[1]);
CmpLgezCell d2(wv_rx[1], wv_ry[1], iv_x[3], iv_y[3], wv_rx[2], wv_ry[2]);
CmpLgezCell d3(wv_rx[2], wv_ry[2], iv_x[4], iv_y[4], o_Rx, o_Ry);

endmodule


module CmpLgezNBit
	#(parameter p_WIDTH = 2)
	(
	input [p_WIDTH-1:0] iv_x,
	input [p_WIDTH-1:0] iv_y,
	output o_Rx,
	output o_Ry
	);

initial begin
	if(p_WIDTH < 2) begin
		$error("p_WIDTH < 2");
		$finish;
	end
end

wire [p_WIDTH-2:0] wv_rx;
wire [p_WIDTH-2:0] wv_ry;

assign o_Rx = wv_rx[p_WIDTH-2];
assign o_Ry = wv_ry[p_WIDTH-2];

CmpLgezCell d0(iv_x[0], iv_y[0], iv_x[1], iv_y[1], wv_rx[0], wv_ry[0]);

generate
	genvar i;
	for(i = 0; i < p_WIDTH - 2; i = i + 1) begin
		CmpLgezCell dx(wv_rx[i], wv_ry[i], iv_x[i + 2], iv_y[i + 2], wv_rx[i + 1], wv_ry[i + 1]);
	end

endgenerate

endmodule


