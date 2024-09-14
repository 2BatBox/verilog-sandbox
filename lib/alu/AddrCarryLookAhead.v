//===================================================
//
// Carry Statuses propagation function.
//
// C - Carry, S - Sum
// Input carry Statuses: 
// C S
// -----------------
// 0 0 - k  Kill
// 0 1 - p  Propagate
// 1 0 - p  Propagate
// 1 1 - g  Generate
//
//             | k p g <- Input
//           --|-------
// State -> *k | k k g
//           p | k p g
//           g | k g(g) <- impossible state transition
//
//
//===================================================
module __AddrCarryLookAheadCSPFunction
	(
	input [1:0] iwv_state,
	input [1:0] iwv_input,
	output [1:0] owv_state_next
	);
	
assign owv_state_next[0] =
	(iwv_input[1] & iwv_input[0]) |
	(iwv_state[0] & iwv_input[0]) |
	(iwv_state[0] & iwv_input[1]) |
	(iwv_state[1] & iwv_input[0]) |
	(iwv_state[1] & iwv_input[1]);

assign owv_state_next[1] =
	(iwv_input[1] & iwv_input[0]) |
	(iwv_state[1] & iwv_state[0] & iwv_input[0]) |
	( iwv_state[1] & iwv_state[0] & iwv_input[1]);

endmodule // __AddrCarryLookAheadCSPFunction


//===================================================
//
// Carry Statuses propagation resolver.
// 
// Size  : O(N)
// Depth : O(log(N))
//
//===================================================
module __AddrCarryLookAheadCSResolver
	#(
	parameter WIDTH = 2, // MUST BE greater than zero.
	parameter BLOCK_SIZE = 1   // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iwv_carry,   // The input value of iwv_carry[0] MUST be 1'b0.
	input [WIDTH-1:0] iwv_sum,     // The input value of iwv_sum[0] MUST be 1'b0.
	output [WIDTH-1:0] owv_out     
	);
	
generate

	genvar i;

	if(BLOCK_SIZE >= WIDTH) begin
	
		assign owv_out = iwv_carry;
		
	end else begin
	
		wire [WIDTH-1:0] wv_next_carry;
		wire [WIDTH-1:0] wv_next_sum;
		
		for(i = 0; i < WIDTH; i = i + 1) begin : tree_layer
			localparam block_idx = (i / BLOCK_SIZE);
			localparam state_idx = block_idx * BLOCK_SIZE - 1;
			
			if((block_idx % 2) == 0) begin
			
				assign wv_next_carry[i] = iwv_carry[i];
				assign wv_next_sum[i] = iwv_sum[i];
				
			end else begin
			
				__AddrCarryLookAheadCSPFunction func_0(
					.iwv_state( { iwv_carry[state_idx], iwv_sum[state_idx] } ),
					.iwv_input( { iwv_carry[i], iwv_sum[i] } ),
					.owv_state_next( { wv_next_carry[i], wv_next_sum[i] } )
					);
				
			end
		end
			
		__AddrCarryLookAheadCSResolver #(.WIDTH(WIDTH), .BLOCK_SIZE(BLOCK_SIZE * 2)) prefix_tree_0(wv_next_carry, wv_next_sum, owv_out);
		
	end

endgenerate

endmodule // __AddrCarryLookAheadCSResolver



module AddrCarryLookAhead
	#(
	parameter WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [WIDTH-1:0] iwv_x,
	input [WIDTH-1:0] iwv_y,
	input iw_carry,
	
	output [WIDTH:0] owv_carry,
	output [WIDTH:0] owv_sum,
	output [WIDTH:0] owv_cs,
	
	output [WIDTH:0] owv_output
	);
	
localparam SUM_WIDTH = WIDTH + 1;
	
wire [SUM_WIDTH-1:0] wv_carry_init = {iwv_x & iwv_y, iw_carry};
wire [SUM_WIDTH-1:0] wv_sum_init = {1'b0, iwv_x ^ iwv_y};

wire [WIDTH-1:0] wv_carry;
wire [WIDTH-1:0] wv_sum;

wire [WIDTH-1:0] wv_carry_statuses;

assign wv_carry[WIDTH-1:1] = wv_carry_init[WIDTH-1:1];
assign wv_sum[WIDTH-1:1] = wv_sum_init[WIDTH-1:1];


// Setting the initial state 'Kill'.
__AddrCarryLookAheadCSPFunction pref(
	.iwv_state( { 1'b0, 1'b0 } ),
	.iwv_input( { wv_carry_init[0], wv_sum_init[0] } ),
	.owv_state_next( { wv_carry[0], wv_sum[0] } )
	);

__AddrCarryLookAheadCSResolver #(.WIDTH(WIDTH)) resolver(
	.iwv_carry(wv_carry),
	.iwv_sum(wv_sum),
	.owv_out(wv_carry_statuses)
	);
	
assign owv_output = wv_carry_init ^ wv_sum_init ^ {wv_carry_statuses, 1'b0};

assign owv_carry = wv_carry_init;
assign owv_sum = wv_sum_init;
assign owv_cs = wv_carry_statuses;

endmodule // AddrCarryLookAhead


