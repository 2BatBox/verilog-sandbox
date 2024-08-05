`include "lib-tb/assert.v"
`include "lib/alu/AddrCarryLookAhead.v"

module top_generic #(parameter p_ARG_WIDTH = 1) (input iw_carry, output wo_complete);

localparam ARG_RANGE = $pow(2, p_ARG_WIDTH);
localparam SUM_WIDTH = p_ARG_WIDTH + 1;

reg r_complete = 0;

reg [p_ARG_WIDTH-1:0] rv_x;
reg [p_ARG_WIDTH-1:0] rv_y;

wire [SUM_WIDTH-1:0] wv_output_reference = {1'b0, rv_x} + {1'b0, rv_y} + iw_carry;
wire [SUM_WIDTH-1:0] wv_output;

wire [SUM_WIDTH-1:0] wv_output_carry;
wire [SUM_WIDTH-1:0] wv_output_sum;
wire [p_ARG_WIDTH-1:0] wv_output_cs;

assign wo_complete = r_complete;

AddrCarryLookAhead #(.p_WIDTH(p_ARG_WIDTH)) uut(rv_x, rv_y, iw_carry, wv_output_carry, wv_output_sum, wv_output_cs, wv_output);

initial begin

integer x;
integer y;

	for(x = 0; x < ARG_RANGE; ++x) begin
		rv_x = x;
		for(y = 0; y < ARG_RANGE; ++y) begin
			rv_y = y;		
			#1;
			
			$display("  %b X", rv_x);
			$display("  %b Y", rv_y);
			$display(" %b Carry", wv_output_carry);
			$display(" %b Summ", wv_output_sum);
			$display(" %b  CS", wv_output_cs);
			$display(" %b X+Y ref", wv_output_reference);
			$display(" %b X+Y", wv_output);
			
			$display("");
			`assert_eq(wv_output_reference, wv_output);
			

		
		end
	end
	
	r_complete <= 1;

end

endmodule // top_generic



module top();

localparam WIDTH_MAX = 2;

wire [WIDTH_MAX-1 : 0] rv_complete;

generate
	genvar i;
	for(i = 2; i <= WIDTH_MAX; i = i + 1) begin : get_top
		top_generic #(.p_ARG_WIDTH(i)) top_gen_0(1'b0, rv_complete[i - 1]);
		top_generic #(.p_ARG_WIDTH(i)) top_gen_1(1'b1, rv_complete[i - 1]);
	end
endgenerate

initial begin
	while(~(&rv_complete)) begin
		#1;
	end
	`assert_pass;
end

initial begin
//	$dumpfile("Prefix.vcd");
//	$dumpvars(0, top);
end

endmodule // top


