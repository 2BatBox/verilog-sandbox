`define PRIFIX_NAME Xor
`define PRIFIX_OPERATION ^

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
module __GenericPrefixReferencXor
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
generate

	genvar i;

	if(p_WIDTH > 0) begin
	
		assign owv_out[0] = iwv_in[0];

		for(i = 1; i < p_WIDTH; i = i + 1) begin : gen_prefix
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
module GenericPrefixXor
	#(
	parameter p_WIDTH = 2 // MUST BE greater than one.
	)
	(
	input [p_WIDTH-1:0] iwv_in,
	output [p_WIDTH-1:0] owv_out
	);
	
localparam p_DEPTH = $clog2(p_WIDTH);

wire [p_WIDTH-1:0] wvv_net [p_DEPTH-1:0];

assign owv_out = wvv_net[p_DEPTH-1];

generate

	genvar i;
	genvar j;
	
	for(j = 0; j < p_WIDTH; j = j + 1) begin : iterate_by_width
		assign wvv_net[0][j] = (j % 2) ? iwv_in[j] `PRIFIX_OPERATION iwv_in[j-1] : iwv_in[j];
	end
	
	for(i = 1; i < p_DEPTH; i = i + 1) begin : iterate_by_depth
		for(j = 0; j < p_WIDTH; j = j + 1) begin : iterate_by_width
			
			if(((j >> i) % 2))
				assign wvv_net[i][j] = wvv_net[i-1][j] `PRIFIX_OPERATION wvv_net[i-1][((j >> i) << i) - 1];
			else
				assign wvv_net[i][j] = wvv_net[i-1][j];
			
		end
	end
	
endgenerate

endmodule // GenericPrefix`PRIFIX_NAME


module bin_enc_dec
(
// --------------------------
// Push Button
// --------------------------
	input [3:0] KEYS, // Active - LOW

// --------------------------
// DPDT Switch
// --------------------------
	input [9:0] SW, // Active - HIGH
	
// --------------------------
// LED, Active - HIGH
// --------------------------
	output [9:0] LEDR,
	output [7:0] LEDG
);

GenericPrefixXor #(.p_WIDTH(10)) enc(SW, LEDR);

endmodule
