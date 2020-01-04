
module audiotuner (
	// Inputs
	CLOCK_50,
	KEY,
	SW,
	LEDR,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs for audio
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	
	//for VGA output
	VGA_CLK,   						//	VGA Clock
	VGA_HS,							//	VGA H_SYNC
	VGA_VS,							//	VGA V_SYNC
	VGA_BLANK_N,						//	VGA BLANK
	VGA_SYNC_N,						//	VGA SYNC
	VGA_R,   						//	VGA Red[9:0]
	VGA_G,	 						//	VGA Green[9:0]
	VGA_B   						//	VGA Blue[9:0]

);

	/*****************************************************************************
	 *                           Parameter Declarations                          *
	 *****************************************************************************/


	/*****************************************************************************
	 *                             Port Declarations                             *
	 *****************************************************************************/
	// Inputs
	input				CLOCK_50;
	input		[3:0]	KEY;
	input		[3:0]	SW;

	input				AUD_ADCDAT;

	// Bidirectionals
	inout				AUD_BCLK;
	inout				AUD_ADCLRCK;
	inout				AUD_DACLRCK;

	inout				FPGA_I2C_SDAT;

	// Outputs
	output				AUD_XCK;
	output				AUD_DACDAT;

	output				FPGA_I2C_SCLK;
	output       [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	output       [9:0]LEDR;
	
	//for VGA
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	//output	[3:0]	HEX4_bin;
	//output	[3:0]	HEX3_bin;


	/*****************************************************************************
	 *                 Internal Wires and Registers Declarations                 *
	 *****************************************************************************/
	// Internal Wires
	wire				audio_in_available;
	wire		[31:0]	left_channel_audio_in;
	wire		[31:0]	right_channel_audio_in;
	wire				read_audio_in;

	wire				audio_out_allowed;
	wire		[31:0]	left_channel_audio_out;
	wire		[31:0]	right_channel_audio_out;
	wire				write_audio_out;



	// Internal Registers

	reg [18:0] delay_cnt;
	wire [18:0] delay;

	reg snd;

	// State Machine Registers

	/*****************************************************************************
	 *                         Finite State Machine(s)                           *
	 *****************************************************************************/


	/*****************************************************************************
	 *                             Sequential Logic                              *
	 
	 *****************************************************************************/

	always @(posedge CLOCK_50)
		if(delay_cnt == delay) begin
			delay_cnt <= 0;
			snd <= !snd;
		end else delay_cnt <= delay_cnt + 1;

	/*****************************************************************************
	 *                            Combinational Logic                            *
	 *****************************************************************************/

	assign delay = {SW[3:0], 15'd3000};

	wire [31:0] sound = (SW == 0) ? 0 : snd ? 32'd10000000 : -32'd10000000;


	assign read_audio_in			= audio_in_available & audio_out_allowed;

	assign left_channel_audio_out	= left_channel_audio_in+sound;
	assign right_channel_audio_out	= right_channel_audio_in+sound;
	assign write_audio_out			= audio_in_available & audio_out_allowed;
	//HEX0-2 SHOW LEFT CHANNEL
	//HEX3-5 SHOW RIGHT CHANNEL
	wire      Enable;//sampling enable 
	wire      [14:0] RDiv;
	wire      [31:0] divOut_left;
	wire      [597:0] Y_out;
	//wire      [31:0] divOut_right;
	assign    Enable = (RDiv == 15'd0) ? 1:0;
	RateDivider rd0(
				.Clock(CLOCK_50),
				.q(RDiv)
				);//rate divider to generate 2000 frequency
	//using added sound one 
	divOut do0(.inSound(left_channel_audio_out),.clk(Enable), .outSound(divOut_left)); //not inversed the magnitude here
	
	
	//need to revised when calculate the actual magnitude of sound 
	//divOut do1(.inSound(right_channel_audio_out),.clk(Enable), .outSound(divOut_right));

	//reg [31:0]max;
	//always @(*) begin
	////	max = 32'd0;
	//	if(divOut_left > max) begin
	//		max = divOut_left;
	//	end
	//
	//end 
	//	

	hex_decoder H0(
			  .hex_digit(deltaA4[14:11]), 
			  .segments(HEX0)
			  );
			  
			  
	hex_decoder H1(
			  .hex_digit(deltaA4[18:15]), 
			  .segments(HEX1)
			  );
			 
	hex_decoder H2(
			  .hex_digit(deltaA4[22:19]), 
			  .segments(HEX2)
			  );

	hex_decoder H3(
			  .hex_digit(deltaA4[26:23]), 
			  .segments(HEX3)
			  );
	//assign HEX3_bin = divOut_left[23:20];		  
	hex_decoder H4(
			  .hex_digit(deltaA4[30:27]), 
			  .segments(HEX4)
			  );
	//assign HEX4_bin = divOut_left[27:24];

	hex_decoder H5(
			  .hex_digit(deltaA4[34:31]), 
			  .segments(HEX5)
			  );
	/*****************************************************************************
	 *                              Internal Modules                             *
	 *****************************************************************************/

	Audio_Controller Audio_Controller (
		// Inputs
		.CLOCK_50						(CLOCK_50),
		.reset						(~KEY[2]),

		.clear_audio_in_memory		(),
		.read_audio_in				(read_audio_in),
		
		.clear_audio_out_memory		(),
		.left_channel_audio_out		(left_channel_audio_out),
		.right_channel_audio_out	(right_channel_audio_out),
		.write_audio_out			(write_audio_out),

		.AUD_ADCDAT					(AUD_ADCDAT),

		// Bidirectionals
		.AUD_BCLK					(AUD_BCLK),
		.AUD_ADCLRCK				(AUD_ADCLRCK),
		.AUD_DACLRCK				(AUD_DACLRCK),


		// Outputs
		.audio_in_available			(audio_in_available),
		.left_channel_audio_in		(left_channel_audio_in),
		.right_channel_audio_in		(right_channel_audio_in),

		.audio_out_allowed			(audio_out_allowed),

		.AUD_XCK					(AUD_XCK),
		.AUD_DACDAT					(AUD_DACDAT)

	);

	avconf #(.USE_MIC_INPUT(1)) avc (
		.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
		.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
		.CLOCK_50					(CLOCK_50),
		.reset						(~KEY[0])
	);
	
	//wire [45:0] sum;
	//wire [45:0] single_magnitude;
	//wire [46:0] outputDelta;
	wire [3:0] finalResult;
	wire [46:0]deltaA4, deltaAs4, deltaB4, deltaC5, deltaCs5, deltaD5, deltaDs5, deltaE5, deltaF5, deltaFs5, deltaG5, deltaGs5, deltaA5;
	calculation c0(.resetn(~KEY[0]), .clk(CLOCK_50), .magnitude(divOut_left), .Y_out(Y_out));
	compareWithNote compare(.clock(CLOCK_50), .weightedData(Y_out), .resetn(~KEY[0]),.finalResult(finalResult), .deltaA4(deltaA4), .deltaAs4(deltaAs4), .deltaB4(deltaB4), .deltaC5(deltaC5),
	.deltaCs5(deltaCs5), .deltaD5(deltaD5), .deltaDs5(deltaDs5), .deltaE5(deltaE5), .deltaF5(deltaF5), .deltaFs5(deltaFs5), .deltaG5(deltaG5), .deltaGs5(deltaGs5), 
	.deltaA5(deltaA5));
	
	assign LEDR[3:0] = finalResult;
	
	
	//VGA part
	
	
	wire resetn;
	assign resetn = ~KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [8:0] xpos;
	wire [7:0] ypos;

	wire ld_clear, ld_letter, ld_graph;
	wire done_clear, done_point5, done_plot_letter, done_plot_graph;
	wire done_sixty;
	wire [3:0] cs;
	
	assign LEDR[5] = ld_letter;
	assign LEDR[4] = ld_clear;
	
	down_Counter_60 dcsix(.clk(CLOCK_50), .downEn(done_sixty));
	down_Counter_point5 dc(.clk(CLOCK_50), .counterEn(done_sixty), .downEn(done_point5));
	
	datapath d0(.clk(CLOCK_50), .resetn(resetn), .data_in(finalResult),.ld_clear(ld_clear), .ld_letter(ld_letter), .ld_graph(ld_graph), 
	.odone_clear(done_clear) ,.odone_plot_letter(done_plot_letter) ,.odone_plot_graph(done_plot_graph), .xpos(xpos),	.ypos(ypos), .colour(colour), 
	.deltaA4(deltaA4), .deltaAs4(deltaAs4), .deltaB5(deltaB4), .deltaC5(deltaC5), 
	.deltaCs5(deltaCs5), .deltaD5(deltaD5), .deltaDs5(deltaDs5), .deltaE5(deltaE5), .deltaF5(deltaF5),
	.deltaFs5(deltaFs5), .deltaG5(deltaG5), .deltaGs5(deltaGs5), .deltaA5(deltaA5), .countNote(LEDR[9:6]));
	

	control control0(.clk(CLOCK_50), .resetn(resetn), .done_point5(done_point5), .done_clear(done_clear), .done_plot_letter(done_plot_letter), 
	.done_plot_graph(done_plot_graph), .ld_clear(ld_clear),
	.ld_letter(ld_letter), .ld_graph(ld_graph), .currentState(cs));
	
	
	wire EnPlot;
	assign EnPlot = ld_letter | (ld_graph && ypos <= 8'd219) | (ld_clear && ypos <= 8'd219);
	
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(xpos),
			.y(ypos),
			.plot(EnPlot),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
//		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "outbggg.mif";
	
	
	//assign LEDR[9:0] = Y_out[9:0];
	
	//assign LEDR[9:0] =  sum[39:30];
endmodule







module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule



module RateDivider (Clock,q);//2000 HZ here
	input Clock;
	output reg[14:0] q;
	always @ (posedge Clock)
	begin
		if(q == 15'd0)//when it is the min value
				q <= 15'd24999;
		else
				q <= q - 1; 
	end
endmodule

//
//module RateDivider (Clock,q);//test 5 HZ here
//	input Clock;
//	output reg[26:0] q;
//	always @ (posedge Clock)
//	begin
//		if(q == 27'd0)//when it is the min value
//				q <= 27'd9999999;
//		else
//				q <= q - 1; 
//	end
//endmodule



module divOut(inSound, clk, outSound);
		input [31:0] inSound;
		input clk;
		output reg[31:0] outSound;
		
		always @(posedge clk)begin
			
//			if(inSound[31] == 1'b1)begin 
//				outSound <= ~inSound;
//			end 
//			else begin 
				outSound <= inSound;
			end
endmodule 


module down_Counter_point5(clk, counterEn, downEn);
	input clk;
	input counterEn;
	output downEn;
	reg [4:0]Q;
	always@(posedge clk)
		begin
			if (counterEn) begin
				if (downEn) 
					Q <= 5'd29;//count down to 2 HZ
				else 
					Q <= Q - 1;
			end
		end
	assign downEn = (Q == 5'd0) ? 1 : 0;
endmodule



module down_Counter_60(clk, downEn);
	input clk;
	output downEn;
	reg [19:0]Q;
	always@(posedge clk)
		begin
			if (downEn) 
				Q <= 20'd833333;//count down to 60 HZ
			else 
				Q <= Q - 1;
		end
	assign downEn = (Q == 20'd0) ? 1 : 0;
endmodule




	
	
	
	
	
	
	
	
	
	
	
	
	
	
