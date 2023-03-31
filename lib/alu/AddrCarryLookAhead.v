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
// Output carry Statuses
// C S
// -----------------
// 0 0 - k  Kill
// 0 1 - p  Propagate
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
	parameter p_WIDTH = 2, // MUST BE greater than zero.
	parameter p_BLOCK_SIZE = 1   // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_carry,   // The input value of iwv_carry[0] MUST be 1'b0.
	input [p_WIDTH-1:0] iwv_sum,     // The input value of iwv_sum[0] MUST be 1'b0.
	output [p_WIDTH-1:0] owv_out     
	);
	
generate

	genvar i;

	if(p_BLOCK_SIZE >= p_WIDTH) begin
	
		assign owv_out = iwv_carry;
		
	end else begin
	
		wire [p_WIDTH-1:0] wv_next_carry;
		wire [p_WIDTH-1:0] wv_next_sum;
		
		for(i = 0; i < p_WIDTH; i = i + 1) begin : tree_layer
			localparam block_idx = (i / p_BLOCK_SIZE);
			localparam state_idx = block_idx * p_BLOCK_SIZE - 1;
			
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
			
		__AddrCarryLookAheadCSResolver #(.p_WIDTH(p_WIDTH), .p_BLOCK_SIZE(p_BLOCK_SIZE * 2)) prefix_tree_0(wv_next_carry, wv_next_sum, owv_out);
		
	end

endgenerate

endmodule // __AddrCarryLookAheadCSResolver



module AddrCarryLookAhead
	#(
	parameter p_WIDTH = 2 // MUST BE greater than zero.
	)
	(
	input [p_WIDTH-1:0] iwv_x,
	input [p_WIDTH-1:0] iwv_y,
	input iw_carry,
	
	output [p_WIDTH:0] owv_carry,
	output [p_WIDTH:0] owv_sum,
	output [p_WIDTH:0] owv_cs,
	
	output [p_WIDTH:0] owv_output
	);
	
localparam SUM_WIDTH = p_WIDTH + 1;
	
wire [SUM_WIDTH-1:0] wv_symbols_carry = {iwv_x & iwv_y, iw_carry};
wire [SUM_WIDTH-1:0] wv_symbols_sum = {1'b0, iwv_x ^ iwv_y};

wire [SUM_WIDTH-1:0] wv_carry_statuses;

__AddrCarryLookAheadCSResolver #(.p_WIDTH(SUM_WIDTH)) resolver(wv_symbols_carry, wv_symbols_sum, wv_carry_statuses);
	
assign owv_output = 1'b0;//wv_symbols_carry[CARRY_STATUSES_WIDTH-1:1] ^ wv_symbols_sum[CARRY_STATUSES_WIDTH-1:1] ^ wv_carry_statuses[CARRY_STATUSES_WIDTH-2:0];

assign owv_carry = wv_symbols_carry;
assign owv_sum = wv_symbols_sum;
assign owv_cs = wv_carry_statuses;

endmodule // AddrCarryLookAhead


