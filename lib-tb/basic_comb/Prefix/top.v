`include "lib-tb/assert.v"
`include "lib/basic_comb/Prefix.v"

module top;

localparam WIDTH = 7;

localparam ARG_RANGE = $pow(2, WIDTH);

reg [WIDTH - 1 : 0] rv_in = 0;
wire [WIDTH - 1 : 0] wv_out_ref;
wire [WIDTH - 1 : 0] wv_out;

__PrefixReferenceXor #(.WIDTH(WIDTH)) reference(.iwv_in(rv_in), .owv_out(wv_out_ref));
PrefixXor #(.WIDTH(WIDTH)) uut(.iwv_in(rv_in), .owv_out(wv_out));

initial begin

	integer i;

	for(i = 0; i < ARG_RANGE; ++i) begin
		rv_in = i;
		#WIDTH;
		
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


