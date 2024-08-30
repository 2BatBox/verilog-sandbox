module blank
(
// --------------------------
//	Clock Input
// --------------------------	
//[CLOCK_24]	input [1:0] CLOCK_24,  // 24 MHz
//[CLOCK_27]	input [1:0] CLOCK_27,  // 27 MHz
//[CLOCK_50]	input       CLOCK_50,  // 50 MHz
//[CLOCK_EXT]	input       EXT_CLOCK, // External Clock

// --------------------------
// Push Button
// --------------------------
//[KEYS]	input [3:0] KEYS, // Active - LOW

// --------------------------
// DPDT Switch
// --------------------------
//[SWITCHES]	input [9:0] SW, // Active - HIGH
	
// --------------------------
// LED, Active - HIGH
// --------------------------
//[LEDR]	output [9:0] LEDR,
//[LEDG]	output [7:0] LEDG,

// --------------------------
// 7-SEG Dispaly, Active - LOW
// --------------------------
//[HEX0]	output [6:0] HEX0,
//[HEX1]	output [6:0] HEX1,
//[HEX2]	output [6:0] HEX2,
//[HEX3]	output [6:0] HEX3,

// --------------------------
// UART
// --------------------------
//[UART]	output UART_TXD,
//[UART]	input  UART_RXD,

// --------------------------
// VGA
// --------------------------
//[VGA]	output VGA_HS,      // VGA H_SYNC
//[VGA]	output VGA_VS,      // VGA V_SYNC
//[VGA]	output [3:0] VGA_R, // VGA Red[3:0]
//[VGA]	output [3:0] VGA_G, // VGA Green[3:0]
//[VGA]	output [3:0] VGA_B, // VGA Blue[3:0]

// --------------------------
// Audio CODEC
// --------------------------
//[AUDIO]	inout  AUD_ADCLRCK, // ADC LR Clock
//[AUDIO]	input  AUD_ADCDAT,  // ADC Data
//[AUDIO]	inout  AUD_DACLRCK, // DAC LR Clock
//[AUDIO]	output AUD_DACDAT,  // DAC Data
//[AUDIO]	inout  AUD_BCLK,    // Bit-Stream Clock
//[AUDIO]	output AUD_XCK,     // Chip Clock

// --------------------------
// SRAM Interface
// --------------------------
//[SRAM]	inout  [15:0] SRAM_DQ,   // Data bus 16 Bits
//[SRAM]	output [17:0] SRAM_ADDR, // Address bus 18 Bits
//[SRAM]	output SRAM_UB_N,        // High-byte Data Mask 
//[SRAM]	output SRAM_LB_N,        // Low-byte Data Mask 
//[SRAM]	output SRAM_WE_N,        // Write Enable
//[SRAM]	output SRAM_CE_N,        // Chip Enable
//[SRAM]	output SRAM_OE_N,        // Output Enable

// --------------------------
// SDRAM
// --------------------------
//[SDRAM]	inout  [15:0] DRAM_DQ,   // SDRAM Data bus 16 Bits
//[SDRAM]	output [11:0] DRAM_ADDR, // SDRAM Address bus 12 Bits
//[SDRAM]	output DRAM_LDQM,        // SDRAM Low-byte Data Mask 
//[SDRAM]	output DRAM_UDQM,        // SDRAM High-byte Data Mask
//[SDRAM]	output DRAM_WE_N,        // SDRAM Write Enable
//[SDRAM]	output DRAM_CAS_N,       // SDRAM Column Address Strobe
//[SDRAM]	output DRAM_RAS_N,       // SDRAM Row Address Strobe
//[SDRAM]	output DRAM_CS_N,        // SDRAM Chip Select
//[SDRAM]	output DRAM_BA_0,        // SDRAM Bank Address 0
//[SDRAM]	output DRAM_BA_1,        // SDRAM Bank Address 0
//[SDRAM]	output DRAM_CLK,         // SDRAM Clock
//[SDRAM]	output DRAM_CKE,         // SDRAM Clock Enable

// --------------------------
// Flash Interface
// --------------------------
//[FLASH]	inout  [7:0]  FL_DQ,   // Data bus 8 Bits
//[FLASH]	output [21:0] FL_ADDR, // Address bus 22 Bits
//[FLASH]	output FL_WE_N,        // Write Enable
//[FLASH]	output FL_RST_N,       // Reset
//[FLASH]	output FL_OE_N,        // Output Enable
//[FLASH]	output FL_CE_N,        // Chip Enable
	
// --------------------------
// SD Card Interface
// --------------------------
//[SDCARD]	inout  SD_DAT,  //Data
//[SDCARD]	inout  SD_DAT3, //Data 3
//[SDCARD]	inout  SD_CMD,  //Command Signal
//[SDCARD]	output SD_CLK,  //Clock
	
// --------------------------
// I2C
// --------------------------
//[I2C]	inout  I2C_SDAT,
//[I2C]	output I2C_SCLK,

// --------------------------
// PS2
// --------------------------
//[PS2]	input PS2_DAT,
//[PS2]	input PS2_CLK,

// --------------------------
// USB JTAG link
// --------------------------
//[USB]	input  TDI, // CPLD -> FPGA (data in)
//[USB]	input  TCK, // CPLD -> FPGA (clk)
//[USB]	input  TCS, // CPLD -> FPGA (CS)
//[USB]	output TDO, // FPGA -> CPLD (data out)

// --------------------------
// GPIO
// --------------------------
//[GPIO_0]	input[35:0] GPIO_0, // GPIO Connection 0
//[GPIO_1]	input[35:0] GPIO_1  // GPIO Connection 1
);

endmodule
