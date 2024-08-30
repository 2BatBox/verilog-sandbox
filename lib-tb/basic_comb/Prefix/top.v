`include "lib-tb/assert.v"
`include "lib/basic_comb/Prefix.v"

module top;

localparam p_WIDTH = 7;

localparam ARG_RANGE = $pow(2, p_WIDTH);

reg [p_WIDTH - 1 : 0] rv_in = 0;
wire [p_WIDTH - 1 : 0] wv_out_ref;
wire [p_WIDTH - 1 : 0] wv_out;

__PrefixReferenceXor #(.p_WIDTH(p_WIDTH)) reference(.iwv_in(rv_in), .owv_out(wv_out_ref));
PrefixXor #(.p_WIDTH(p_WIDTH)) uut(.iwv_in(rv_in), .owv_out(wv_out));

initial begin

	integer i;

	for(i = 0; i < ARG_RANGE; ++i) begin
		rv_in = i;
		#p_WIDTH;
		
		$display("| %b | %b | %b |", rv_in, wv_out_ref, wv_out);
		`assert_eq(wv_out, wv_out_ref);
	end
	
	`assert_pass;

end

initial begin
//	$dumpfile("Prefix.vcd");
//	$dumpvars(0, top);
end


endmodule // top


