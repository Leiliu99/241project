//module VGA_display
//	(
//		CLOCK_50,						//	On Board 50 MHz
//		// Your inputs and outputs here
//		KEY,							// On Board button
//		SW,
//		LEDR,
//		// The ports below are for the VGA output.  Do not change.
//		VGA_CLK,   						//	VGA Clock
//		VGA_HS,							//	VGA H_SYNC
//		VGA_VS,							//	VGA V_SYNC
//		VGA_BLANK_N,						//	VGA BLANK
//		VGA_SYNC_N,						//	VGA SYNC
//		VGA_R,   						//	VGA Red[9:0]
//		VGA_G,	 						//	VGA Green[9:0]
//		VGA_B   						//	VGA Blue[9:0]
//	);
//
//	input			CLOCK_50;				//	50 MHz
//	input	[3:0]	KEY;	
//	input [9:0] SW;
//	output [9:0] LEDR;
//	// Declare your inputs and outputs here
//	// Do not change the following outputs
//	output			VGA_CLK;   				//	VGA Clock
//	output			VGA_HS;					//	VGA H_SYNC
//	output			VGA_VS;					//	VGA V_SYNC
//	output			VGA_BLANK_N;				//	VGA BLANK
//	output			VGA_SYNC_N;				//	VGA SYNC
//	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
//	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
//	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
//	
//	wire resetn;
//	assign resetn = ~KEY[0];
//	
//	// Create the colour, x, y and writeEn wires that are inputs to the controller.
//
//	wire [2:0] colour;
//	wire [8:0] xpos;
//	wire [7:0] ypos;
//
//	wire ld_clear, ld_letter, ld_graph;
//	wire done_clear, done_point5, done_plot_letter, done_plot_graph;
//	wire done_sixty;
//	
//	down_Counter_60 dcsix(.clk(CLOCK_50), .downEn(done_sixty));
//	down_Counter_point5 dc(.clk(CLOCK_50), .counterEn(done_sixty), .downEn(done_point5));
//	
//	datapath d0(.clk(CLOCK_50), .resetn(resetn), .data_in(SW[3:0]),.ld_clear(ld_clear), .ld_letter(ld_letter), .ld_graph(ld_graph), 
//	//{16'd0, 4'd2, 27'd134217728}
//	.odone_clear(done_clear) ,.odone_plot_letter(done_plot_letter) ,.odone_plot_graph(done_plot_graph), .xpos(xpos),	.ypos(ypos), .colour(colour), 
//	.deltaA4({21'd0, 26'd134217728}), .deltaAs4({20'd2, 27'd134217728}), .deltaB5({20'd0, 27'd11212}), .deltaC5({20'd0, 27'd311212}), 
//	.deltaCs5({20'd0, 27'd11212}), .deltaD5({20'd0, 27'd122}), .deltaDs5({20'd0, 27'd212}), .deltaE5({20'd0, 27'd31345}), .deltaF5({20'd0, 27'd123212}),
//	.deltaFs5({20'd0, 27'd111212}), .deltaG5({20'd0, 27'd2333}), .deltaGs5({20'd0, 27'd111212}), .deltaA5({20'd0, 27'd112}), .countNote(LEDR[9:6]));
//	
//
//	control c0(.clk(CLOCK_50), .resetn(resetn), .done_point5(done_point5), .done_clear(done_clear), .done_plot_letter(done_plot_letter), 
//	.done_plot_graph(done_plot_graph), .ld_clear(ld_clear),
//	.ld_letter(ld_letter), .ld_graph(ld_graph), .currentState(LEDR[3:0]));
//	
//	// Create an Instance of a VGA controller - there can be only one!
//	// Define the number of colours as well as the initial background
//	// image file (.MIF) for the controller.
//	vga_adapter VGA(
//			.resetn(KEY[0]),
//			.clock(CLOCK_50),
//			.colour(colour),
//			.x(xpos),
//			.y(ypos),
//			.plot(ld_letter | ld_graph | ld_clear),
//			/* Signals for the DAC to drive the monitor. */
//			.VGA_R(VGA_R),
//			.VGA_G(VGA_G),
//			.VGA_B(VGA_B),
//			.VGA_HS(VGA_HS),
//			.VGA_VS(VGA_VS),
//			.VGA_BLANK(VGA_BLANK_N),
//			.VGA_SYNC(VGA_SYNC_N),
//			.VGA_CLK(VGA_CLK));
////		defparam VGA.RESOLUTION = "160x120";
//		defparam VGA.MONOCHROME = "FALSE";
//		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
//		defparam VGA.BACKGROUND_IMAGE = "black.mif";
//			
//	// Put your code here. Your code should produce signals x,y,colour and writeEn
//	// for the VGA controller, in addition to any other functionality your design may require.
//
//	
//endmodule

module datapath(
	input clk,
	input resetn,
	input [3:0]data_in,
	input ld_clear, ld_letter,
	input ld_graph,
//	input ld_graphA4, ld_graphA4s, ld_graphB5, ld_graphC5, ld_graphC5s, ld_graphD5, ld_graphD5s, ld_graphE5, ld_graphF5, ld_graphF5s, ld_graphG5, ld_graphG5s, ld_graphA5,
	input [46:0]deltaA4, deltaAs4, deltaB5, deltaC5, deltaCs5, deltaD5, deltaDs5, deltaE5, deltaF5, deltaFs5, deltaG5, deltaGs5, deltaA5,
	output reg odone_clear,
	output reg odone_plot_letter,
	output reg odone_plot_graph,
//	output reg done_plot_graphA4,done_plot_graphA4s,done_plot_graphB5, done_plot_graphC5, done_plot_graphC5s, done_plot_graphD5, done_plot_graphD5s, done_plot_graphE5,
//	done_plot_graphF5, done_plot_graphF5s, done_plot_graphG5, done_plot_graphG5s, done_plot_graphA5,
	output reg [8:0]xpos,
	output reg [7:0]ypos,
	output reg [2:0]colour,
	output reg [3:0]countNote
	);
	
	//reg [31:0] presound_magnitude;
	//reg [31:0] value_sound;
	reg [18:0] clearScreen;
	reg [7:0] letterCountx;
	reg [6:0] letterCounty;
	reg [8:0] graphCountx;
	reg [7:0] graphCounty;
	

	reg [46:0]delta;
	wire [2:0] colourA4, colourAs4, colourB5, colourC5, colourCs5, colourD5, colourDs5, colourE5, colourF5, colourFs5, colourG5, colourGs5, colourA5, colourU;
	wire mifA4, mifAs4, mifB5, mifC5, mifCs5, mifD5, mifDs5, mifE5, mifF5, mifFs5, mifG5, misGs5, mifA5, mifU;

	letterA4 A4(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifA4));
	
	letterA4s A4s(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifAs4));
	
	letterB5 B5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifB5));
	
	letterC5 C5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifC5));
	
	letterC5s C5s(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifCs5));
	
	letterD5 D5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifD5));
	
	letterD5s D5s(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifDs5));
	
	letterE5 E5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifE5));
	
	letterF5 F5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifF5));
	
	letterF5s F5s(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifFs5));
	
	letterG5 G5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifG5));
	
	letterG5s G5s(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifGs5));
	
	letterA5 A5(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifA5));
	
	letterU U(
	.address(letterCountx + (70*letterCounty)),
	.clock(clk),
	.data(0),
	.wren(0),
	.q(mifU));
	
	assign colourA4 = (mifA4 == 0) ? 3'b000 : 3'b111;
	assign colourAs4 = (mifAs4 == 0) ? 3'b000 : 3'b111;
	assign colourB5 = (mifB5 == 0) ? 3'b000 : 3'b111;
	assign colourC5 = (mifC5 == 0) ? 3'b000 : 3'b111;
	assign colourCs5 = (mifCs5 == 0) ? 3'b000 : 3'b111;
	assign colourD5 = (mifD5 == 0) ? 3'b000 : 3'b111;
	assign colourDs5 = (mifDs5 == 0) ? 3'b000 : 3'b111;
	assign colourE5 = (mifE5 == 0) ? 3'b000 : 3'b111;
	assign colourF5 = (mifF5 == 0) ? 3'b000 : 3'b111;
	assign colourFs5 = (mifFs5 == 0) ? 3'b000 : 3'b111;
	assign colourG5 = (mifG5 == 0) ? 3'b000 : 3'b111;
	assign colourGs5 = (mifGs5 == 0) ? 3'b000 : 3'b111;
	assign colourA5 = (mifA5 == 0) ? 3'b000 : 3'b111;
	assign colourU = (mifU == 0) ? 3'b000 : 3'b111;
	
	
	parameter ratio = 27'd67108864;
	reg [8:0] initialx;
	reg [7:0] initialy;
	
//	always@(*) begin: choose_note
//		case (countNote)
//			4'd0: begin
//					delta = deltaA4;
//				   initialx = 9'd4;
//					end
//			4'd1: begin
//					delta = deltaAs4;
//					initialx = 9'd23;
//					end
//			4'd2: begin
//					delta = deltaB5;
//					initialx = 9'd42;
//					end
//			4'd3: begin
//					delta = deltaC5;
//					initialx = 9'd61;
//					end
//			4'd4: begin
//					delta = deltaCs5;
//					initialx = 9'd80;
//					end
//			4'd5: begin
//					delta = deltaD5;
//					initialx = 9'd99;
//					end
//			4'd6: begin
//					delta = deltaDs5;
//					initialx = 9'd118;
//					end
//			4'd7: begin
//					delta = deltaE5;
//					initialx = 9'd137;
//					end
//			4'd8: begin
//					delta = deltaF5;
//					initialx = 9'd156;
//					end
//			4'd9: begin
//					delta = deltaFs5;
//					initialx = 9'd175;
//					end
//			4'd10: begin
//					delta = deltaG5;
//					initialx = 9'd194;
//					end
//			4'd11: begin
//					delta = deltaGs5;
//					initialx = 9'd213;
//					end
//			4'd12: begin
//					delta = deltaA5;
//					initialx = 9'd232;
//					end
//			//default: delta = ???;
//		endcase 
//	end
		
		
	always@(posedge clk) begin
		case (countNote)
			4'd0: begin
					delta <= deltaA4;
				   initialx <= 9'd4;
					end
			4'd1: begin
					delta <= deltaAs4;
					initialx <= 9'd23;
					end
			4'd2: begin
					delta <= deltaB5;
					initialx <= 9'd42;
					end
			4'd3: begin
					delta <= deltaC5;
					initialx <= 9'd61;
					end
			4'd4: begin
					delta <= deltaCs5;
					initialx <= 9'd80;
					end
			4'd5: begin
					delta <= deltaD5;
					initialx <= 9'd99;
					end
			4'd6: begin
					delta <= deltaDs5;
					initialx <= 9'd118;
					end
			4'd7: begin
					delta <= deltaE5;
					initialx <= 9'd137;
					end
			4'd8: begin
					delta <= deltaF5;
					initialx <= 9'd156;
					end
			4'd9: begin
					delta <= deltaFs5;
					initialx <= 9'd175;
					end
			4'd10: begin
					delta <= deltaG5;
					initialx <= 9'd194;
					end
			4'd11: begin
					delta <= deltaGs5;
					initialx <= 9'd213;
					end
			4'd12: begin
					delta <= deltaA5;
					initialx <= 9'd232;
					end
			//default: delta = ???;
		endcase 
		
	
		if(!resetn) begin
			if (ld_letter) begin
			//initial pos of the letter
				xpos <= 9'd245 + letterCountx;
				ypos <= 8'd151 + letterCounty;
				//colour from mif
				if(data_in == 4'b0000)
					colour <= colourA4;
				if(data_in == 4'b0001)
					colour <= colourAs4;
				if(data_in == 4'b0010)
					colour <= colourB5;
				if(data_in == 4'b0011)
					colour <= colourC5;
				if(data_in == 4'b0100)
					colour <= colourCs5;
				if(data_in == 4'b0101)
					colour <= colourD5;
				if(data_in == 4'b0110)
					colour <= colourDs5;
				if(data_in == 4'b0111)
					colour <= colourE5;
				if(data_in == 4'b1000)
					colour <= colourF5;
				if(data_in == 4'b1001)
					colour <= colourFs5;
				if(data_in == 4'b1010)
					colour <= colourG5;
				if(data_in == 4'b1011)
					colour <= colourGs5;
				if(data_in == 4'b1100)
					colour <= colourA5;	
				if(data_in == 4'b1111)
					colour <= colourU;
			end
			else if(ld_clear) begin
				xpos <= clearScreen[16:8];
				ypos <= clearScreen[7:0];
				colour <= 3'b000;
			end
			else if(ld_graph) begin
				if(delta[30:27] != 4'd0) begin
					initialy <= 8'd4;//full bar begin
					xpos <= initialx + graphCountx;
					ypos <= initialy + graphCounty;
					colour <= 3'd100;
				end
				else begin
					initialy <= 8'd216 - delta[27:20];
					xpos <= initialx + graphCountx;
					ypos <= initialy + graphCounty;
					colour <= 3'd111;
				end//for else inside graph
			end//for graph
		end//for !reset
	end//for pos edge
	
	always@(posedge clk) begin 
		if(resetn)begin
			clearScreen <= 0;
			graphCountx <= 0;
			graphCounty <= 0;
			letterCountx <= 0;
			letterCounty <= 0;
			countNote <= 0;
		end //for resetn
		else begin
			if(ld_clear) begin
				if(clearScreen == 17'd82140) begin
				//if(clearScreen == 17'd02140) begin
					clearScreen <= 0;
					odone_clear <= 1;
				end
				else begin
					odone_clear <= 0;
					clearScreen <= clearScreen + 1;	
				end
			end
			
			
			if(ld_letter)begin				
				if(letterCounty != 8'd59)begin
					odone_plot_letter <= 0;
					if(letterCountx != 9'd69)
						letterCountx <= letterCountx + 1;
					else begin
						letterCountx <= 0;
						letterCounty <= letterCounty + 1;
					end
				end
				else begin
					letterCounty <= 0;
					letterCountx <= 0;
					odone_plot_letter <= 1;
				end
			end
				
			
			if(ld_graph)begin
				if(countNote != 4'd12)begin
					odone_plot_graph <= 0;
					
					//for each note increment
					if(graphCounty != (8'd219 - initialy))begin
						if(graphCountx != 9'd10)begin
							graphCountx <= graphCountx + 1;
						end
						else begin
							graphCountx <= 0;
							if(graphCounty != (8'd219 - initialy))begin
								graphCounty <= graphCounty + 1;
							end
						end
					end //for graphycount not equal to xxx;
					//else if(initialy + graphCounty == 8'd219)begin
					else begin
						countNote <= countNote + 1;
						graphCountx <= 0;
						graphCounty <= 0;
					end //for else in graphy count y
					
				end//for countNote
				else begin
					odone_plot_graph <= 1;
					countNote <= 0;
					graphCountx <= 0;
					graphCounty <= 0;
				end // for else incountNote
			end // for ld graph
				
		end // for else
	end//for pos edge
endmodule		

//			
//				if(graphCountx == 15'd18020) begin
//					odone_plot_graph <= 1;
//					graphCount <= 0;
//				end
//				else begin
//					odone_plot_graph <= 0;
//					graphCount <= graphCount + 1;
//				end
			
	
	


module control(
	input clk,
	input resetn,

	input done_point5, done_clear, done_plot_letter, 
	input done_plot_graph,
//	input done_plot_graphA4,done_plot_graphA4s,done_plot_graphB5, done_plot_graphC5, done_plot_graphC5s, done_plot_graphD5, done_plot_graphD5s, done_plot_graphE5,
//	done_plot_graphF5, done_plot_graphF5s, done_plot_graphG5, done_plot_graphG5s, done_plot_graphA5,
	output reg ld_clear,
	output reg ld_letter,
	output reg ld_graph,
//	output reg ld_graphA4, ld_graphA4s, ld_graphB5, ld_graphC5, ld_graphC5s, ld_graphD5, ld_graphD5s, ld_graphE5, ld_graphF5, ld_graphF5s, ld_graphG5, ld_graphG5s, ld_graphA5,
	output [3:0]currentState
	);
	
	assign currentState = current_state;
	reg [3:0]current_state, next_state; 

	localparam s_pre_plot = 4'd0,
	           s_clear = 4'd1,
				  s_plot_letter = 4'd2,
				  s_plot_graph = 4'd3;
//				  s_plot_graphA4 = 4'd3,
//				  s_plot_graphA4s = 4'd4,
//				  s_plot_graphB5 = 4'd5,
//				  s_plot_graphC5 = 4'd6,
//				  s_plot_graphC5s = 4'd7,
//				  s_plot_graphD5 = 4'd8,
//				  s_plot_graphD5s = 4'd9,
//				  s_plot_graphE5 = 4'd10,
//				  s_plot_graphF5 = 4'd11,
//				  s_plot_graphF5s = 4'd12,
//				  s_plot_graphG5 = 4'd13,
//				  s_plot_graphG5s = 4'd14,
//				  s_plot_graphA5 = 4'd15;
								  
				  
	 always @(*) begin: state_table
			case (current_state)
				s_pre_plot: next_state = done_point5 ? s_clear : s_pre_plot;
				s_clear: next_state = done_clear ? s_plot_letter: s_clear;
				s_plot_letter: next_state = done_plot_letter ? s_plot_graph : s_plot_letter;
				s_plot_graph: next_state = done_plot_graph ? s_pre_plot : s_plot_graph;
//				s_plot_graphA4: next_state = done_plot_graphA4 ?  s_plot_graphA4s: s_plot_graphA4;
//				s_plot_graphA4s: next_state = done_plot_graphA4s ? s_plot_graphB5: s_plot_graphA4s;
//				s_plot_graphB5: next_state = done_plot_graphB5 ? s_plot_graphC5: s_plot_graphB5;
//				s_plot_graphC5: next_state = done_plot_graphC5 ? s_plot_graphC5s: s_plot_graphC5;
//				s_plot_graphC5s: next_state = done_plot_graphC5s ? s_plot_graphD5: s_plot_graphC5s;
//				s_plot_graphD5: next_state = done_plot_graphD5 ? s_plot_graphD5s: s_plot_graphD5;
//				s_plot_graphD5s: next_state = done_plot_graphD5s ? s_plot_graphE5: s_plot_graphD5s;
//				s_plot_graphE5: next_state = done_plot_graphE5 ? s_plot_graphF5: s_plot_graphE5;
//				s_plot_graphF5: next_state = done_plot_graphF5 ? s_plot_graphF5s: s_plot_graphF5;
//				s_plot_graphF5s: next_state = done_plot_graphF5s ? s_plot_graphG5: s_plot_graphF5s;
//				s_plot_graphG5: next_state = done_plot_graphG5 ? s_plot_graphG5s: s_plot_graphG5;
//				s_plot_graphG5s: next_state = done_plot_graphG5s ? s_plot_graphA5: s_plot_graphG5s;
//				s_plot_graphA5: next_state = done_plot_graphA5 ?  s_pre_plot : s_plot_graphA5;
				default: next_state = s_pre_plot;
			endcase 
		end
		
		
	 always@(*) begin: enable_signals
		ld_clear = 1'b0;
		ld_letter = 1'b0;
		ld_graph = 1'b0;
//		ld_graphA4 = 1'b0;
//		ld_graphA4s = 1'b0;
//		ld_graphB5 = 1'b0;
//		ld_graphC5 = 1'b0;
//		ld_graphC5s = 1'b0;
//		ld_graphD5 = 1'b0;
//		ld_graphD5s = 1'b0;
//		ld_graphE5 = 1'b0;
//		ld_graphF5 = 1'b0;
//		ld_graphF5s = 1'b0;
//		ld_graphG5 = 1'b0;
//		ld_graphG5s = 1'b0;
//		ld_graphA5 = 1'b0;
		
		case(current_state)
			s_clear: begin
				ld_clear = 1'b1;
				end
			s_plot_letter: begin
				ld_letter = 1'b1;
				end
			s_plot_graph: begin
				ld_graph = 1'b1;
				end
//			s_plot_graphA4: begin
//				ld_graphA4 = 1'b1;
//				end
//			s_plot_graphA4s: begin
//				ld_graphA4s = 1'b1;
//				end
//			s_plot_graphB5: begin
//				ld_graphB5 = 1'b1;
//				end
//			s_plot_graphC5: begin
//				ld_graphC5 = 1'b1;
//				end
//			s_plot_graphC5s: begin
//				ld_graphC5s = 1'b1;
//				end
//			s_plot_graphD5: begin
//				ld_graphD5 = 1'b1;
//				end
//			s_plot_graphD5s: begin
//				ld_graphD5s = 1'b1;
//				end
//			s_plot_graphE5: begin
//				ld_graphE5 = 1'b1;
//				end
//			s_plot_graphF5: begin
//				ld_graphF5 = 1'b1;
//				end
//			s_plot_graphF5s: begin
//				ld_graphF5s = 1'b1;
//				end
//			s_plot_graphG5: begin
//				ld_graphG5 = 1'b1;
//				end
//			s_plot_graphG5s: begin
//				ld_graphG5s = 1'b1;
//				end
//			s_plot_graphA5: begin
//				ld_graphA5 = 1'b1;
//				end	
		endcase
	 end
	 
	 always@(posedge clk)
	 begin: state_FFs
			if(resetn)
				current_state <= s_pre_plot;
	      else 
				current_state <= next_state;
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
