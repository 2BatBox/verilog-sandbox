module empty
(
// --------------------------
//	Clock Input
// --------------------------	

// --------------------------
// Push Button
// --------------------------

// --------------------------
// DPDT Switch
// --------------------------
	input [9:0] SW, // Active - HIGH
	
// --------------------------
// LED, Active - HIGH
// --------------------------
	output [9:0] LEDR

// --------------------------
// 7-SEG Dispaly, Active - LOW
// --------------------------

// --------------------------
// UART
// --------------------------

// --------------------------
// VGA
// --------------------------

// --------------------------
// Audio CODEC
// --------------------------

// --------------------------
// SRAM Interface
// --------------------------

// --------------------------
// SDRAM
// --------------------------

// --------------------------
// Flash Interface
// --------------------------
	
// --------------------------
// SD Card Interface
// --------------------------
	
// --------------------------
// I2C
// --------------------------

// --------------------------
// PS2
// --------------------------

// --------------------------
// USB JTAG link
// --------------------------

// --------------------------
// GPIO
// --------------------------
);

assign LEDR = ~SW;

endmodule
