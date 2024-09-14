`include "lib-tb/assert.v"
`include "lib/io/Fifo.v"

module top();

//=====================================
// The testbench configuration.
//=====================================
	
// The data bus width. MUST BE greater than zero.
localparam WIDTH = 8;   

 // The fifo instance capacity. MUST BE greater than zero.
localparam CAPACITY = 99;

// WR side clock domain period.
localparam WR_CLOCK_PERIOD = 33;

// RD side clock domain period.
localparam RD_CLOCK_PERIOD = 50;

// Cross domain period shift
localparam CLOCK_PERIOD_SHIFT = 1;


//=====================================
// The testbench state.
//=====================================
integer test_clk_shift = CLOCK_PERIOD_SHIFT;

reg [63:0] test_wr_remain;
reg [63:0] test_rd_remain;

wire test_wr_enable = (test_wr_remain > 0) & ~uut_full;
wire test_rd_enable = (test_rd_remain > 0) & ~uut_empty;


//=====================================
// UUT depended paramters.
//=====================================
localparam SIGNAL_LOW = 1'b0;
localparam SIGNAL_HIGH = ~SIGNAL_LOW;
localparam DELAY_RESET = 5;
localparam DELAY_DOMAIN_CROSSING = 2;


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

reg [WIDTH - 1 : 0] uut_wr_data;
reg [WIDTH - 1 : 0] uut_rd_data_expected;
wire [WIDTH - 1 : 0] uut_rd_data;

Fifo
	#(
		.WIDTH(WIDTH),
		.CAPACITY(CAPACITY)
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
	#WR_CLOCK_PERIOD uut_wr_clk = ~uut_wr_clk;
end

always begin
	#test_clk_shift;
	test_clk_shift <= 0;
	#RD_CLOCK_PERIOD uut_rd_clk = ~uut_rd_clk;
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
	repeat(DELAY_DOMAIN_CROSSING) begin
		@(negedge uut_wr_clk);
	end
endtask


// Wait for Reading side to be synchronized with the Writing side.
task sync_rd;
	repeat(DELAY_DOMAIN_CROSSING) begin
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

		uut_wr_reset = SIGNAL_LOW;
		uut_rd_reset = SIGNAL_LOW;

		uut_wr_enable = SIGNAL_LOW;
		uut_rd_enable = SIGNAL_LOW;

		uut_wr_data = 0;
		uut_rd_data_expected = 0;
	end
endtask

// Reseting the FIFO from WR side clock domain.
task reset_wr;
	begin
		@(negedge uut_wr_clk);
		uut_wr_reset = SIGNAL_LOW;
		uut_wr_data = 0;
		
		@(negedge uut_wr_clk);
		uut_wr_reset = SIGNAL_HIGH;
		
		repeat(DELAY_RESET) begin
			@(negedge uut_wr_clk);
			@(negedge uut_rd_clk);
		end
		uut_wr_reset = SIGNAL_LOW;
		
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
		uut_rd_reset = SIGNAL_LOW;
	
		@(negedge uut_rd_clk);
		uut_rd_reset = SIGNAL_HIGH;
		
		repeat(DELAY_RESET) begin
			@(negedge uut_wr_clk);
			@(negedge uut_rd_clk);
		end
		uut_rd_reset = SIGNAL_LOW;
		
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
	$display("\t WIDTH              : %-d", WIDTH);
	$display("\t CAPACITY           : %-d", CAPACITY);
	$display("\t WR_CLOCK_PERIOD    : %-d", WR_CLOCK_PERIOD);
	$display("\t RD_CLOCK_PERIOD    : %-d", RD_CLOCK_PERIOD);
	$display("\t CLOCK_PERIOD_SHIFT : %-d", CLOCK_PERIOD_SHIFT);
	
	$display("UUT:");
	$display("\t SYNC_CHAIN_DEPTH   : %-d", uut.SYNC_CHAIN_DEPTH);
	$display("\t CNT_WIDTH          : %-d", uut.CNT_WIDTH);
	$display("\t CAPACITY_MEM       : %-d", uut.CAPACITY_MEM);

	init_bench();

	// Initial resetting from both the sides.
	reset_wr();
	reset_rd();
	
	// Put some items to the FIFO then reset it from WR side.
	process_wr(CAPACITY / 2);
	process_wr_wait();
	reset_wr();
	
	// Put some items to the FIFO then reset it from RD side.
	process_wr(CAPACITY / 2);
	process_wr_wait();
	reset_rd();
	
	// Fill the FIFO then reset it from WR side.
	process_wr(CAPACITY);
	process_wr_wait();
	reset_wr();
	// Fill the FIFO then reset it from RD side.
	process_wr(CAPACITY);
	process_wr_wait();
	reset_rd();
	
	// Put some items to the FIFO then read them all.
	process_wr(CAPACITY / 2);
	process_wr_wait();
	
	process_rd(CAPACITY / 2);
	process_rd_wait();
	
	check_empty();
	
	// Fill the FIFO then drain it.
	process_wr(CAPACITY);
	process_wr_wait();
	
	process_rd(CAPACITY);
	process_rd_wait();
	
	check_empty();
	// Concurent writing/reading test.
	process_wr(CAPACITY * 10);
	process_rd(CAPACITY * 10);
	
	process_wr_wait();
	process_rd_wait();
	
	check_empty();
	
	`assert_pass;
end

endmodule // top

