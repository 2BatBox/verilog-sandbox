`include "lib-tb/assert.v"
`include "lib/io/Fifo.v"

module top();

localparam p_WIDTH = 3;
localparam p_CAPACITY = 7;
localparam WR_CLOCK_PERIOD = 10;
localparam RD_CLOCK_PERIOD = 10;
localparam CLOCK_PERIOD_SHIFT = 5;


//=====================================
// UUT depended paramters.
//=====================================
localparam p_SIGNAL_RESET = 1;
localparam p_DELAY_RESET = 5;
localparam p_DELAY_DOMAIN_CROSSING = 2;


//=====================================
// The testbench state.
//=====================================
integer i;
integer rw_idx;
integer clk_shift = CLOCK_PERIOD_SHIFT;


//=====================================
// UUT
//=====================================
reg uut_wr_clk = 0;
reg uut_rd_clk = 0;

reg uut_wr_reset = 0;
reg uut_rd_reset = 0;

reg uut_wr_enable = 0;
reg uut_rd_enable = 0;

wire uut_full;
wire uut_empty;

reg [p_WIDTH - 1 : 0] uut_wr_data;
wire [p_WIDTH - 1 : 0] uut_rd_data;

Fifo
	#(
		.p_WIDTH(p_WIDTH),
		.p_CAPACITY(p_CAPACITY)
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
	#clk_shift;
	clk_shift <= 0;
	#RD_CLOCK_PERIOD uut_rd_clk = ~uut_rd_clk;
end


//=====================================
// The testbench tast set.
//=====================================

// Wait for Writing side to be synchronized with the Reading side.
task sync_wr;
	repeat(p_DELAY_DOMAIN_CROSSING) begin
		@(posedge uut_wr_clk);
	end
endtask

// Wait for Reading side to be synchronized with the Writing side.
task sync_rd;
	repeat(p_DELAY_DOMAIN_CROSSING) begin
		@(posedge uut_rd_clk);
	end
endtask	

// Wait for both Wrinting and Reading sides to be synchronized with each other.
task sync;
	begin
		sync_wr();
		sync_rd();
	end
endtask	

// Reseting the FIFO from WR side clock domain.
// Affects: uut_wr_reset;
task reset_wr;
	begin
		@(negedge uut_wr_clk);
		uut_wr_reset <= p_SIGNAL_RESET;
		
		repeat(p_DELAY_RESET) begin
			@(negedge uut_wr_clk);
			@(negedge uut_rd_clk);
		end
		uut_wr_reset <= ~p_SIGNAL_RESET;
		
		@(negedge uut_wr_clk);
		`assert(~uut_full);
		
		sync_rd();
		
		`assert(uut_empty);
	end
endtask

// Reseting the FIFO from Reading side clock domain.
// Affects: uut_rd_reset;
task reset_rd;
	begin
		@(negedge uut_rd_clk);
		uut_rd_reset <= p_SIGNAL_RESET;
		
		repeat(p_DELAY_RESET) begin
			@(negedge uut_wr_clk);
			@(negedge uut_rd_clk);
		end
		uut_rd_reset <= ~p_SIGNAL_RESET;
		
		@(negedge uut_rd_clk);
		`assert(uut_empty);
		
		sync_wr();
		
		`assert(~uut_full);
	end
endtask


// Writing to the FIFO 'items' elements.
// Affects: uut_wr_data, uut_wr_enable;
task write;
input integer items;
	begin
	
		uut_wr_data = 0;
		uut_wr_enable = 0;
		
		@(negedge uut_wr_clk);
		
		while(~uut_full & uut_wr_data < items) begin
			uut_wr_enable = 1;
			@(negedge uut_wr_clk);
			uut_wr_data++;
		end
		uut_wr_enable = 0;
		
		sync_rd();		
		
		`assert(uut_empty == (items == 0));
		
	end
endtask


// Reading from the FIFO 'items' elements.
// Affects: uut_wr_data, uut_rd_enable;
task read;
input integer items;
	begin
		uut_wr_data = 0;
		uut_rd_enable = 0;
		
		@(negedge uut_rd_clk);
		
		while(~uut_empty & uut_wr_data < items) begin
			uut_rd_enable = 1;
			`assert(uut_rd_data == uut_wr_data);			
			@(negedge uut_rd_clk);
			uut_wr_data++;
		end
		uut_rd_enable = 0;
		
		sync_wr();		
		
	end
endtask


// Writing to the FIFO 'items' elements.
// Affects: uut_wr_data, uut_wr_enable, uut_rd_enable;
task write_read;
input integer items;
	begin
	
		uut_wr_enable = 0;
		uut_rd_enable = 0;
	
		for(rw_idx = 0; rw_idx < items; rw_idx++) begin
			
			uut_wr_data = rw_idx;
		
			// Waiting for free space.
			@(negedge uut_wr_clk & ~uut_full);
			
			// Write one item.
			uut_wr_enable = 1;
			@(negedge uut_wr_clk);
			uut_wr_enable = 0;
			
			sync_rd();
			@(negedge uut_rd_clk);
			`assert(~uut_empty);
			uut_rd_enable = 1;
//			$display("read=%d idx=%d", uut_rd_data, rw_idx);
			`assert(uut_rd_data == uut_wr_data);			
			@(negedge uut_rd_clk);
			uut_rd_enable = 0;
			
		end

		`assert(~uut_full);
		sync_rd();		
		`assert(uut_empty);
		
	end
endtask

initial begin

	// Initial resetting from both the sides.
	reset_wr();
	reset_rd();
	
	// Writing side resetting.	
	for(i = 1; i <= p_CAPACITY; i++) begin
		write(i);
		reset_wr();
	end
	
	// Reading side resetting.	
	for(i = 1; i <= p_CAPACITY; i++) begin
		write(i);
		sync_rd();
		reset_rd();
	end
	
	// Block writing/reading.
	for(i = 1; i <= p_CAPACITY; i++) begin
		write(i);
		read(i);
	end
	
	// Sequental writing/reading.
	for(i = 1; i <= p_CAPACITY * 10; i++) begin
		write_read(i);
	end
	
	`assert_pass;
end

initial begin
	$dumpfile("Fifo.vcd");
	$dumpvars(0, top);
end

endmodule // top
