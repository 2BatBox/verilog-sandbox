`include "lib-tb/assert.v"
`include "lib/io/Fifo.v"

module top();

//=====================================
// The testbench configuration.
//=====================================
	
// The data bus width. MUST BE greater than zero.
localparam lp_WIDTH = 8;   

 // The fifo instance capacity. MUST BE greater than zero.
localparam lp_CAPACITY = 99;

// WR side clock domain period.
localparam lp_WR_CLOCK_PERIOD = 33;

// RD side clock domain period.
localparam lp_RD_CLOCK_PERIOD = 50;

// Cross domain period shift
localparam lp_CLOCK_PERIOD_SHIFT = 1;


//=====================================
// The testbench state.
//=====================================
integer test_clk_shift = lp_CLOCK_PERIOD_SHIFT;

reg [63:0] test_wr_remain;
reg [63:0] test_rd_remain;

wire test_wr_enable = (test_wr_remain > 0) & ~uut_full;
wire test_rd_enable = (test_rd_remain > 0) & ~uut_empty;


//=====================================
// UUT depended paramters.
//=====================================
localparam p_SIGNAL_LOW = 1'b0;
localparam p_SIGNAL_HIGH = ~p_SIGNAL_LOW;
localparam p_DELAY_RESET = 5;
localparam p_DELAY_DOMAIN_CROSSING = 2;


//=====================================
// UUT
//=====================================
reg uut_wr_clk;
reg uut_rd_clk;

reg uut_wr_reset;
reg uut_rd_reset;

reg uut_wr_enable;
reg uut_rd_enable;

wire uut_full;
wire uut_empty;

reg [lp_WIDTH - 1 : 0] uut_wr_data;
reg [lp_WIDTH - 1 : 0] uut_rd_data_expected;
wire [lp_WIDTH - 1 : 0] uut_rd_data;

Fifo
	#(
		.p_WIDTH(lp_WIDTH),
		.p_CAPACITY(lp_CAPACITY)
	)
	uut
	(
		.wrrst(uut_wr_reset),
		.wrclk(uut_wr_clk),
		.wrdata(uut_wr_data),
		.wrena(uut_wr_enable),
		
		.rdrst(uut_rd_reset),
		.rdclk(uut_rd_clk),
		.rdena(uut_rd_enable),
		.rddata(uut_rd_data),
		.full(uut_full),
		.empty(uut_empty)
	);
	
	
//=====================================
// Clock domains
//=====================================
always begin
	#lp_WR_CLOCK_PERIOD uut_wr_clk = ~uut_wr_clk;
end

always begin
	#test_clk_shift;
	test_clk_shift <= 0;
	#lp_RD_CLOCK_PERIOD uut_rd_clk = ~uut_rd_clk;
end


//=====================================
// Wrting / reading processes.
//=====================================
always@(negedge uut_wr_clk) begin
	uut_wr_enable <= test_wr_enable;
	uut_wr_data <= uut_wr_data + uut_wr_enable;	
	
	test_wr_remain <= test_wr_remain - test_wr_enable;
end

always@(negedge uut_rd_clk) begin
	uut_rd_enable <= test_rd_enable;
	uut_rd_data_expected <= uut_rd_data_expected + test_rd_enable;
	
	test_rd_remain <= test_rd_remain - uut_rd_enable;
	
	if(test_rd_enable) begin
//		$display("rd=%b, rde=%b", uut_rd_data, uut_rd_data_expected);
		
		`assert(uut_rd_data === uut_rd_data_expected);
	end
end


//=====================================
// The testbench tast set.
//=====================================

// Wait for Writing side to be synchronized with the Reading side.
task sync_wr;
	repeat(p_DELAY_DOMAIN_CROSSING) begin
		@(negedge uut_wr_clk);
	end
endtask


// Wait for Reading side to be synchronized with the Writing side.
task sync_rd;
	repeat(p_DELAY_DOMAIN_CROSSING) begin
		@(negedge uut_rd_clk);
	end
endtask


// Wait for both Wrinting and Reading sides to be synchronized with each other.
task sync;
	begin
		sync_wr();
		sync_rd();
	end
endtask


// Set inital test bench state.
task init_bench;
	begin
	
		$dumpfile("Fifo.vcd");
		$dumpvars(0, top);
	
		test_wr_remain = 0;
		test_rd_remain = 0;
	
		uut_wr_clk = 0;
		uut_rd_clk = 0;

		uut_wr_reset = p_SIGNAL_LOW;
		uut_rd_reset = p_SIGNAL_LOW;

		uut_wr_enable = p_SIGNAL_LOW;
		uut_rd_enable = p_SIGNAL_LOW;

		uut_wr_data = 0;
		uut_rd_data_expected = 0;
	end
endtask

// Reseting the FIFO from WR side clock domain.
task reset_wr;
	begin
		@(negedge uut_wr_clk);
		uut_wr_reset = p_SIGNAL_LOW;
		uut_wr_data = 0;
		
		@(negedge uut_wr_clk);
		uut_wr_reset = p_SIGNAL_HIGH;
		
		repeat(p_DELAY_RESET) begin
			@(negedge uut_wr_clk);
			@(negedge uut_rd_clk);
		end
		uut_wr_reset = p_SIGNAL_LOW;
		
		@(negedge uut_wr_clk);
		`assert(~uut_full);
		
		sync_rd();
		
		`assert(uut_empty);
	end
endtask


// Reseting the FIFO from Reading side clock domain.
task reset_rd;
	begin
		@(negedge uut_rd_clk);
		uut_rd_reset = p_SIGNAL_LOW;
	
		@(negedge uut_rd_clk);
		uut_rd_reset = p_SIGNAL_HIGH;
		
		repeat(p_DELAY_RESET) begin
			@(negedge uut_wr_clk);
			@(negedge uut_rd_clk);
		end
		uut_rd_reset = p_SIGNAL_LOW;
		
		@(negedge uut_rd_clk);
		`assert(uut_empty);
		
		sync_wr();
		
		`assert(~uut_full);
	end
endtask


task process_wr;
input [63:0] items;
	begin
		`assert(test_wr_remain == 0);
		@(posedge uut_wr_clk);
		@(negedge uut_wr_clk);
		uut_wr_data = 0;
		@(posedge uut_wr_clk);
		test_wr_remain = items;
		@(posedge uut_wr_clk);
	end
endtask

task process_rd;
input [63:0] items;
	begin
		`assert(test_rd_remain == 0);
		@(posedge uut_rd_clk);
		@(negedge uut_rd_clk);
		uut_rd_data_expected = 0;
		@(posedge uut_rd_clk);
		test_rd_remain = items;
		@(posedge uut_rd_clk);
	end
endtask

task process_wr_wait;
	if(test_wr_remain > 0)
		@(test_wr_remain == 0);
	@(negedge uut_wr_clk);
endtask		

task process_rd_wait;
	if(test_rd_remain > 0)
		@(test_rd_remain == 0);
	@(negedge uut_rd_clk);
endtask		


task check_empty;
	begin
		`assert(uut_empty);
		`assert(uut_empty);
	end
endtask		


initial begin

	$display("Test bench:");
	$display("\t lp_WIDTH              : %-d", lp_WIDTH);
	$display("\t lp_CAPACITY           : %-d", lp_CAPACITY);
	$display("\t lp_WR_CLOCK_PERIOD    : %-d", lp_WR_CLOCK_PERIOD);
	$display("\t lp_RD_CLOCK_PERIOD    : %-d", lp_RD_CLOCK_PERIOD);
	$display("\t lp_CLOCK_PERIOD_SHIFT : %-d", lp_CLOCK_PERIOD_SHIFT);
	
	$display("UUT:");
	$display("\t lp_SYNC_CHAIN_DEPTH   : %-d", uut.lp_SYNC_CHAIN_DEPTH);
	$display("\t lp_CNT_WIDTH          : %-d", uut.lp_CNT_WIDTH);
	$display("\t lp_CAPACITY_MEM       : %-d", uut.lp_CAPACITY_MEM);

	init_bench();

	// Initial resetting from both the sides.
	reset_wr();
	reset_rd();
	
	// Put some items to the FIFO then reset it from WR side.
	process_wr(lp_CAPACITY / 2);
	process_wr_wait();
	reset_wr();
	
	// Put some items to the FIFO then reset it from RD side.
	process_wr(lp_CAPACITY / 2);
	process_wr_wait();
	reset_rd();
	
	// Fill the FIFO then reset it from WR side.
	process_wr(lp_CAPACITY);
	process_wr_wait();
	reset_wr();
	// Fill the FIFO then reset it from RD side.
	process_wr(lp_CAPACITY);
	process_wr_wait();
	reset_rd();
	
	// Put some items to the FIFO then read them all.
	process_wr(lp_CAPACITY / 2);
	process_wr_wait();
	
	process_rd(lp_CAPACITY / 2);
	process_rd_wait();
	
	check_empty();
	
	// Fill the FIFO then drain it.
	process_wr(lp_CAPACITY);
	process_wr_wait();
	
	process_rd(lp_CAPACITY);
	process_rd_wait();
	
	check_empty();
	// Concurent writing/reading test.
	process_wr(lp_CAPACITY * 10);
	process_rd(lp_CAPACITY * 10);
	
	process_wr_wait();
	process_rd_wait();
	
	check_empty();
	
	`assert_pass;
end

endmodule // top

