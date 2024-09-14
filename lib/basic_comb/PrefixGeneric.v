// ---- WARNING ----
// PRIFIX_NAME and PRIFIX_OPERATION macros must be definded before including.
// Example :
// `define PRIFIX_NAME Xor
// `define PRIFIX_OPERATION ^

//===================================================
//
// __PrefixGenericReference
//
// Size  : O(N)
// Depth : O(N)
//
//===================================================
module __GenericPrefixReference`PRIFIX_NAME
	#(
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);
	
generate

	genvar i;

	if(WIDTH > 0) begin
	
		assign owv_out[0] = iwv_in[0];

		for(i = 1; i < WIDTH; i = i + 1) begin : gen_prefix
			assign owv_out[i] = iwv_in[i] `PRIFIX_OPERATION owv_out[i - 1];
		end
	
	end

endgenerate

endmodule // __GenericPrefixReference`PRIFIX_NAME




//===================================================
//
// ParityPrefix
// 
// Size  : O(N*log(N))
// Depth : O(log(N))
//
//===================================================
module GenericPrefix`PRIFIX_NAME
	#(
	parameter WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [WIDTH-1:0] iwv_in,
	output [WIDTH-1:0] owv_out
	);
	
localparam DEPTH = $clog2(WIDTH);

wire [WIDTH-1:0] wvv_net [DEPTH-1:0];

assign owv_out = wvv_net[DEPTH-1];

generate

	genvar i;
	genvar j;
	
	for(j = 0; j < WIDTH; j = j + 1) begin : iterate_by_width
		assign wvv_net[0][j] = (j % 2) ? iwv_in[j] `PRIFIX_OPERATION iwv_in[j-1] : iwv_in[j];
	end
	
	for(i = 1; i < DEPTH; i = i + 1) begin : iterate_by_depth
		for(j = 0; j < WIDTH; j = j + 1) begin : iterate_by_width
			
			if(((j >> i) % 2))
				assign wvv_net[i][j] = wvv_net[i-1][j] `PRIFIX_OPERATION wvv_net[i-1][((j >> i) << i) - 1];
			else
				assign wvv_net[i][j] = wvv_net[i-1][j];
			
		end
	end
	
endgenerate

endmodule // GenericPrefix`PRIFIX_NAME
