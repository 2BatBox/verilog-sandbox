module DemoCmpZelg
(
	//Clock Input
//	input [1:0] CLOCK_24,  // 24 MHz
//	input [1:0] CLOCK_27,  // 27 MHz
	input       CLOCK_50,  // 50 MHz
//	input       EXT_CLOCK, // External Clock

	// Push Button
	input [3:0] BUTTONS, // Active - LOW

	// DPDT Switch
	input [9:0] SW, // Active - HIGH
	
	// LED, Active - HIGH
	output [9:0] LEDR,
	output [7:0] LEDG


	//7-SEG Dispaly, Active - LOW
//	output [6:0] HEX0,
//	output [6:0] HEX1,
//	output [6:0] HEX2,
//	output [6:0] HEX3,

	// UART
//	output UART_TXD,
//	input  UART_RXD,

	// VGA
//	output VGA_HS,      // VGA H_SYNC
//	output VGA_VS,      // VGA V_SYNC
//	output [3:0] VGA_R, // VGA Red[3:0]
//	output [3:0] VGA_G, // VGA Green[3:0]
//	output [3:0] VGA_B, // VGA Blue[3:0]

	// Audio CODEC
//	inout  AUD_ADCLRCK, // ADC LR Clock
//	input  AUD_ADCDAT,  // ADC Data
//	inout  AUD_DACLRCK, // DAC LR Clock
//	output AUD_DACDAT,  // DAC Data
//	inout  AUD_BCLK,    // Bit-Stream Clock
//	output AUD_XCK,     // Chip Clock

	// SRAM Interface
//	inout  [15:0] SRAM_DQ,   // Data bus 16 Bits
//	output [17:0] SRAM_ADDR, // Address bus 18 Bits
//	output SRAM_UB_N,        // High-byte Data Mask 
//	output SRAM_LB_N,        // Low-byte Data Mask 
//	output SRAM_WE_N,        // Write Enable
//	output SRAM_CE_N,        // Chip Enable
//	output SRAM_OE_N,        // Output Enable

	// SDRAM
//	inout  [15:0] DRAM_DQ,   // SDRAM Data bus 16 Bits
//	output [11:0] DRAM_ADDR, // SDRAM Address bus 12 Bits
//	output DRAM_LDQM,        // SDRAM Low-byte Data Mask 
//	output DRAM_UDQM,        // SDRAM High-byte Data Mask
//	output DRAM_WE_N,        // SDRAM Write Enable
//	output DRAM_CAS_N,       // SDRAM Column Address Strobe
//	output DRAM_RAS_N,       // SDRAM Row Address Strobe
//	output DRAM_CS_N,        // SDRAM Chip Select
//	output DRAM_BA_0,        // SDRAM Bank Address 0
//	output DRAM_BA_1,        // SDRAM Bank Address 0
//	output DRAM_CLK,         // SDRAM Clock
//	output DRAM_CKE,         // SDRAM Clock Enable

	// Flash Interface
//	inout  [7:0]  FL_DQ,   // Data bus 8 Bits
//	output [21:0] FL_ADDR, // Address bus 22 Bits
//	output FL_WE_N,        // Write Enable
//	output FL_RST_N,       // Reset
//	output FL_OE_N,        // Output Enable
//	output FL_CE_N,        // Chip Enable
	
	// SD Card Interface
//	inout  SD_DAT,  //Data
//	inout  SD_DAT3, //Data 3
//	inout  SD_CMD,  //Command Signal
//	output SD_CLK,  //Clock
	
	// I2C
//	inout  I2C_SDAT,
//	output I2C_SCLK,

	// PS2
//	input PS2_DAT,
//	input PS2_CLK,

	// USB JTAG link
//	input  TDI, // CPLD -> FPGA (data in)
//	input  TCK, // CPLD -> FPGA (clk)
//	input  TCS, // CPLD -> FPGA (CS)
//	output TDO, // FPGA -> CPLD (data out)

	// GPIO
//	inout[35:0] GPIO_0, // GPIO Connection 0
//	inout[35:0] GPIO_1  // GPIO Connection 1
);

//assign LEDR = SW;
//assign LEDG = {BUTTONS, BUTTONS};

CmpZelg #(.p_WIDTH(5)) cmp0(SW[9:5], SW[4:0], LEDR[3], LEDR[2], LEDR[1], LEDR[0]);

endmodule
