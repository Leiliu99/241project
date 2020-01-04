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

	//UNCOMMENT THIS
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
//	
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
	
		
	always@(posedge clk) begin
		case (countNote)
			4'd0: begin
					delta = deltaA4;
				   initialx = 9'd4;
					end
			4'd1: begin
					delta = deltaAs4;
					initialx = 9'd23;
					end
			4'd2: begin
					delta = deltaB5;
					initialx = 9'd42;
					end
			4'd3: begin
					delta = deltaC5;
					initialx = 9'd61;
					end
			4'd4: begin
					delta = deltaCs5;
					initialx = 9'd80;
					end
			4'd5: begin
					delta = deltaD5;
					initialx = 9'd99;
					end
			4'd6: begin
					delta = deltaDs5;
					initialx = 9'd118;
					end
			4'd7: begin
					delta = deltaE5;
					initialx = 9'd137;
					end
			4'd8: begin
					delta = deltaF5;
					initialx = 9'd156;
					end
			4'd9: begin
					delta = deltaFs5;
					initialx = 9'd175;
					end
			4'd10: begin
					delta = deltaG5;
					initialx = 9'd194;
					end
			4'd11: begin
					delta = deltaGs5;
					initialx = 9'd213;
					end
			4'd12: begin
					delta = deltaA5;
					initialx = 9'd232;
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
					initialy = 8'd4;//full bar begin
					xpos <= initialx + graphCountx;
					ypos <= initialy + graphCounty;
					colour <= 3'd100;
				end
				else begin
					initialy = 8'd216 - delta[27:20];
					xpos <= initialx + graphCountx;
					ypos <= initialy + graphCounty;
					colour <= 3'd010;
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
					graphCountx <= 0;
					graphCounty <= 0;
					countNote <= 0;
				end
			end
				
			
			if(ld_graph)begin
				if(countNote < 4'd13)begin
					odone_plot_graph <= 0;
					
					//for each note increment
					if(graphCounty < (8'd219 - initialy) | (graphCounty == (8'd219 - initialy) & graphCountx < 9'd10))begin
						if(graphCountx < 9'd10)begin
							graphCountx <= graphCountx + 1;
						end
						else begin
							graphCountx <= 0;
							if(graphCounty < (8'd219 - initialy))begin
								graphCounty <= graphCounty + 1;
							end
						end
					end //for graphycount not equal to xxx;
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






//module datapath(
//	input clk,
//	input resetn,
//	input [3:0]data_in,
//	input ld_clear, ld_letter,
//	input ld_graph,
////	input ld_graphA4, ld_graphA4s, ld_graphB5, ld_graphC5, ld_graphC5s, ld_graphD5, ld_graphD5s, ld_graphE5, ld_graphF5, ld_graphF5s, ld_graphG5, ld_graphG5s, ld_graphA5,
//	input [46:0]deltaA4, deltaAs4, deltaB4, deltaC5, deltaCs5, deltaD5, deltaDs5, deltaE5, deltaF5, deltaFs5, deltaG5, deltaGs5, deltaA5,
//	output reg odone_clear,
//	output reg odone_plot_letter,
//	output reg odone_plot_graph,
////	output reg done_plot_graphA4,done_plot_graphA4s,done_plot_graphB5, done_plot_graphC5, done_plot_graphC5s, done_plot_graphD5, done_plot_graphD5s, done_plot_graphE5,
////	done_plot_graphF5, done_plot_graphF5s, done_plot_graphG5, done_plot_graphG5s, done_plot_graphA5,
//	output reg [8:0]xpos,
//	output reg [7:0]ypos,
//	output reg [2:0]colour,
//	output reg [3:0]countNote
//	);
//	
//	//reg [31:0] presound_magnitude;
//	//reg [31:0] value_sound;
//	reg [18:0] clearScreen;
//	reg [8:0] letterCountx;
//	reg [7:0] letterCounty;
//	reg [8:0] graphCountx;
//	reg [7:0] graphCounty;
//	
//
//	reg [46:0]delta;
//	wire [2:0] colourA4, colourAs4, colourB4, colourC5, colourCs5, colourD5, colourDs5, colourE5, colourF5, colourFs5, colourG5, colourGs5, colourA5, colourU;
//	wire mifA4, mifAs4, mifB4, mifC5, mifCs5, mifD5, mifDs5, mifE5, mifF5, mifFs5, mifG5, misGs5, mifA5, mifU;
//
//	letterA4 A4(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifA4));
//	
//	letterA4s A4s(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifAs4));
//	
//	letterB5 B4(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifB4));
//	
//	letterC5 C5(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifC5));
//	
//	letterC5s C5s(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifCs5));
//	
//	letterD5 D5(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifD5));
//	
//	letterD5s D5s(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifDs5));
//	
//	letterE5 E5(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifE5));
//	
//	letterF5 F5(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifF5));
//	
//	letterF5s F5s(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifFs5));
//	
//	letterG5 G5(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifG5));
//	
//	letterG5s G5s(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifGs5));
//	
//	letterA5 A5(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifA5));
//	
//	letterU U(
//	.address(letterCountx + (70*letterCounty)),
//	.clock(clk),
//	.data(0),
//	.wren(0),
//	.q(mifU));
//	
//	assign colourA4 = (mifA4 == 0) ? 3'b000 : 3'b111;
//	assign colourAs4 = (mifAs4 == 0) ? 3'b000 : 3'b111;
//	assign colourB4 = (mifB4 == 0) ? 3'b000 : 3'b111;
//	assign colourC5 = (mifC5 == 0) ? 3'b000 : 3'b111;
//	assign colourCs5 = (mifCs5 == 0) ? 3'b000 : 3'b111;
//	assign colourD5 = (mifD5 == 0) ? 3'b000 : 3'b111;
//	assign colourDs5 = (mifDs5 == 0) ? 3'b000 : 3'b111;
//	assign colourE5 = (mifE5 == 0) ? 3'b000 : 3'b111;
//	assign colourF5 = (mifF5 == 0) ? 3'b000 : 3'b111;
//	assign colourFs5 = (mifFs5 == 0) ? 3'b000 : 3'b111;
//	assign colourG5 = (mifG5 == 0) ? 3'b000 : 3'b111;
//	assign colourGs5 = (mifGs5 == 0) ? 3'b000 : 3'b111;
//	assign colourA5 = (mifA5 == 0) ? 3'b000 : 3'b111;
//	assign colourU = (mifU == 0) ? 3'b000 : 3'b111;
//	
//	
//	parameter ratio = 27'd67108864;
//	reg [8:0] initialx;
//	reg [7:0] initialy;
//	
////	always@(*) begin: choose_note
////		case (countNote)
////			4'd0: begin
////					delta = deltaA4;
////				   initialx = 9'd4;
////					end
////			4'd1: begin
////					delta = deltaAs4;
////					initialx = 9'd23;
////					end
////			4'd2: begin
////					delta = deltaB4;
////					initialx = 9'd42;
////					end
////			4'd3: begin
////					delta = deltaC5;
////					initialx = 9'd61;
////					end
////			4'd4: begin
////					delta = deltaCs5;
////					initialx = 9'd80;
////					end
////			4'd5: begin
////					delta = deltaD5;
////					initialx = 9'd99;
////					end
////			4'd6: begin
////					delta = deltaDs5;
////					initialx = 9'd118;
////					end
////			4'd7: begin
////					delta = deltaE5;
////					initialx = 9'd137;
////					end
////			4'd8: begin
////					delta = deltaF5;
////					initialx = 9'd156;
////					end
////			4'd9: begin
////					delta = deltaFs5;
////					initialx = 9'd175;
////					end
////			4'd10: begin
////					delta = deltaG5;
////					initialx = 9'd194;
////					end
////			4'd11: begin
////					delta = deltaGs5;
////					initialx = 9'd213;
////					end
////			4'd12: begin
////					delta = deltaA5;
////					initialx = 9'd232;
////					end
////			//default: delta = ???;
////		endcase 
////	end
//		
//		
//	always@(posedge clk) begin
//		case (countNote)
//			4'd0: begin
//					delta <= deltaA4;
//				   initialx <= 9'd4;
//					end
//			4'd1: begin
//					delta <= deltaAs4;
//					initialx <= 9'd23;
//					end
//			4'd2: begin
//					delta <= deltaB4;
//					initialx <= 9'd42;
//					end
//			4'd3: begin
//					delta <= deltaC5;
//					initialx <= 9'd61;
//					end
//			4'd4: begin
//					delta <= deltaCs5;
//					initialx <= 9'd80;
//					end
//			4'd5: begin
//					delta <= deltaD5;
//					initialx <= 9'd99;
//					end
//			4'd6: begin
//					delta <= deltaDs5;
//					initialx <= 9'd118;
//					end
//			4'd7: begin
//					delta <= deltaE5;
//					initialx <= 9'd137;
//					end
//			4'd8: begin
//					delta <= deltaF5;
//					initialx <= 9'd156;
//					end
//			4'd9: begin
//					delta <= deltaFs5;
//					initialx <= 9'd175;
//					end
//			4'd10: begin
//					delta <= deltaG5;
//					initialx <= 9'd194;
//					end
//			4'd11: begin
//					delta <= deltaGs5;
//					initialx <= 9'd213;
//					end
//			4'd12: begin
//					delta <= deltaA5;
//					initialx <= 9'd232;
//					end
//			//default: delta = ???;
//		endcase 
//		
//	
//		if(!resetn) begin
//			if (ld_letter) begin
//			//initial pos of the letter
//				xpos <= 9'd245 + letterCountx;
//				ypos <= 8'd151 + letterCounty;
//				//colour from mif
//				if(data_in == 4'b0000)
//					colour <= colourA4;
//				if(data_in == 4'b0001)
//					colour <= colourAs4;
//				if(data_in == 4'b0010)
//					colour <= colourB4;
//				if(data_in == 4'b0011)
//					colour <= colourC5;
//				if(data_in == 4'b0100)
//					colour <= colourCs5;
//				if(data_in == 4'b0101)
//					colour <= colourD5;
//				if(data_in == 4'b0110)
//					colour <= colourDs5;
//				if(data_in == 4'b0111)
//					colour <= colourE5;
//				if(data_in == 4'b1000)
//					colour <= colourF5;
//				if(data_in == 4'b1001)
//					colour <= colourFs5;
//				if(data_in == 4'b1010)
//					colour <= colourG5;
//				if(data_in == 4'b1011)
//					colour <= colourGs5;
//				if(data_in == 4'b1100)
//					colour <= colourA5;	
//				if(data_in == 4'b1111)
//					colour <= colourU;
//			end
//			else if(ld_clear) begin
//				xpos <= clearScreen[16:8];
//				ypos <= clearScreen[7:0];
//				colour <= 3'b000;
//			end
//			else if(ld_graph) begin
//				if(delta[30:27] != 4'd0) begin
//					initialy <= 8'd4;//full bar begin
//					xpos <= initialx + graphCountx;
//					ypos <= initialy + graphCounty;
//					colour <= 3'd100;
//				end
//				else begin
//					initialy <= 8'd216 - delta[27:20];
//					xpos <= initialx + graphCountx;
//					ypos <= initialy + graphCounty;
//					colour <= 3'd111;
//				end//for else inside graph
//			end//for ld_graph
//			
//		end//for !reset
//	end//for pos edge
//	
//	
//	
//	
//	always@(posedge clk) begin 
//		if(resetn)begin
//			clearScreen <= 0;
//			graphCountx <= 0;
//			graphCounty <= 0;
//			letterCountx <= 0;
//			letterCounty <= 0;
//			countNote <= 0;
//		end //for resetn
//		
//		else begin
//			if(ld_clear) begin
//				if(clearScreen == 17'd82140) begin
//				//if(clearScreen == 17'd02140) begin
//					clearScreen <= 0;
//					odone_clear <= 1;
//				end
//				else begin
//					odone_clear <= 0;
//					clearScreen <= clearScreen + 1;	
//				end
//			end
//			
//			
//			if(ld_letter)begin				
//				if(letterCounty < 8'd60)begin
//					odone_plot_letter <= 0;
//					if(letterCountx < 9'd70)
//						letterCountx <= letterCountx + 1;
//					else begin
//						letterCountx <= 0;
//						letterCounty <= letterCounty + 1;
//					end
//				end
//				else begin
//					letterCounty <= 0;
//					letterCountx <= 0;
//					odone_plot_letter <= 1;
//				end
//			end
//				
//			
//			if(ld_graph)begin
//				
//				if(countNote < 4'd13)begin
//					odone_plot_graph <= 0;
//					//for each note increment
//					if(graphCounty < (8'd220 - initialy))begin
//						if(graphCountx < 9'd11)begin
//							graphCountx <= graphCountx + 1;
//						end
//						else begin
//							graphCountx <= 0;
//							if(graphCounty < (8'd220 - initialy))begin
//								graphCounty <= graphCounty + 1;
//							end
//						end
//					end //for graphycount not equal to xxx;
//					//else if(initialy + graphCounty == 8'd219)begin
//					
//					else begin
//						countNote <= countNote + 1;
//						graphCountx <= 0;
//						graphCounty <= 0;
//					end //for else in graphy count y
//				end//for countNote
//				
//				else begin
//					odone_plot_graph <= 1;
//					countNote <= 0;
//					graphCountx <= 0;
//					graphCounty <= 0;
//				end // for else incountNote
//			end // for ld graph
//		end // for else(not resetting it)
//	end//for pos edge
//endmodule		
//
////			
////				if(graphCountx == 15'd18020) begin
////					odone_plot_graph <= 1;
////					graphCount <= 0;
////				end
////				else begin
////					odone_plot_graph <= 0;
////					graphCount <= graphCount + 1;
////				end
//			