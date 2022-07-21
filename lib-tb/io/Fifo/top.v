`include "lib-tb/assert.v"
`include "lib/io/Fifo.v"

module top();

localparam p_WIDTH = 3;
localparam p_CAPACITY = 7;

localparam WR_CLOCK_PERIOD = 5;
localparam RD_CLOCK_PERIOD = 10;
localparam CLOCK_PERIOD_SHIFT = 0;
localparam CAPACITY = 0;
localparam DATA_INITIAL_VALUE = 7;
localparam DATA_VALUE_STEP = 3;

// Test environment.
integer clk_shift = CLOCK_PERIOD_SHIFT;

reg test_wr_enabled = 0;
reg test_rd_enabled = 0;

// UUT
reg uut_wr_clk = 0;
reg uut_rd_clk = 0;

reg uut_wr_reset = 0;
reg uut_rd_reset = 0;

reg uut_wr_enable = 0;
reg uut_rd_enable = 0;

wire uut_full;
wire uut_empty;

reg [p_WIDTH - 1 : 0] wr_data = DATA_INITIAL_VALUE;

wire [p_WIDTH - 1 : 0] rd_data;
reg [p_WIDTH - 1 : 0] rd_data_expected = DATA_INITIAL_VALUE;

// clock domains
always begin
	#WR_CLOCK_PERIOD uut_wr_clk = ~uut_wr_clk;
end

always begin
	#clk_shift;
	clk_shift <= 0;
	#RD_CLOCK_PERIOD uut_rd_clk = ~uut_rd_clk;
end

// UUT
Fifo
	#(
		.p_WIDTH(p_WIDTH),
		.p_CAPACITY(p_CAPACITY)
	)
	uut
	(
		.wrrst(uut_wr_reset),
		.wrclk(uut_wr_clk),
		.wrdata(wr_data),
		.wrena(uut_wr_enable),
		
		.rdrst(uut_rd_reset),
		.rdclk(uut_rd_clk),
		.rdena(uut_rd_enable),
		.rddata(rd_data),
		.full(uut_full),
		.empty(uut_empty)
	);
	

always@(negedge uut_wr_clk) begin
	uut_wr_enable <= test_wr_enabled & ~uut_full;
	if(uut_wr_enable) begin
		wr_data <= wr_data + DATA_VALUE_STEP;
	end
end

always@(negedge uut_rd_clk) begin
	uut_rd_enable <= test_rd_enabled & ~uut_empty;
	
	if(test_rd_enabled & ~uut_empty) begin
		rd_data_expected <= rd_data_expected + DATA_VALUE_STEP;
		$display("rd_data=%b, expected=%b", rd_data, rd_data_expected);
		`assert_eq(rd_data, rd_data_expected);
	end 
end

initial begin
	@(negedge uut_wr_clk);
	uut_wr_reset <= 1;
	@(negedge uut_wr_clk);
	uut_wr_reset <= 0;
	@(negedge uut_wr_clk);
	
	@(negedge uut_rd_clk);
	uut_rd_reset <= 1;
	@(negedge uut_rd_clk);
	uut_rd_reset <= 0;
	@(negedge uut_rd_clk);
	
	@(negedge uut_wr_clk);
	@(negedge uut_rd_clk);
	
	test_wr_enabled <= 1;
	test_rd_enabled <= 1;

	#((WR_CLOCK_PERIOD + RD_CLOCK_PERIOD) * p_CAPACITY * 10);
	`assert_pass;
end

initial begin
	$dumpfile("Fifo.vcd");
	$dumpvars(0, top);
end

endmodule // top
