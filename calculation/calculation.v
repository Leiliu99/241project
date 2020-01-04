

//store magnitude in the memory?
//module storeMagnitude(resetn, clk, magnitude, success_store);
//	input resetn, clk;
//	input [31:0] magnitude;//store one magnitude per clk into the memory
//	output success_store;
//	reg [10:0] mag_address;
//	wire writeEn = 1'b1;
//	
//	always @ (posedge clk)
//		begin
//			if(resetn)begin
//				//clear all the memory here????
//			end
//			if(!resetn) begin
//			//still need to add this into library here(???)
//				ram324 u0(.address(mag_address), .clock(clk), .data(magnitude) ,.wren(writeEn) ,.q(???));
//				mag_address = mag_address + 1;		
//			end
//		end
//	if(address == 11'd2000)begin
//		assign success_store = 1'b1;
//	end
//endmodule

module calculation(resetn, clk, magnitude, Y_out);
	input resetn, clk;
	input signed [31:0] magnitude;//1 little y here
	
	output reg [597:0] Y_out;//13 nodes of Y all together
	wire signed [45:0] single_magnitudeA4;
	wire signed [45:0] single_magnitudeA4s;
	wire signed [45:0] single_magnitudeB5;
	wire signed [45:0] single_magnitudeC5;
	wire signed [45:0] single_magnitudeC5s;
	wire signed [45:0] single_magnitudeD5;
	wire signed [45:0] single_magnitudeD5s;
	wire signed [45:0] single_magnitudeE5;
	wire signed [45:0] single_magnitudeF5;
	wire signed [45:0] single_magnitudeF5s;
	wire signed [45:0] single_magnitudeG5;
	wire signed [45:0] single_magnitudeG5s;
	wire signed [45:0] single_magnitudeA5;

	wire signed [13:0] factor;// a constant cofactor here
	wire signed [7:0] coeffA4;
	wire signed [7:0] coeffA4s;
	wire signed [7:0] coeffB5;
	wire signed [7:0] coeffC5;
	wire signed [7:0] coeffC5s;
	wire signed [7:0] coeffD5;
	wire signed [7:0] coeffD5s;
	wire signed [7:0] coeffE5;
	wire signed [7:0] coeffF5;
	wire signed [7:0] coeffF5s;
	wire signed [7:0] coeffG5;
	wire signed [7:0] coeffG5s;
	wire signed [7:0] coeffA5;

	reg is_calculating;
	
	reg [7:0] address;
	reg signed [45:0] sumA4;
	reg signed [45:0] sumA4s;
	reg signed [45:0] sumB5;
	reg signed [45:0] sumC5;
	reg signed [45:0] sumC5s;
	reg signed [45:0] sumD5;
	reg signed [45:0] sumD5s;
	reg signed [45:0] sumE5;
	reg signed [45:0] sumF5;
	reg signed [45:0] sumF5s;
	reg signed [45:0] sumG5;
	reg signed [45:0] sumG5s;
	reg signed [45:0] sumA5;
	
	reg signed [31:0] pre_magnitude;
//	reg signed [31:0] pre_magnitudeA4s;
//	reg signed [31:0] pre_magnitudeB4;
//	reg signed [31:0] pre_magnitudeC5;
//	reg signed [31:0] pre_magnitudeC5s;
//	reg signed [31:0] pre_magnitudeD5;
//	reg signed [31:0] pre_magnitudeD5s;
//	reg signed [31:0] pre_magnitudeE5;
//	reg signed [31:0] pre_magnitudeF5;
//	reg signed [31:0] pre_magnitudeF5s;
//	reg signed [31:0] pre_magnitudeG5;
//	reg signed [31:0] pre_magnitudeG5s;
//	reg signed [31:0] pre_magnitudeA5;
	
	reg [5567:0] register_magnitude;
//	reg [5567:0] register_magnitudeA4s;
//	reg [5567:0] register_magnitudeB5;
//	reg [5567:0] register_magnitudeC5;
//	reg [5567:0] register_magnitudeC5s;
//	reg [5567:0] register_magnitudeD5;
//	reg [5567:0] register_magnitudeD5s;
//	reg [5567:0] register_magnitudeE5;
//	reg [5567:0] register_magnitudeF5;
//	reg [5567:0] register_magnitudeF5s;
//	reg [5567:0] register_magnitudeG5;
//	reg [5567:0] register_magnitudeG5s;
//	reg [5567:0] register_magnitudeA5;
	
	reg [13:0] currentAdd;
	// declare constant here for calculation
	assign factor = 14'd4096;//factor for calculating small y
	
	//instanciate my out440 module to get coeff out here
	out440 n0(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffA4));
	
	out466 n1(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffA4s));
	
	out493 n2(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffB5));
	
	out523 n3(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffC5));
	
	out554 n4(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffC5s));
	
	out587 n5(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffD5));
	
	out622 n6(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffD5s));
	
	out659 n7(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffE5));
	
	out698 n8(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffF5));
	
	out739 n9(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffF5s));
	
	out783 n10(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffG5));
	
	out830 n11(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffG5s));
	
	out880 n12(
	.address(address),
	.clock(clk),
	.data(0),//data is not related here
	.wren(0),
	.q(coeffA5));
	
	multiplier m0(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffA4}),
	.result(single_magnitudeA4));
	
	multiplier m1(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffA4s}),
	.result(single_magnitudeA4s));
	
	multiplier m2(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffB5}),
	.result(single_magnitudeB5));
	
	multiplier m3(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffC5}),
	.result(single_magnitudeC5));
	
	multiplier m4(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffC5s}),
	.result(single_magnitudeC5s));
	
	multiplier m5(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffD5}),
	.result(single_magnitudeD5));
	
	multiplier m6(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffD5s}),
	.result(single_magnitudeD5s));
	
	multiplier m7(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffE5}),
	.result(single_magnitudeE5));
	
	multiplier m8(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffF5}),
	.result(single_magnitudeF5));
	
	multiplier m9(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffF5s}),
	.result(single_magnitudeF5s));
	
	multiplier m10(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffG5}),
	.result(single_magnitudeG5));
	
	multiplier m11(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffG5s}),
	.result(single_magnitudeG5s));
	
	multiplier m12(
	.dataa(register_magnitude[currentAdd -: 32]),
	.datab({1'b0, coeffA5}),
	.result(single_magnitudeA5));

	
	always @ (posedge clk) begin
		if(resetn) begin
			address <= 0;
			sumA4 <= 0;
			Y_out <= 0;
			is_calculating <= 0;
		end
		else begin
			if(pre_magnitude != magnitude && ~is_calculating) begin
				pre_magnitude <= magnitude;
//				pre_magnitudeA4s <= magnitude;
//				pre_magnitudeB5 <= magnitude;
//				pre_magnitudeC5 <= magnitude;
//				pre_magnitudeC5s <= magnitude;
//				pre_magnitudeD5 <= magnitude;
//				pre_magnitudeD5s <= magnitude;
//				pre_magnitudeE5 <= magnitude;
//				pre_magnitudeF5 <= magnitude;
//				pre_magnitudeF5s <= magnitude;
//				pre_magnitudeG5 <= magnitude;
//				pre_magnitudeG5s <= magnitude;
//				pre_magnitudeA5 <= magnitude; //????
				
				is_calculating <= 1'b1; //set the flag to indicate the calculation can start now
				address <= 0; //calculation should start from the first address when a new magnitude arrives
				sumA4 <= 0;
				sumA4s <= 0;
				sumB5 <= 0;
				sumC5 <= 0;
				sumC5s <= 0;
				sumD5 <= 0;
				sumD5s <= 0;
				sumE5 <= 0;
				sumF5 <= 0;
				sumF5s <= 0;
				sumG5 <= 0;
				sumG5s <= 0;
				sumA5 <= 0;
				
				register_magnitude[5567:32] <= register_magnitude[5535:0];
				register_magnitude[31:0] <= magnitude; //shift register to store the magnitude
				
//				register_magnitudeA4s[5567:32] <= register_magnitudeA4s[5535:0];
//				register_magnitudeA4s[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeB5[5567:32] <= register_magnitudeB5[5535:0];
//				register_magnitudeB5[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeC5[5567:32] <= register_magnitudeC5[5535:0];
//				register_magnitudeC5[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeC5s[5567:32] <= register_magnitudeC5s[5535:0];
//				register_magnitudeC5s[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeD5[5567:32] <= register_magnitudeD5[5535:0];
//				register_magnitudeD5[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeD5s[5567:32] <= register_magnitudeD5s[5535:0];
//				register_magnitudeD5s[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeE5[5567:32] <= register_magnitudeE5[5535:0];
//				register_magnitudeE5[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeF5[5567:32] <= register_magnitudeF5[5535:0];
//				register_magnitudeF5[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeF5s[5567:32] <= register_magnitudeF5s[5535:0];
//				register_magnitudeF5s[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeG5[5567:32] <= register_magnitudeG5[5535:0];
//				register_magnitudeG5[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeG5s[5567:32] <= register_magnitudeG5s[5535:0];
//				register_magnitudeG5s[31:0] <= magnitude; //shift register to store the magnitude
//				
//				register_magnitudeA5[5567:32] <= register_magnitudeA5[5535:0];
//				register_magnitudeA5[31:0] <= magnitude; //shift register to store the magnitude
		
				
			end
			else if(is_calculating && address == 8'd173) begin
					address <= 0;
					is_calculating <= 1'b0; //back to the first coefficient here
					currentAdd = 14'd5567 - {address, 5'd0};
					sumA4 <= sumA4 + single_magnitudeA4;
					sumA4s <= sumA4s + single_magnitudeA4s;
					sumB5 <= sumB5 + single_magnitudeB5;
					sumC5 <= sumC5 + single_magnitudeC5;
					sumC5s <= sumC5s + single_magnitudeC5s;
					sumD5 <= sumD5 + single_magnitudeD5;
					sumD5s <= sumD5s + single_magnitudeD5s;
					sumE5 <= sumE5 + single_magnitudeE5;
					sumF5 <= sumF5 + single_magnitudeF5;
					sumF5s <= sumF5s + single_magnitudeF5s;
					sumG5 <= sumG5 + single_magnitudeG5;
					sumG5s <= sumG5s + single_magnitudeG5s;
					sumA5 <= sumA5 + single_magnitudeA5;
					
					
			end
//			else if(~is_calculating && address == 8'd173) begin
//					address <= 0;
//					is_calculating <= 1'b0; //back to the first coefficient here
//					currentAdd = 14'd5567 - address * 14'd32;
//					sum <= sum + single_magnitude;
//			end
			else if(~is_calculating && address == 8'd0) begin
//				Y_out[45:0] <= sumA4 / factor; //adjust the y_out to be the correct by dividing the factor
				if(sumA4[45] == 1'b1) begin
					Y_out[45:0] <= {12'b111111111111, sumA4[45:12]};
				end
				else if (sumA4[45] != 1'b1) begin
					Y_out[45:0] <= {12'd0, sumA4[45:12]};
				end
				
				if(sumA4s[45] == 1'b1) begin
					Y_out[91:46] <= {12'b111111111111, sumA4s[45:12]};
				end
				else if (sumA4s[45] != 1'b1) begin
					Y_out[91:46] <= {12'd0, sumA4s[45:12]};
				end
				
				if(sumB5[45] == 1'b1) begin
					Y_out[137:92] <= {12'b111111111111, sumB5[45:12]};
				end
				else if (sumB5[45] != 1'b1) begin
					Y_out[137:92] <= {12'd0, sumB5[45:12]};
				end
				
				if(sumC5[45] == 1'b1) begin
					Y_out[183:138] <= {12'b111111111111, sumC5[45:12]};
				end
				else if (sumC5[45] != 1'b1) begin
					Y_out[183:138] <= {12'd0, sumC5[45:12]};
				end
				
				if(sumC5s[45] == 1'b1) begin
					Y_out[229:184] <= {12'b111111111111, sumC5s[45:12]};
				end
				else if (sumC5s[45] != 1'b1) begin
					Y_out[229:184] <= {12'd0, sumC5s[45:12]};
				end
				
				if(sumD5[45] == 1'b1) begin
					Y_out[275:230] <= {12'b111111111111, sumD5[45:12]};
				end
				else if (sumD5[45] != 1'b1) begin
					Y_out[275:230] <= {12'd0, sumD5[45:12]};
				end
				
				if(sumD5s[45] == 1'b1) begin
					Y_out[321:276] <= {12'b111111111111, sumD5s[45:12]};
				end
				else if (sumD5s[45] != 1'b1) begin
					Y_out[321:276] <= {12'd0, sumD5s[45:12]};
				end
				
				if(sumE5[45] == 1'b1) begin
					Y_out[367:322] <= {12'b111111111111, sumE5[45:12]};
				end
				else if (sumE5[45] != 1'b1) begin
					Y_out[367:322] <= {12'd0, sumE5[45:12]};
				end
				
				if(sumF5[45] == 1'b1) begin
					Y_out[413:368] <= {12'b111111111111, sumF5[45:12]};
				end
				else if (sumF5[45] != 1'b1) begin
					Y_out[413:368] <= {12'd0, sumF5[45:12]};
				end
				
				if(sumF5s[45] == 1'b1) begin
					Y_out[459:414] <= {12'b111111111111, sumF5s[45:12]};
				end
				else if (sumF5s[45] != 1'b1) begin
					Y_out[459:414] <= {12'd0, sumF5s[45:12]};
				end
				
				if(sumG5[45] == 1'b1) begin
					Y_out[505:460] <= {12'b111111111111, sumG5[45:12]};
				end
				else if (sumG5[45] != 1'b1) begin
					Y_out[505:460] <= {12'd0, sumG5[45:12]};
				end
				
				if(sumG5s[45] == 1'b1) begin
					Y_out[551:506] <= {12'b111111111111, sumG5s[45:12]};
				end
				else if (sumG5s[45] != 1'b1) begin
					Y_out[551:506] <= {12'd0, sumG5s[45:12]};
				end
				
				if(sumA5[45] == 1'b1) begin
					Y_out[597:552] <= {12'b111111111111, sumA5[45:12]};
				end
				else if (sumA5[45] != 1'b1) begin
					Y_out[597:552] <= {12'd0, sumA5[45:12]};
				end
				
				
				
			end
			else if(is_calculating) begin
				address <= address + 1;
				currentAdd = 14'd5567 - {address, 5'd0};
				//calculate the corresponding coefficients according to the address
				sumA4 <= sumA4 + single_magnitudeA4;
				sumA4s <= sumA4s + single_magnitudeA4s;
				sumB5 <= sumB5 + single_magnitudeB5;
				sumC5 <= sumC5 + single_magnitudeC5;
				sumC5s <= sumC5s + single_magnitudeC5s;
				sumD5 <= sumD5 + single_magnitudeD5;
				sumD5s <= sumD5s + single_magnitudeD5s;
				sumE5 <= sumE5 + single_magnitudeE5;
				sumF5 <= sumF5 + single_magnitudeF5;
				sumF5s <= sumF5s + single_magnitudeF5s;
				sumG5 <= sumG5 + single_magnitudeG5;
				sumG5s <= sumG5s + single_magnitudeG5s;
				sumA5 <= sumA5 + single_magnitudeA5;
			end
		end
	end
	
//	assign single_magnitude = Y_out[45:0];
	//register_magnitude[currentAdd -: 32] * coeff;
	
endmodule

