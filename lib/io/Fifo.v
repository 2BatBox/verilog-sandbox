`include "lib/alu/Gray.v"
`include "lib/io/SyncChain.v"

//=====================================-------------------------------
//
//  Asynchronous FIFO
//  1. Overview
//  • implement asynchronous 2 clocks FIFO based on true asynchronous
//  clock Block Random Access Memory primitive using SystemVerilog/Verilog
//  programming language
//  • write timing constraints for FIFO
//  • write testbench for verification using SystemVerilog/Verilog program-
//  ming language (any simulator is acceptable)
// 
//  2. Interfaces
//  2.1
//  IN
//  • wrrst - ”write” FIFO logic reset. active=1
//  • wrclk - ”write” FIFO logic clock
//  • wrdata - write data bus. width is parameterized
//  • wrena - enable write signal. active=1
//  • rdrst - ”read” FIFO logic reset. active=1
//  • rdclk - ”read” FIFO logic clock
//  • rdena - enable read signal. active=1
//
//  2.2
//  OUT
//  • rddata - read data bus. width is the same as wrdata
//  • full - full flag
//  • empty - empty flag
// 
//=====================================-------------------------------

module Fifo
	#(
		// The data bus width. MUST BE greater than zero.
		parameter p_WIDTH = 1,    
		
		 // The fifo instance capacity. MUST BE greater than zero.
		parameter p_CAPACITY = 1
	)
	
	(
		// ”write” FIFO logic reset. active=1
		input wire wrrst,
		
		// ”write” FIFO logic clock
		input wire wrclk,
		
		// Write data bus.
		input wire [p_WIDTH - 1 : 0] wrdata,
		
		// Enable write signal. active=1
		input wire wrena,
		
		// ”read” FIFO logic reset. active=1
		input wire rdrst,
		
		// ”read” FIFO logic clock
		input wire rdclk,
		
		// Enable read signal. active=1
		input wire rdena,

		// Read data bus.
		output wire [p_WIDTH - 1 : 0] rddata,
		
		// Full flag.
		output wire full,
		
		// Empty flag.
		output wire empty
	);
	
	localparam lp_SYNC_CHAIN_DEPTH = 2;
	localparam lp_CNT_WIDTH = $clog2(p_CAPACITY + 1);
	localparam lp_CAPACITY_MEM = 1 << lp_CNT_WIDTH;
	
	//=====================================
	// Ring buffer.
	//=====================================
	reg [p_WIDTH - 1 : 0] block_ram[lp_CAPACITY_MEM];
	
	
	//=====================================
	// Writing side.
	//=====================================
	
	// 'stored' counter.
	wire [lp_CNT_WIDTH - 1 : 0] wr_stored_gray;
	wire [lp_CNT_WIDTH - 1 : 0] wr_stored_bin;
	
	// The writing side view of 'loaded' counter.
	wire [lp_CNT_WIDTH - 1 : 0] wr_loaded_gray;	
	wire [lp_CNT_WIDTH - 1 : 0] wr_loaded_bin;
	
	wire [lp_CNT_WIDTH - 1 : 0] wr_items = wr_stored_bin - wr_loaded_bin;
	
	wire wr_rdrst;
	wire wr_full = ~(wr_items < p_CAPACITY);
	
	assign full = wr_full | wrrst | wr_rdrst;
	
	wire wr_stored_inc = ~full & wrena;
	
	GrayIncCounter #(.p_WIDTH(lp_CNT_WIDTH))
		wr_gray_cnt_stored
		(
			.iw_clk(wrclk),
			.iw_reset(wrrst | wr_rdrst),
			.iw_inc(wr_stored_inc),
			.owv_bin(wr_stored_bin),
			.owv_gray(wr_stored_gray)
		);
	
	Gray2Bin #(.p_WIDTH(lp_CNT_WIDTH)) wr_grey2bin_loaded (wr_loaded_gray, wr_loaded_bin);
	
	always@(posedge wrclk) begin
		if(wr_stored_inc)
			block_ram[wr_stored_bin] <= wrdata;
	end
	
	
	//=====================================
	// Reading side.
	//=====================================
	
	// 'loaded' counter.
	wire [lp_CNT_WIDTH - 1 : 0] rd_loaded_gray;
	wire [lp_CNT_WIDTH - 1 : 0] rd_loaded_bin;
	
	// The reading side view of 'stored' counter.
	wire [lp_CNT_WIDTH - 1 : 0] rd_stored_gray;	
	wire [lp_CNT_WIDTH - 1 : 0] rd_stored_bin;
	
	wire rd_wrrst;
	wire rd_empty = (rd_stored_bin == rd_loaded_bin); 
	wire rd_loaded_inc = rdena & (~empty);
	
	assign rddata = block_ram[rd_loaded_bin];
	assign empty = rd_empty | rdrst | rd_wrrst;
	
	GrayIncCounter #(.p_WIDTH(lp_CNT_WIDTH))
		rd_gray_cnt_loaded
		(
			.iw_clk(rdclk),
			.iw_reset(rdrst | rd_wrrst),
			.iw_inc(rd_loaded_inc),
			.owv_bin(rd_loaded_bin),
			.owv_gray(rd_loaded_gray)
		);
	
	Gray2Bin #(.p_WIDTH(lp_CNT_WIDTH)) rd_grey2bin_stored (rd_stored_gray, rd_stored_bin);
	
	
	//=====================================
	// Clock domain crossing chains.
	//=====================================
	SyncChain #(.p_WIDTH(lp_CNT_WIDTH + 1), .p_DEPTH(lp_SYNC_CHAIN_DEPTH))
		wr_sync_chain_loaded_gray
		(
			wrclk,
			{ rdrst, rd_loaded_gray },
			{ wr_rdrst, wr_loaded_gray }
		);
		
	SyncChain #(.p_WIDTH(lp_CNT_WIDTH + 1), .p_DEPTH(lp_SYNC_CHAIN_DEPTH))
		rd_sync_chain_stored_gray
		(
			rdclk,
			{ wrrst, wr_stored_gray },
			{ rd_wrrst, rd_stored_gray }
		);


endmodule // Fifo

