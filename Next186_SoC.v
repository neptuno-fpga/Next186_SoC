// Next186 SoC NeptUNO port by DistWave

module Next186_SoC(

	input CLOCK_50,
	output	[12:0]DRAM_ADDR,
	output	[1:0]DRAM_BA,
	output	DRAM_CAS_N,
	output	DRAM_CKE,
	output	DRAM_CLK,
	output	DRAM_CS_N,
	inout		[15:0]DRAM_DQ,
	output	[1:0]DRAM_DQM,
	output	DRAM_RAS_N,
	output	DRAM_WE_N,
	output [19:0] SRAM_ADDR,
	inout [15:0] SRAM_DQ,
	output SRAM_OE_N,
	output SRAM_WE_N,
	output SRAM_UB_N,
	output SRAM_LB_N,
	output [5:0]VGA_R,
	output [5:0]VGA_G,
	output [5:0]VGA_B,
	output VGA_VSYNC,
	output VGA_HSYNC,
	output SDLED,
	input BTN_SOUTH,
	input BTN_WEST,
	inout PS2_CLKA,
	inout PS2_DATA,
	inout PS2_CLKB,
	inout PS2_DATB,
	output AUDIO_L,
	output AUDIO_R,
	output SD_nCS,
	input SD_DO,
	output SD_CK,
	output SD_DI,
	input RX_EXT,
	output TX_EXT,
	output STM_RST
);

	wire SDR_CLK;
	wire [7:0]LEDS;
	wire MCLK;
	wire SCLK;
	wire LRCLK;
	wire SDIN;
	assign DRAM_CKE = 1'b1;
	assign SRAM_ADDR = 20'h00000;
	assign SRAM_DQ[15:12] = 4'hZ;
	assign SRAM_DQ[11:8] = {LRCLK, SDIN, SCLK, MCLK};
	assign SRAM_DQ[7:0] = 8'hZZ;
	assign SRAM_OE_N = 1'b1;
	assign SRAM_WE_N = 1'b1;
	assign SRAM_UB_N = 1'b1;
	assign SRAM_LB_N = 1'b1;
	assign STM_RST = 1'b0;
	assign SDLED = ~LEDS[1];



	dd_buf sdrclk_buf
	(
		.datain_h(1'b1),
		.datain_l(1'b0),
		.outclock(SDR_CLK),
		.dataout(DRAM_CLK)
	);

	system sys_inst
	(
		.CLK_50MHZ(CLOCK_50),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.frame_on(),
		.VGA_HSYNC(VGA_HSYNC),
		.VGA_VSYNC(VGA_VSYNC),
		.sdr_CLK_out(SDR_CLK),
		.sdr_n_CS_WE_RAS_CAS({DRAM_CS_N, DRAM_WE_N, DRAM_RAS_N, DRAM_CAS_N}),
		.sdr_BA(DRAM_BA),
		.sdr_ADDR(DRAM_ADDR),
		.sdr_DATA(DRAM_DQ),
		.sdr_DQM({DRAM_DQM}),
		.LED(LEDS),
		.BTN_RESET(~BTN_SOUTH),
		.BTN_NMI(~BTN_WEST),
		.RS232_DCE_RXD(RX_EXT),
		.RS232_DCE_TXD(TX_EXT),
		.RS232_EXT_RXD(),
		.RS232_EXT_TXD(),
		.SD_n_CS(SD_nCS),
		.SD_DI(SD_DI),
		.SD_CK(SD_CK),
		.SD_DO(SD_DO),
		.AUD_L(AUDIO_L),
		.AUD_R(AUDIO_R),
	 	.PS2_CLK1(PS2_CLKA),
		.PS2_CLK2(PS2_CLKB),
		.PS2_DATA1(PS2_DATA),
		.PS2_DATA2(PS2_DATB),
		.RS232_HOST_RXD(),
		.RS232_HOST_TXD(),
		.RS232_HOST_RST(),
		.GPIO(),
		.I2C_SCL(),
		.I2C_SDA(),
		.I2S_LRCLK(LRCLK),
		.I2S_SDIN(SDIN),
		.I2S_SCLK(SCLK),
		.I2S_MCLK(MCLK)
	);

	
endmodule

