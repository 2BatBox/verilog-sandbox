`include "lib-tb/assert.v"
`include "lib/alu/ParityPrefix.v"

module top_generic #(parameter p_ARG_WIDTH = 1) (output wo_complete);

localparam ARG_RANGE = $pow(2, p_ARG_WIDTH);

reg [p_ARG_WIDTH - 1 : 0] rv_in = 0;
wire [p_ARG_WIDTH - 1 : 0] wv_out_ref;
wire [p_ARG_WIDTH - 1 : 0] wv_out;

reg r_complete = 0;

assign wo_complete = r_complete;

__ParityPrexixReference #(.p_WIDTH(p_ARG_WIDTH)) reference(.iwv_in(rv_in), .owv_out(wv_out_ref));
ParityPrefix #(.p_WIDTH(p_ARG_WIDTH)) uut(.iwv_in(rv_in), .owv_out(wv_out));

integer i;

initial begin

	for(i = 0; i < ARG_RANGE; ++i) begin
		rv_in = i;
		#p_ARG_WIDTH;
		
//		$display("| %b | %b | %b |", rv_in, wv_out_ref, wv_out);
		`assert_eq(wv_out, wv_out_ref);
	end
	
	r_complete <= 1;

end

endmodule // top_generic



module top();

localparam WIDTH_MAX = 12;

wire [WIDTH_MAX-1 : 0] rv_complete;

generate
	genvar i;
	for(i = 1; i <= WIDTH_MAX; i = i + 1) begin : get_top
		top_generic #(.p_ARG_WIDTH(i)) top_gen_0(rv_complete[i - 1]);
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


