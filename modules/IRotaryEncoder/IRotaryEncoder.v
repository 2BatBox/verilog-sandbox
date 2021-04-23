/////////////////////////////////////////////////////
//
//  A synchronous incremental rotary encoder driver.
//  No debouncer is necessary.
// 
/////////////////////////////////////////////////////

module IRotaryEncoder(
	input i_clk,
	input i_phase_a,
	input i_phase_b,
	output o_cnt,
	output o_cnt_cw
	);

parameter STATE_S0 = 3'b000;
parameter STATE_S1 = 3'b001;
parameter STATE_S2 = 3'b010;
parameter STATE_S3 = 3'b011;
parameter STATE_S4 = 3'b100;
parameter STATE_S5 = 3'b101;
parameter STATE_S6 = 3'b110;
parameter STATE_ERR = 3'b111;

parameter PHASE_ZERO = 2'b00;
parameter PHASE_A = 2'b01;
parameter PHASE_B = 2'b10;
parameter PHASE_AB = 2'b11;

reg [3:0] rv_state = STATE_ERR;
reg r_cnt = 0;
reg r_cnt_cw = 0;

// output wires
assign o_cnt = r_cnt;
assign o_cnt_cw = r_cnt_cw;

always@(posedge i_clk) begin

	if(r_cnt) begin
		r_cnt <= 0;
		r_cnt_cw <= 0;
	end

	case({i_phase_a, i_phase_b})
		PHASE_ZERO: begin
			rv_state <= STATE_S0;
			case (rv_state)
				STATE_S3: begin r_cnt <= 1; r_cnt_cw <= 0; end
				STATE_S6: begin r_cnt <= 1; r_cnt_cw <= 1; end
			endcase;
		end

		PHASE_A: begin
			case (rv_state)
				STATE_S0: rv_state <= STATE_S1;
				STATE_S1: rv_state <= STATE_S1;
				STATE_S2: rv_state <= STATE_S1;
				STATE_S5: rv_state <= STATE_S6;
				STATE_S6: rv_state <= STATE_S6;
				default: rv_state <= STATE_ERR;
			endcase;
		end

		PHASE_B: begin
			case (rv_state)
				STATE_S0: rv_state <= STATE_S4;
				STATE_S2: rv_state <= STATE_S3;
				STATE_S3: rv_state <= STATE_S3;
				STATE_S4: rv_state <= STATE_S4;
				STATE_S5: rv_state <= STATE_S4;
				default: rv_state <= STATE_ERR;
			endcase;
		end

		PHASE_AB: begin
			case (rv_state)
				STATE_S1: rv_state <= STATE_S2;
				STATE_S2: rv_state <= STATE_S2;
				STATE_S3: rv_state <= STATE_S2;
				STATE_S4: rv_state <= STATE_S5;
				STATE_S5: rv_state <= STATE_S5;
				STATE_S6: rv_state <= STATE_S5;
				default: rv_state <= STATE_ERR;
			endcase;
		end


	endcase;

end

endmodule
