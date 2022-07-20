`include "lib/alu/Gray.v"
`include "lib/io/SyncChain.v"

/////////////////////////////////////////////////////
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
/////////////////////////////////////////////////////

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
	
	
	//////////////////////////////////
	// Store side clock domain.
	//////////////////////////////////
	
	reg [lp_CNT_WIDTH - 1 : 0] wr_stored_gray = 0; // TODO: wrrst
	wire [lp_CNT_WIDTH - 1 : 0] wr_stored_gray_next;
	wire [lp_CNT_WIDTH - 1 : 0] wr_stored_bin;
	wire [lp_CNT_WIDTH - 1 : 0] wr_stored_bin_next = wr_stored_bin + wr_stored_inc;
	wire [lp_CNT_WIDTH - 1 : 0] wr_loaded_gray;	
	wire [lp_CNT_WIDTH - 1 : 0] wr_loaded_bin;
	wire [lp_CNT_WIDTH - 1 : 0] wr_items = wr_stored_bin - wr_loaded_bin;
	wire wr_stored_inc = wrena & (~full);
	
	assign full = ~(wr_items < p_CAPACITY);	

	Bin2Gray #(.p_WIDTH(p_WIDTH)) wr_bin2gray_stored_next (wr_stored_bin_next, wr_stored_gray_next);
	Gray2Bin #(.p_WIDTH(p_WIDTH)) wr_grey2bin_stored (wr_stored_gray, wr_stored_bin);
	Gray2Bin #(.p_WIDTH(p_WIDTH)) wr_grey2bin_loaded (wr_loaded_gray, wr_loaded_bin);
	
	always@(posedge wrclk) begin
		wr_stored_gray <= wr_stored_gray_next;
	end
	
	
	//////////////////////////////////
	// Load side clock domain.
	//////////////////////////////////
	
	reg [lp_CNT_WIDTH - 1 : 0] rd_loaded_gray = 0; // TODO: rdrst
	wire [lp_CNT_WIDTH - 1 : 0] rd_loaded_gray_next;
	wire [lp_CNT_WIDTH - 1 : 0] rd_loaded_bin;
	wire [lp_CNT_WIDTH - 1 : 0] rd_loaded_bin_next = rd_loaded_bin + rd_loaded_inc;
	wire [lp_CNT_WIDTH - 1 : 0] rd_stored_gray;	
	wire [lp_CNT_WIDTH - 1 : 0] rd_stored_bin;
	wire rd_loaded_inc = rdena & (~empty);
	
	assign empty = (rd_stored_bin == rd_loaded_bin);
	
	Bin2Gray #(.p_WIDTH(p_WIDTH)) rd_bin2gray_loaded_next (rd_loaded_bin_next, rd_loaded_gray_next);
	Gray2Bin #(.p_WIDTH(p_WIDTH)) rd_grey2bin_loaded (rd_loaded_gray, rd_loaded_bin);
	Gray2Bin #(.p_WIDTH(p_WIDTH)) rd_grey2bin_stored (rd_stored_gray, rd_stored_bin);
	
	always@(posedge rdclk) begin
		rd_loaded_gray <= rd_loaded_gray_next;
	end
	

	//////////////////////////////////
	// Clock domain crossing chains.
	//////////////////////////////////

	SyncChain #(.p_WIDTH(p_WIDTH), .p_DEPTH(lp_SYNC_CHAIN_DEPTH)) wr_sync_chain_loaded_gray(wrclk, wrrst, rd_loaded_gray, wr_loaded_gray); // TODO: wrrst
	SyncChain #(.p_WIDTH(p_WIDTH), .p_DEPTH(lp_SYNC_CHAIN_DEPTH)) rd_sync_chain_stored_gray(rdclk, rdrst, wr_stored_gray, rd_stored_gray); // TODO: rdrst


endmodule // Fifo
