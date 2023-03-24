`include "lib-tb/assert.v"
`include "lib/alu/CmpZelg.v"

module top_generic #(parameter p_ARG_WIDTH = 1) (output wo_complete);

localparam CLOCK_PERIOD = 1;
localparam ARG_RANGE = $pow(2, p_ARG_WIDTH);

reg [p_ARG_WIDTH - 1:0] rv_x = 0;
reg [p_ARG_WIDTH - 1:0] rv_y = 0;
reg r_complete = 0;

wire w_zero;
wire w_equal;
wire w_less;
wire w_greater;

assign wo_complete = r_complete;

CmpZelg #(.p_WIDTH(p_ARG_WIDTH)) uut(.iv_x(rv_x), .iv_y(rv_y), .o_zero(w_zero), .o_equal(w_equal), .o_less(w_less), .o_greater(w_greater));

integer i;
integer j;

initial begin

	for(i = 0; i < ARG_RANGE; ++i) begin
		for(j = 0; j < ARG_RANGE; ++j) begin
			rv_x = i;
			rv_y = j;
			#1;

//			$display("| %b | %b | %b | %b |", rv_x, rv_y, w_x, w_y);
//			$display("| %b | %b | Z=%b E=%b L=%b G=%b |", rv_x, rv_y, w_zero, w_equal, w_less, w_greater);
			
			if(rv_x > rv_y) begin
				`assert_eq(w_zero, 0);
				`assert_eq(w_equal, 0);
				`assert_eq(w_greater, 1);
				`assert_eq(w_less, 0);
			end
			
			if(rv_x < rv_y) begin
				`assert_eq(w_zero, 0);
				`assert_eq(w_equal, 0);
				`assert_eq(w_greater, 0);
				`assert_eq(w_less, 1);
			end
			
			if(rv_x == rv_y) begin
			
				if(rv_x) begin
					`assert_eq(w_zero, 0);
				end else begin
					`assert_eq(w_zero, 1);
				end
			
				`assert_eq(w_equal, 1);
				`assert_eq(w_greater, 0);
				`assert_eq(w_less, 0);
				
			end

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
	$dumpfile("CmpZelg.vcd");
	$dumpvars(0, top);
end

endmodule // top


