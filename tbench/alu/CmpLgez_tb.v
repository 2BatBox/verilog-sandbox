`include "assert.v"
`include "alu/CmpLgez.v"

module CmpLgez_tb();

localparam CLOCK_PERIOD = 1;
localparam NMOS = 1;
localparam ARG_WIDTH = 3;
localparam ARG_RANGE = $pow(2, ARG_WIDTH);

localparam CMP_EQ_Z = 2'b00;
localparam CMP_EQ_NZ = 2'b11;
localparam CMP_LESS = 2'b01;
localparam CMP_GREATER = 2'b10;

reg [ARG_WIDTH - 1:0] rv_x = 0;
reg [ARG_WIDTH - 1:0] rv_y = 0;

wire w_rx;
wire w_ry;

//CmpLgez2Bit #(.p_NMOS(NMOS)) uut(rv_x, rv_y, w_rx, w_ry);
CmpLgezNBit #(.p_WIDTH(ARG_WIDTH)) uut(rv_x, rv_y, w_rx, w_ry);
//Dummy5Bit uut(rv_x, rv_y, w_rx, w_ry);

integer i;
integer j;

initial begin

	for(i = 0; i < ARG_RANGE; ++i) begin
		for(j = 0; j < ARG_RANGE; ++j) begin
			rv_x = i;
			rv_y = j;
			#1;

			$display("%b : %b -> %b", rv_x, rv_y, {w_rx, w_ry});

			case({w_rx, w_ry})
				CMP_EQ_Z: begin
					`assert_eq(rv_x, 0);
					`assert_eq(rv_y, 0);
				end

				CMP_LESS: begin
					`assert(rv_x < rv_y);
				end

				CMP_GREATER: begin
					`assert(rv_x > rv_y);
				end

				CMP_EQ_NZ: begin
					`assert(rv_x == rv_y);
					`assert_neq(rv_x, 0);
					`assert_neq(rv_y, 0);
				end

				default: begin
					$display("%b : %b -> %b", rv_x, rv_y, {w_rx, w_ry});
					`assert_fail;
				end

			endcase

		end
	end

	#1;
	`assert_pass;
end

initial begin
	$dumpfile("CmpLgez_tb.vcd");
	$dumpvars(0, CmpLgez_tb);
end

endmodule
