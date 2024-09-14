/////////////////////////////////////////////////////
//
//  UartBitSampler.
//
/////////////////////////////////////////////////////
module UartBitSampler
	#(
		parameter CLK_PERIOD = 2 // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		output o_sample,
		output o_reset
	);
	
localparam WIDTH = $clog2(CLK_PERIOD);
localparam RESET = CLK_PERIOD - 1;
localparam SAMPLE = (CLK_PERIOD / 2) - 1;

reg [WIDTH-1:0] rv_counter;

generate
	if(CLK_PERIOD > 3)
		assign o_sample = (rv_counter == SAMPLE);
	else
		assign o_sample = (~i_reset) & (rv_counter == SAMPLE);
endgenerate


assign o_reset = (rv_counter == RESET);

always @(posedge i_clk) begin
	if(i_reset | o_reset)
		rv_counter <= 0;
	else
		rv_counter <= rv_counter + 1;
end
	
endmodule // UartBitSampler



/////////////////////////////////////////////////////
//
//  UART transmitter.
//
//  Payload with parity bit.
//  | < -----------------------  WIDTH_TX_TOTAL  ---------------------------------- > |
//  |                                                                                 |
//  | Start |Data_0 |Data_1 |Data_2 |  ...  |Data_N |Parity |Sto0 |Sto1 |  ...  |StoN |
//  |       |                                       |       |                         |
//  |       | < --------- WIDTH_DATA ------------ > |       | < ---- WIDTH_STOP --- > |
//  |                                                       |
//  | < --------------  WIDTH_PAYLOAD  ------------------ > |
//
//
//  Payload without parity bit.
//  | < ---------------------  WIDTH_TX_TOTAL  ---------------------------- > |
//  |                                                                         |
//  | Start |Data_0 |Data_1 |Data_2 |  ...  |Data_N |Sto0 |Sto1 |  ...  |StoN |
//  |       |                                       |                         |
//  |       | < --------- WIDTH_DATA ------------ > | < ---- WIDTH_STOP --- > |
//  |                                               |
//  | < -----------  WIDTH_PAYLOAD  ------------- > |
//
//
//
/////////////////////////////////////////////////////
module UartTx
	#(
		parameter WIDTH_DATA = 1, // Must be greater than zero.
		parameter IS_PARITY = 1,
		parameter IS_PARITY_ODD = 0,
		parameter WIDTH_STOP = 1, // Must be greater than zero.
		parameter CLK_PERIOD = 4 // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		input [WIDTH_DATA-1:0] iv_data,
		input i_data_ready,
		output o_tx,
		output o_busy
	);

localparam WIDTH_PARITY = IS_PARITY ? 1 : 0;
localparam WIDTH_PAYLOAD = 1/*start bit*/ + WIDTH_DATA + WIDTH_PARITY;
localparam WIDTH_TX_TOTAL = WIDTH_PAYLOAD + WIDTH_STOP;
localparam WIDTH_TX_CNT = $clog2(WIDTH_TX_TOTAL + 1);

// Bit indeses in payload vector.
localparam IDX_START = 0;
localparam IDX_DATA_LSB = 1;
localparam IDX_DATA_MSB = WIDTH_DATA;
localparam IDX_PARITY = IDX_DATA_MSB + (IS_PARITY ? 1 : 0);

reg [WIDTH_PAYLOAD-1:0] rv_tx_payload;
reg [WIDTH_TX_TOTAL-1:0] rv_tx_cnt;

wire [WIDTH_PAYLOAD-1:0] wv_tx_payload_next;
assign wv_tx_payload_next[IDX_START] = 1'b0;
assign wv_tx_payload_next[IDX_DATA_MSB:IDX_DATA_LSB] = iv_data;

wire w_state_empty = (rv_tx_cnt == 0);
wire w_sampler_reset = i_reset | w_state_empty;
wire w_sampler_period;

assign o_tx = rv_tx_payload[0];
assign o_busy = ~w_state_empty;

generate
	if(IS_PARITY) begin
		wire w_parity_data = ^iv_data;
		assign wv_tx_payload_next[IDX_PARITY] = (IS_PARITY_ODD ? (~w_parity_data) : w_parity_data);
	end
endgenerate

UartBitSampler #(.CLK_PERIOD(CLK_PERIOD)) sampler(.i_clk(i_clk), .i_reset(w_sampler_reset), .o_reset(w_sampler_period));

always @(posedge i_clk) begin
	if(i_reset) begin
		rv_tx_payload[0] <= 1'b1;
		rv_tx_cnt <= 0;
	end else begin
		if(w_state_empty) begin
			if(i_data_ready) begin
				rv_tx_payload <= wv_tx_payload_next;
				rv_tx_cnt <= WIDTH_TX_TOTAL;
			end
		end else if(w_sampler_period) begin
			rv_tx_payload <= {1'b1, rv_tx_payload[WIDTH_PAYLOAD-1:1]};
			rv_tx_cnt <= rv_tx_cnt - 1;
		end
	end
end

endmodule // UartTx


/////////////////////////////////////////////////////
//
//  An asynchronous serial receiver.
// 
//  Payload with parity bit.
//  | Start |Data_0 |Data_1 |Data_2 |  ...  |Data_N |Parity |Sto0 |Sto1 |  ...  |StoN |
//          |                                       |       |                         |
//          | < ---------- WIDTH_DATA ----------- > |       | < ---- WIDTH_STOP --- > |
//          |                                                                         |
//          | < ----------------------  WIDTH_PAYLOAD  ---------------------------- > |
//
//
//  Payload without parity bit.
//  | Start |Data_0 |Data_1 |Data_2 |  ...  |Data_N |Sto0 |Sto1 |  ...  |StoN |
//          |                                       |                         |
//          | < ---------- WIDTH_DATA ----------- > | < ---- WIDTH_STOP --- > |
//          |                                                                 |
//          | < ------------------  WIDTH_PAYLOAD  ------------------------ > |
//
/////////////////////////////////////////////////////


module UartRx
	#(
		parameter WIDTH_DATA = 1, // Must be greater than zero.
		parameter IS_PARITY = 1,
		parameter IS_PARITY_ODD = 0,
		parameter WIDTH_STOP = 1, // Must be greater than zero.
		parameter CLK_PERIOD = 4 // Must be greater than one.
	)(
		input i_clk,
		input i_reset,
		input i_rx,
		output [WIDTH_DATA-1:0] ov_data,
		output o_data_ready
	);
	
localparam WIDTH_PARITY = IS_PARITY ? 1 : 0;	
localparam WIDTH_PAYLOAD = WIDTH_DATA + WIDTH_PARITY + WIDTH_STOP;
localparam WIDTH_RX_CNT = $clog2(WIDTH_PAYLOAD + 1);

// Bit indeses in payload vector.
localparam IDX_DATA_LSB = 0;
localparam IDX_DATA_MSB = WIDTH_DATA - 1;
localparam IDX_PARITY = IDX_DATA_MSB + WIDTH_PARITY;
localparam IDX_STOLSB = IDX_PARITY + 1;
localparam IDX_STOMSB = IDX_STOLSB + WIDTH_STOP - 1;

localparam [1:0] STATE_WAIT_LINE = 2'b00;
localparam [1:0] STATE_READY     = 2'b01;
localparam [1:0] STATE_START     = 2'b11;
localparam [1:0] STATE_RX        = 2'b10;

reg [1:0] rv_state;
reg [WIDTH_PAYLOAD-1:0] rv_rx_payload;
reg [WIDTH_RX_CNT-1:0] rv_rx_cnt;

wire w_state_last = (rv_rx_cnt == 1);
wire w_state_full = (rv_rx_cnt == 0);

wire w_sampler_reset = (i_reset | (~rv_state[1]));
wire w_sampler_sample;

wire w_stobits_check = &rv_rx_payload[IDX_STOMSB:IDX_STOLSB];
wire w_parity_check;

assign ov_data = rv_rx_payload[IDX_DATA_MSB:IDX_DATA_LSB];
assign o_data_ready = w_state_full & w_stobits_check & w_parity_check;

generate
	if(IS_PARITY) begin
		wire w_parity_data = ^ov_data;
		wire w_parity_bit = rv_rx_payload[IDX_PARITY];
		wire w_parity_odd = w_parity_data ^ w_parity_bit;
		assign w_parity_check = (IS_PARITY_ODD ? w_parity_odd : (~w_parity_odd));
	end else begin
		assign w_parity_check = 1'b1;
	end
endgenerate

UartBitSampler #(.CLK_PERIOD(CLK_PERIOD)) sampler(.i_clk(i_clk), .i_reset(w_sampler_reset), .o_sample(w_sampler_sample));

always @(posedge i_clk) begin

	if(i_reset) begin
		rv_state <= STATE_WAIT_LINE;
		rv_rx_cnt <= WIDTH_PAYLOAD;
	end else begin
	
		case(rv_state)
		
			STATE_WAIT_LINE : begin
				if(i_rx) 
					rv_state <= STATE_READY;
			end
			
			STATE_READY : begin
				if(~i_rx) 
					rv_state <= STATE_START;
			end
			
			STATE_START : begin
				if(i_rx) begin
					rv_state <= STATE_READY;	
				end else begin
					if(w_sampler_sample) begin
						rv_state <= STATE_RX;		
						rv_rx_cnt <= WIDTH_PAYLOAD;
					end
				end
			end
			
			STATE_RX : begin
				if(w_sampler_sample) begin
					rv_rx_payload <= {i_rx, rv_rx_payload[WIDTH_PAYLOAD-1:1]};
					rv_rx_cnt <= (rv_rx_cnt - 1);
					if(w_state_last) begin
						rv_state <= STATE_WAIT_LINE;	
					end
				end
			end
			
		endcase
	
	end

end

endmodule // UartRx


/*

initial begin
	$display("UartRx");
	$display("---------------------------");
	$display("WIDTH_DATA      = %-d", WIDTH_DATA);
	$display("IS_PARITY      = %-d", IS_PARITY);
	$display("IS_PARITY_ODD  = %-d", IS_PARITY_ODD);
	$display("WIDTH_STOP      = %-d", WIDTH_STOP);
	$display("CLK_PERIOD     = %-d", CLK_PERIOD);
	$display("---------------------------");
	$display("IDX_START      = %-d", IDX_START);
	$display("WIDTH_PAYLOAD   = %-d", WIDTH_PAYLOAD);
	$display("WIDTH_PARITY    = %-d", WIDTH_PARITY);
	$display("WIDTH_RX_CNT    = %-d", WIDTH_RX_CNT);
	$display("---------------------------");
	$display("IDX_START    = [%d]", IDX_START);
	$display("IDX_DATA     = [%d:%d]", IDX_DATA_MSB, IDX_DATA_LSB);
	$display("IDX_PARITY   = [%d]", IDX_PARITY);
	$display("IDX_STOP     = [%d:%d]", IDX_STOMSB, IDX_STOLSB);
	$display("---------------------------");
end

*/

