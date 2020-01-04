//module FinalProject(SW, KEY, LEDR);
	//input [3:0] KEY;
	//input [9:0] SW;
	////input CLOCK_50;
	//output [9:0]LEDR;
	//compareWithNote comp(.clock(~KEY[0]), .weightedData({SW[9:0], 587'd0}), .finalResult(LEDR[3:0]));
	//wire [45:0]outputofmaxmin;
	//wire [45:0] deltaoutput;
	//findMaxMinIn20 f1(.clock(CLOCK_50), .sampleOf20({874'd0, 46'd1}), .delta(LEDR[3:0]));
	//findNote fn(46'd0,46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd0, 46'd128, LEDR[3:0]);
//endmodule


//module for store_x and store_y

//for getting delta for the set of 100 max and mins

//enable is filtered_y
module compareWithNote(clock, weightedData, resetn, finalResult, deltaA4, deltaAs4, deltaB4, deltaC5, deltaCs5, deltaD5, deltaDs5, deltaE5, deltaF5, deltaFs5, deltaG5, deltaGs5, deltaA5);
    input clock, resetn;//clearMaxMin;
    //2000 element array of y, each number is 11 bit wide
    input [597:0]weightedData;
    //output [46:0]outputDelta;
    reg enable;
    reg [919:0] A4arr, As4arr, B4arr, C5arr, Cs5arr, D5arr, Ds5arr, E5arr, F5arr, Fs5arr, G5arr, Gs5arr, A5arr;
    reg [11959:0] allData;
    //assign outputDelta = deltaA4;
    output [46:0]deltaA4, deltaAs4, deltaB4, deltaC5, deltaCs5, deltaD5, deltaDs5, deltaE5, deltaF5, deltaFs5, deltaG5, deltaGs5, deltaA5;
    
    output [3:0]finalResult;
	 
	 reg isUpdateArr;
	 
    
    always @ (posedge clock)
        begin
            if(allData[597:0] != weightedData[597:0]) begin
               allData[11959:598] <= allData[11361:0];
               allData[597:0] <= weightedData[597:0];  
					if(!isUpdateArr) begin
						isUpdateArr <= 1;
					end
				end
				else 
					if(isUpdateArr) begin
						
						A4arr <= {allData[11407:11362], allData[10809:10764], allData[10211:10166], allData[9613:9568], allData[9015:8970], allData[8417:8372], allData[7819:7774], allData[7221:7176], allData[6623:6578], allData[6025:5980], allData[5427:5382], allData[4829:4784], allData[4231:4186], allData[3633:3588], allData[3035:2990], allData[2437:2392], allData[1839:1794], allData[1241:1196], allData[643:598], allData[45:0]};
						As4arr <= {allData[11453:11408], allData[10855:10810], allData[10257:10212], allData[9659:9614], allData[9061:9016], allData[8463:8418], allData[7865:7820], allData[7267:7222], allData[6669:6624], allData[6071:6026], allData[5473:5428], allData[4875:4830], allData[4277:4232], allData[3679:3634], allData[3081:3036], allData[2483:2438], allData[1885:1840], allData[1287:1242], allData[689:644], allData[91:46]};
						B4arr <= {allData[11499:11454], allData[10901:10856], allData[10303:10258], allData[9705:9660], allData[9107:9062], allData[8509:8464], allData[7911:7866], allData[7313:7268], allData[6715:6670], allData[6117:6072], allData[5519:5474], allData[4921:4876], allData[4323:4278], allData[3725:3680], allData[3127:3082], allData[2529:2484], allData[1931:1886], allData[1333:1288], allData[735:690], allData[137:92]};
						C5arr <= {allData[11545:11500], allData[10947:10902], allData[10349:10304], allData[9751:9706], allData[9153:9108], allData[8555:8510], allData[7957:7912], allData[7359:7314], allData[6761:6716], allData[6163:6118], allData[5565:5520], allData[4967:4922], allData[4369:4324], allData[3771:3726], allData[3173:3128], allData[2575:2530], allData[1977:1932], allData[1379:1334], allData[781:736], allData[183:138]};
						Cs5arr <= {allData[11591:11546], allData[10993:10948], allData[10395:10350], allData[9797:9752], allData[9199:9154], allData[8601:8556], allData[8003:7958], allData[7405:7360], allData[6807:6762], allData[6209:6164], allData[5611:5566], allData[5013:4968], allData[4415:4370], allData[3817:3772], allData[3219:3174], allData[2621:2576], allData[2023:1978], allData[1425:1380], allData[827:782], allData[229:184]};
						D5arr <= {allData[11637:11592], allData[11039:10994], allData[10441:10396], allData[9843:9798], allData[9245:9200], allData[8647:8602], allData[8049:8004], allData[7451:7406], allData[6853:6808], allData[6255:6210], allData[5657:5612], allData[5059:5014], allData[4461:4416], allData[3863:3818], allData[3265:3220], allData[2667:2622], allData[2069:2024], allData[1471:1426], allData[873:828], allData[275:230]};
						Ds5arr <= {allData[11683:11638], allData[11085:11040], allData[10487:10442], allData[9889:9844], allData[9291:9246], allData[8693:8648], allData[8095:8050], allData[7497:7452], allData[6899:6854], allData[6301:6256], allData[5703:5658], allData[5105:5060], allData[4507:4462], allData[3909:3864], allData[3311:3266], allData[2713:2668], allData[2115:2070], allData[1517:1472], allData[919:874], allData[321:276]};
						E5arr <= {allData[11729:11684], allData[11131:11086], allData[10533:10488], allData[9935:9890], allData[9337:9292], allData[8739:8694], allData[8141:8096], allData[7543:7498], allData[6945:6900], allData[6347:6302], allData[5749:5704], allData[5151:5106], allData[4553:4508], allData[3955:3910], allData[3357:3312], allData[2759:2714], allData[2161:2116], allData[1563:1518], allData[965:920], allData[367:322]};
						F5arr <= {allData[11775:11730], allData[11177:11132], allData[10579:10534], allData[9981:9936], allData[9383:9338], allData[8785:8740], allData[8187:8142], allData[7589:7544], allData[6991:6946], allData[6393:6348], allData[5795:5750], allData[5197:5152], allData[4599:4554], allData[4001:3956], allData[3403:3358], allData[2805:2760], allData[2207:2162], allData[1609:1564], allData[1011:966], allData[413:368]};
						Fs5arr <= {allData[11821:11776], allData[11223:11178], allData[10625:10580], allData[10027:9982], allData[9429:9384], allData[8831:8786], allData[8233:8188], allData[7635:7590], allData[7037:6992], allData[6439:6394], allData[5841:5796], allData[5243:5198], allData[4645:4600], allData[4047:4002], allData[3449:3404], allData[2851:2806], allData[2253:2208], allData[1655:1610], allData[1057:1012], allData[459:414]};
						G5arr <= {allData[11867:11822], allData[11269:11224], allData[10671:10626], allData[10073:10028], allData[9475:9430], allData[8877:8832], allData[8279:8234], allData[7681:7636], allData[7083:7038], allData[6485:6440], allData[5887:5842], allData[5289:5244], allData[4691:4646], allData[4093:4048], allData[3495:3450], allData[2897:2852], allData[2299:2254], allData[1701:1656], allData[1103:1058], allData[505:460]};
						Gs5arr <= {allData[11913:11868], allData[11315:11270], allData[10717:10672], allData[10119:10074], allData[9521:9476], allData[8923:8878], allData[8325:8280], allData[7727:7682], allData[7129:7084], allData[6531:6486], allData[5933:5888], allData[5335:5290], allData[4737:4692], allData[4139:4094], allData[3541:3496], allData[2943:2898], allData[2345:2300], allData[1747:1702], allData[1149:1104], allData[551:506]};
						A5arr <= {allData[11959:11914], allData[11361:11316], allData[10763:10718], allData[10165:10120], allData[9567:9522], allData[8969:8924], allData[8371:8326], allData[7773:7728], allData[7175:7130], allData[6577:6532], allData[5979:5934], allData[5381:5336], allData[4783:4738], allData[4185:4140], allData[3587:3542], allData[2989:2944], allData[2391:2346], allData[1793:1748], allData[1195:1150], allData[597:552]};


//						A4arr <= {allData[11407:11362], allData[(18*598)+45:598*18], allData[(17*598)+45:598*17], allData[(16*598)+45:598*16], 
//						allData[(15*598)+45:598*15], allData[(14*598)+45:598*14], allData[(13*598)+45:598*13], allData[(12*598)+45:598*12], allData[(11*598)+45:598*11], 
//						allData[(10*598)+45:598*10], allData[(9*598)+45:598*9], allData[(8*598)+45:598*8], allData[(7*598)+45:598*7], allData[(6*598)+45:598*6], 
//						allData[(5*598)+45:598*5], allData[(4*598)+45:598*4], allData[(3*598)+45:598*3], allData[(2*598)+45:598*2], allData[(1*598)+45:598*1], allData[(0*598)+45:598*0]};

//						As4arr <= {920'd0};
//						B4arr <= {920'd0};
//						C5arr <= {920'd0};
//						Cs5arr <= {920'd0};
//						D5arr <= {920'd0};
//						Ds5arr <= {920'd0};
//						E5arr <= {920'd0};
//						F5arr <= {920'd0};
//						Fs5arr <= {920'd0};
//						G5arr <= {920'd0};
//						Gs5arr <= {920'd0};
//						A5arr <= {920'd0};
						
					// assign As4arr = {allData[11453:11408], allData[10855:10810], allData[10257:10212], allData[9659:9614], allData[9061:9016], allData[8463:8418], 
					// allData[7865:7820], allData[7267:7222], allData[6669:6624], allData[6071:6026], allData[5473:5428], allData[4875:4830], allData[4277:4232], 
					// allData[3679:3634], allData[3081:3036], allData[2483:2438], allData[1885:1840], allData[1287:1242], allData[689:644], allData[91:46]};

//						As4arr <= {allData[(19*598)+(2*46)-1:46+(598*19)], allData[(18*598)+(2*46)-1:46+(598*18)], allData[(17*598)+(2*46)-1:46+(598*17)], allData[(16*598)+(2*46)-1:46+(598*16)], 
//						allData[(15*598)+(2*46)-1:46+(598*15)], allData[(14*598)+(2*46)-1:46+(598*14)], allData[(13*598)+(2*46)-1:46+(598*13)], allData[(12*598)+(2*46)-1:46+(598*12)], allData[(11*598)+(2*46)-1:46+(598*11)], 
//						allData[(10*598)+(2*46)-1:46+(598*10)], allData[(9*598)+(2*46)-1:46+(598*9)], allData[(8*598)+(2*46)-1:46+(598*8)], allData[(7*598)+(2*46)-1:46+(598*7)], allData[(6*598)+(2*46)-1:46+(598*6)], 
//						allData[(5*598)+(2*46)-1:46+(598*5)], allData[(4*598)+(2*46)-1:46+(598*4)], allData[(3*598)+(2*46)-1:46+(598*3)], allData[(2*598)+(2*46)-1:46+(598*2)], allData[(1*598)+(2*46)-1:46+(598*1)], allData[(0*598)+(2*46)-1:46+(598*0)]};
//
////
////					// assign B4arr = {allData[11499:11454], allData[10901:10856], allData[10303:10258], allData[9705:9660], allData[9107:9062], allData[8509:8464], 
////					// allData[7911:7866], allData[7313:7268], allData[6715:6670], allData[6117:6072], allData[5519:5474], allData[4921:4876], allData[4323:4278], 
////					// allData[3725:3680], allData[3127:3082], allData[2529:2484], allData[1931:1886], allData[1333:1288], allData[735:690], allData[137:92]};
////						//3*24+598,2*46+598+598      3*46+598-1,2*46+598     3*46-1,2*46
//
//						B4arr <= {allData[(19*598)+(3*46)-1:(2*46)+(598*19)], allData[(18*598)+(3*46)-1:(2*46)+(598*18)], allData[(17*598)+(3*46)-1:(2*46)+(598*17)], allData[(16*598)+(3*46)-1:(2*46)+(598*16)], 
//						allData[(15*598)+(3*46)-1:(2*46)+(598*15)], allData[(14*598)+(3*46)-1:(2*46)+(598*14)], allData[(13*598)+(3*46)-1:(2*46)+(598*13)], allData[(12*598)+(3*46)-1:(2*46)+(598*12)], allData[(11*598)+(3*46)-1:(2*46)+(598*11)], 
//						allData[(10*598)+(3*46)-1:(2*46)+(598*10)], allData[(9*598)+(3*46)-1:(2*46)+(598*9)], allData[(8*598)+(3*46)-1:(2*46)+(598*8)], allData[(7*598)+(3*46)-1:(2*46)+(598*7)], allData[(6*598)+(3*46)-1:(2*46)+(598*6)], 
//						allData[(5*598)+(3*46)-1:(2*46)+(598*5)], allData[(4*598)+(3*46)-1:(2*46)+(598*4)], allData[(3*598)+(3*46)-1:(2*46)+(598*3)], allData[(2*598)+(3*46)-1:(2*46)+(598*2)], allData[(1*598)+(3*46)-1:(2*46)+(598*1)], allData[(0*598)+(3*46)-1:(2*46)+(598*0)]};
//
//
//						C5arr <= {allData[(19*598)+(4*46)-1:(3*46)+(598*19)], allData[(18*598)+(4*46)-1:(3*46)+(598*18)], allData[(17*598)+(4*46)-1:(3*46)+(598*17)], allData[(16*598)+(4*46)-1:(3*46)+(598*16)], 
//						allData[(15*598)+(4*46)-1:(3*46)+(598*15)], allData[(14*598)+(4*46)-1:(3*46)+(598*14)], allData[(13*598)+(4*46)-1:(3*46)+(598*13)], allData[(12*598)+(4*46)-1:(3*46)+(598*12)], allData[(11*598)+(4*46)-1:(3*46)+(598*11)], 
//						allData[(10*598)+(4*46)-1:(3*46)+(598*10)], allData[(9*598)+(4*46)-1:(3*46)+(598*9)], allData[(8*598)+(4*46)-1:(3*46)+(598*8)], allData[(7*598)+(4*46)-1:(3*46)+(598*7)], allData[(6*598)+(4*46)-1:(3*46)+(598*6)], 
//						allData[(5*598)+(4*46)-1:(3*46)+(598*5)], allData[(4*598)+(4*46)-1:(3*46)+(598*4)], allData[(3*598)+(4*46)-1:(3*46)+(598*3)], allData[(2*598)+(4*46)-1:(3*46)+(598*2)], allData[(1*598)+(4*46)-1:(3*46)+(598*1)], 
//						allData[(0*598)+(4*46)-1:(3*46)+(598*0)]};
//
//						Cs5arr <= {allData[(19*598)+(5*46)-1:(4*46)+(598*19)], allData[(18*598)+(5*46)-1:(4*46)+(598*18)], allData[(17*598)+(5*46)-1:(4*46)+(598*17)], allData[(16*598)+(5*46)-1:(4*46)+(598*16)], 
//						allData[(15*598)+(5*46)-1:(4*46)+(598*15)], allData[(14*598)+(5*46)-1:(4*46)+(598*14)], allData[(13*598)+(5*46)-1:(4*46)+(598*13)], allData[(12*598)+(5*46)-1:(4*46)+(598*12)], allData[(11*598)+(5*46)-1:(4*46)+(598*11)], 
//						allData[(10*598)+(5*46)-1:(4*46)+(598*10)], allData[(9*598)+(5*46)-1:(4*46)+(598*9)], allData[(8*598)+(5*46)-1:(4*46)+(598*8)], allData[(7*598)+(5*46)-1:(4*46)+(598*7)], allData[(6*598)+(5*46)-1:(4*46)+(598*6)], 
//						allData[(5*598)+(5*46)-1:(4*46)+(598*5)], allData[(4*598)+(5*46)-1:(4*46)+(598*4)], allData[(3*598)+(5*46)-1:(4*46)+(598*3)], allData[(2*598)+(5*46)-1:(4*46)+(598*2)], allData[(1*598)+(5*46)-1:(4*46)+(598*1)], 
//						allData[(0*598)+(5*46)-1:(4*46)+(598*0)]};
//
//						D5arr <= {allData[(19*598)+(6*46)-1:(5*46)+(598*19)], allData[(18*598)+(6*46)-1:(5*46)+(598*18)], allData[(17*598)+(6*46)-1:(5*46)+(598*17)], allData[(16*598)+(6*46)-1:(5*46)+(598*16)], 
//						allData[(15*598)+(6*46)-1:(5*46)+(598*15)], allData[(14*598)+(6*46)-1:(5*46)+(598*14)], allData[(13*598)+(6*46)-1:(5*46)+(598*13)], allData[(12*598)+(6*46)-1:(5*46)+(598*12)], allData[(11*598)+(6*46)-1:(5*46)+(598*11)], 
//						allData[(10*598)+(6*46)-1:(5*46)+(598*10)], allData[(9*598)+(6*46)-1:(5*46)+(598*9)], allData[(8*598)+(6*46)-1:(5*46)+(598*8)], allData[(7*598)+(6*46)-1:(5*46)+(598*7)], allData[(6*598)+(6*46)-1:(5*46)+(598*6)], 
//						allData[(5*598)+(6*46)-1:(5*46)+(598*5)], allData[(4*598)+(6*46)-1:(5*46)+(598*4)], allData[(3*598)+(6*46)-1:(5*46)+(598*3)], allData[(2*598)+(6*46)-1:(5*46)+(598*2)], allData[(1*598)+(6*46)-1:(5*46)+(598*1)], 
//						allData[(0*598)+(6*46)-1:(5*46)+(598*0)]};
//
//						Ds5arr <= {allData[(19*598)+(7*46)-1:(6*46)+(598*19)], allData[(18*598)+(7*46)-1:(6*46)+(598*18)], allData[(17*598)+(7*46)-1:(6*46)+(598*17)], allData[(16*598)+(7*46)-1:(6*46)+(598*16)], 
//						allData[(15*598)+(7*46)-1:(6*46)+(598*15)], allData[(14*598)+(7*46)-1:(6*46)+(598*14)], allData[(13*598)+(7*46)-1:(6*46)+(598*13)], allData[(12*598)+(7*46)-1:(6*46)+(598*12)], allData[(11*598)+(7*46)-1:(6*46)+(598*11)], 
//						allData[(10*598)+(7*46)-1:(6*46)+(598*10)], allData[(9*598)+(7*46)-1:(6*46)+(598*9)], allData[(8*598)+(7*46)-1:(6*46)+(598*8)], allData[(7*598)+(7*46)-1:(6*46)+(598*7)], allData[(6*598)+(7*46)-1:(6*46)+(598*6)], 
//						allData[(5*598)+(7*46)-1:(6*46)+(598*5)], allData[(4*598)+(7*46)-1:(6*46)+(598*4)], allData[(3*598)+(7*46)-1:(6*46)+(598*3)], allData[(2*598)+(7*46)-1:(6*46)+(598*2)], allData[(1*598)+(7*46)-1:(6*46)+(598*1)], 
//						allData[(0*598)+(7*46)-1:(6*46)+(598*0)]};
//
//						E5arr <= {allData[(19*598)+(8*46)-1:(7*46)+(598*19)], allData[(18*598)+(8*46)-1:(7*46)+(598*18)], allData[(17*598)+(8*46)-1:(7*46)+(598*17)], allData[(16*598)+(8*46)-1:(7*46)+(598*16)], 
//						allData[(15*598)+(8*46)-1:(7*46)+(598*15)], allData[(14*598)+(8*46)-1:(7*46)+(598*14)], allData[(13*598)+(8*46)-1:(7*46)+(598*13)], allData[(12*598)+(8*46)-1:(7*46)+(598*12)], allData[(11*598)+(8*46)-1:(7*46)+(598*11)], 
//						allData[(10*598)+(8*46)-1:(7*46)+(598*10)], allData[(9*598)+(8*46)-1:(7*46)+(598*9)], allData[(8*598)+(8*46)-1:(7*46)+(598*8)], allData[(7*598)+(8*46)-1:(7*46)+(598*7)], allData[(6*598)+(8*46)-1:(7*46)+(598*6)], 
//						allData[(5*598)+(8*46)-1:(7*46)+(598*5)], allData[(4*598)+(8*46)-1:(7*46)+(598*4)], allData[(3*598)+(8*46)-1:(7*46)+(598*3)], allData[(2*598)+(8*46)-1:(7*46)+(598*2)], allData[(1*598)+(8*46)-1:(7*46)+(598*1)], 
//						allData[(0*598)+(8*46)-1:(7*46)+(598*0)]};
//
//						F5arr <= {allData[(19*598)+(9*46)-1:(8*46)+(598*19)], allData[(18*598)+(9*46)-1:(8*46)+(598*18)], allData[(17*598)+(9*46)-1:(8*46)+(598*17)], allData[(16*598)+(9*46)-1:(8*46)+(598*16)], 
//						allData[(15*598)+(9*46)-1:(8*46)+(598*15)], allData[(14*598)+(9*46)-1:(8*46)+(598*14)], allData[(13*598)+(9*46)-1:(8*46)+(598*13)], allData[(12*598)+(9*46)-1:(8*46)+(598*12)], allData[(11*598)+(9*46)-1:(8*46)+(598*11)], 
//						allData[(10*598)+(9*46)-1:(8*46)+(598*10)], allData[(9*598)+(9*46)-1:(8*46)+(598*9)], allData[(8*598)+(9*46)-1:(8*46)+(598*8)], allData[(7*598)+(9*46)-1:(8*46)+(598*7)], allData[(6*598)+(9*46)-1:(8*46)+(598*6)], 
//						allData[(5*598)+(9*46)-1:(8*46)+(598*5)], allData[(4*598)+(9*46)-1:(8*46)+(598*4)], allData[(3*598)+(9*46)-1:(8*46)+(598*3)], allData[(2*598)+(9*46)-1:(8*46)+(598*2)], allData[(1*598)+(9*46)-1:(8*46)+(598*1)], 
//						allData[(0*598)+(9*46)-1:(8*46)+(598*0)]};
//
//						Fs5arr <= {allData[(19*598)+(10*46)-1:(9*46)+(598*19)], allData[(18*598)+(10*46)-1:(9*46)+(598*18)], allData[(17*598)+(10*46)-1:(9*46)+(598*17)], allData[(16*598)+(10*46)-1:(9*46)+(598*16)], 
//						allData[(15*598)+(10*46)-1:(9*46)+(598*15)], allData[(14*598)+(10*46)-1:(9*46)+(598*14)], allData[(13*598)+(10*46)-1:(9*46)+(598*13)], allData[(12*598)+(10*46)-1:(9*46)+(598*12)], allData[(11*598)+(10*46)-1:(9*46)+(598*11)], 
//						allData[(10*598)+(10*46)-1:(9*46)+(598*10)], allData[(9*598)+(10*46)-1:(9*46)+(598*9)], allData[(8*598)+(10*46)-1:(9*46)+(598*8)], allData[(7*598)+(10*46)-1:(9*46)+(598*7)], allData[(6*598)+(10*46)-1:(9*46)+(598*6)], 
//						allData[(5*598)+(10*46)-1:(9*46)+(598*5)], allData[(4*598)+(10*46)-1:(9*46)+(598*4)], allData[(3*598)+(10*46)-1:(9*46)+(598*3)], allData[(2*598)+(10*46)-1:(9*46)+(598*2)], allData[(1*598)+(10*46)-1:(9*46)+(598*1)], 
//						allData[(0*598)+(10*46)-1:(9*46)+(598*0)]};
//
//						G5arr <= {allData[(19*598)+(11*46)-1:(10*46)+(598*19)], allData[(18*598)+(11*46)-1:(10*46)+(598*18)], allData[(17*598)+(11*46)-1:(10*46)+(598*17)], allData[(16*598)+(11*46)-1:(10*46)+(598*16)], 
//						allData[(15*598)+(11*46)-1:(10*46)+(598*15)], allData[(14*598)+(11*46)-1:(10*46)+(598*14)], allData[(13*598)+(11*46)-1:(10*46)+(598*13)], allData[(12*598)+(11*46)-1:(10*46)+(598*12)], allData[(11*598)+(11*46)-1:(10*46)+(598*11)], 
//						allData[(11*598)+(11*46)-1:(10*46)+(598*10)], allData[(9*598)+(11*46)-1:(10*46)+(598*9)], allData[(8*598)+(11*46)-1:(10*46)+(598*8)], allData[(7*598)+(11*46)-1:(10*46)+(598*7)], allData[(6*598)+(11*46)-1:(10*46)+(598*6)], 
//						allData[(5*598)+(11*46)-1:(10*46)+(598*5)], allData[(4*598)+(11*46)-1:(10*46)+(598*4)], allData[(3*598)+(11*46)-1:(10*46)+(598*3)], allData[(2*598)+(11*46)-1:(10*46)+(598*2)], allData[(1*598)+(11*46)-1:(10*46)+(598*1)], 
//						allData[(0*598)+(11*46)-1:(10*46)+(598*0)]};
//
//						Gs5arr <= {allData[(19*598)+(12*46)-1:(11*46)+(598*19)], allData[(18*598)+(12*46)-1:(11*46)+(598*18)], allData[(17*598)+(12*46)-1:(11*46)+(598*17)], allData[(16*598)+(12*46)-1:(11*46)+(598*16)], 
//						allData[(15*598)+(12*46)-1:(11*46)+(598*15)], allData[(14*598)+(12*46)-1:(11*46)+(598*14)], allData[(13*598)+(12*46)-1:(11*46)+(598*13)], allData[(12*598)+(12*46)-1:(11*46)+(598*12)], allData[(11*598)+(12*46)-1:(11*46)+(598*11)], 
//						allData[(11*598)+(12*46)-1:(11*46)+(598*10)], allData[(9*598)+(12*46)-1:(11*46)+(598*9)], allData[(8*598)+(12*46)-1:(11*46)+(598*8)], allData[(7*598)+(12*46)-1:(11*46)+(598*7)], allData[(6*598)+(12*46)-1:(11*46)+(598*6)], 
//						allData[(5*598)+(12*46)-1:(11*46)+(598*5)], allData[(4*598)+(12*46)-1:(11*46)+(598*4)], allData[(3*598)+(12*46)-1:(11*46)+(598*3)], allData[(2*598)+(12*46)-1:(11*46)+(598*2)], allData[(1*598)+(12*46)-1:(11*46)+(598*1)], 
//						allData[(0*598)+(12*46)-1:(11*46)+(598*0)]};
//
//						A5arr <= {allData[(19*598)+(13*46)-1:(12*46)+(598*19)], allData[(18*598)+(13*46)-1:(12*46)+(598*18)], allData[(17*598)+(13*46)-1:(12*46)+(598*17)], allData[(16*598)+(13*46)-1:(12*46)+(598*16)], 
//						allData[(15*598)+(13*46)-1:(12*46)+(598*15)], allData[(14*598)+(13*46)-1:(12*46)+(598*14)], allData[(13*598)+(13*46)-1:(12*46)+(598*13)], allData[(12*598)+(13*46)-1:(12*46)+(598*12)], allData[(11*598)+(13*46)-1:(12*46)+(598*11)], 
//						allData[(11*598)+(13*46)-1:(12*46)+(598*10)], allData[(9*598)+(13*46)-1:(12*46)+(598*9)], allData[(8*598)+(13*46)-1:(12*46)+(598*8)], allData[(7*598)+(13*46)-1:(12*46)+(598*7)], allData[(6*598)+(13*46)-1:(12*46)+(598*6)], 
//						allData[(5*598)+(13*46)-1:(12*46)+(598*5)], allData[(4*598)+(13*46)-1:(12*46)+(598*4)], allData[(3*598)+(13*46)-1:(12*46)+(598*3)], allData[(2*598)+(13*46)-1:(12*46)+(598*2)], allData[(1*598)+(13*46)-1:(12*46)+(598*1)], 
//						allData[(0*598)+(13*46)-1:(12*46)+(598*0)]};
						
						isUpdateArr <= 0;
						enable <= 1;
					end
					if(enable == 1) begin
						enable <= 0;
					end
   end
	
	
	findMaxMinIn20 fA4(enable, resetn, clock, A4arr, deltaA4);
	findMaxMinIn20 fAs4(enable, resetn, clock, As4arr, deltaAs4);
	findMaxMinIn20 fB4(enable, resetn, clock, B4arr, deltaB4);
	findMaxMinIn20 fC5(enable, resetn, clock, C5arr, deltaC5);
	findMaxMinIn20 fCs5(enable, resetn, clock, Cs5arr, deltaCs5);
	findMaxMinIn20 fD5(enable, resetn, clock, D5arr, deltaD5);
	findMaxMinIn20 fDs5(enable, resetn, clock, Ds5arr, deltaDs5);
	findMaxMinIn20 fE5(enable, resetn, clock, E5arr, deltaE5);
	findMaxMinIn20 fF5(enable, resetn, clock, F5arr, deltaF5);
	findMaxMinIn20 fFs5(enable,resetn, clock, Fs5arr, deltaFs5);
	findMaxMinIn20 fG5(enable,resetn, clock, G5arr, deltaG5);
	findMaxMinIn20 fGs5(enable,resetn, clock, Gs5arr, deltaGs5);
	findMaxMinIn20 fA5(enable, resetn, clock, A5arr, deltaA5);

	findNote fn(enable, deltaA4, deltaAs4, deltaB4, deltaC5, deltaCs5, deltaD5, deltaDs5, deltaE5, deltaF5, deltaFs5, deltaG5, deltaGs5, deltaA5, finalResult);
endmodule


//for getting max and min per 20 y's
//y is the filtered value of the sample, count is for the module to count up to 100 y's and output
//pass in 0 for both max and min for each time this module is called
module findMaxMinIn20(enable, resetn, clock, sampleOf20, delta);
	input clock, enable, resetn; //clearMaxMin;
	//each y is 11 bit wide and the arr has 20 elements
	//46bits is one sample
	//there are a total of 20 sets of 46 bits
	input [919:0]sampleOf20;
	//assign sampleOf20 = {874'd0, 46'd9};
	reg signed [45:0]max;
	reg signed [45:0]min;
	reg signed [45:0]maxout, minout;
	wire [45:0] w1;
	//wire [45:0] temp;
	reg [4:0] count;
	output signed [46:0]delta;
	assign w1 = (46*count) + 45;
	reg isComparing;
	reg isCalculating;
	//reg maxMinClear;

	wire signed [45:0] test;
	assign test = sampleOf20[(w1) -:46];
	
	
//	always @ (*) begin
//		if(max[45] == 1 && min[45] == 0)begin
//			temp = max;
//			max = min;
//			min = temp;
//		end
//		if((max[45] == 0 && min[45] == 0)||(max[45] == 1 && min[45] == 1))begin
//			if(max < min)begin
//				temp = max;
//				max = min;
//				min = temp;
//			end
//		end
//	end
	
	always @ (posedge clock) begin
		if(resetn)begin
			max <= 1'b0;
			min <= 1'b0;
			maxout <= 1'b0;
			minout <= 1'b0;
		end
		else begin

			if(!isCalculating && enable) begin
				isCalculating <= 1;
			end
			
			if(count != 19 && isCalculating) begin
				if(sampleOf20[w1]== 1)begin
					if(max[45] == 1)begin
						max <= ((sampleOf20[(w1) -:46] >= max) ? sampleOf20[(w1) -:46] : max); 		
					end
					if(max[45] == 0)begin
						max <= max;
					end
					if(min[45] == 1)begin
						min <= ((sampleOf20[(w1) -:46] < min) ? sampleOf20[(w1) -:46] : min ); 		
					end
					if(min[45] == 0)begin
						min <= sampleOf20[(w1) -:46];
					end
				end
				if(sampleOf20[w1]== 0)begin
					if(max[45] == 1)begin
						max <= sampleOf20[(w1) -:46]; 		
					end
					if(max[45] == 0)begin
						max <= ((sampleOf20[(w1) -:46] >= max) ? sampleOf20[(w1) -:46]  : max); 
					end
					if(min[45] == 1)begin
						min <= min; 		
					end
					if(min[45] == 0)begin
						min <= ((sampleOf20[(w1) -:46] < min) ? sampleOf20[(w1) -:46] : min); 
					end
				end
				count <= count + 1;
			end
			else if(count == 19) begin
				count <= 0;
				isCalculating <= 0;
				maxout <= max;
				minout <= min;
				max <= 0;
				min <= 0;
				end
		end
	end
	
	assign delta = maxout - minout;
endmodule 


module findNote(enable, ptpA4, ptpAs4, ptpB4, ptpC5, ptpCs5, ptpD5, ptpDs5, ptpE5, ptpF5, ptpFs5, ptpG5, ptpGs5, ptpA5, result);
	input[45:0] ptpA4, ptpAs4, ptpB4, ptpC5, ptpCs5, ptpD5, ptpDs5, ptpE5, ptpF5, ptpFs5, ptpG5, ptpGs5, ptpA5;
	input enable;
//	assign ptpA4 = 46'd343;
//	assign ptpAs4 = 46'd129;
//	assign ptpB4 = 46'd192;
//	assign ptpC5 = 46'd93;
//	assign ptpCs5 = 46'd110;
//	assign ptpD5 = 46'd111;
//	assign ptpDs5 = 46'd123;
//	assign ptpE5 = 46'd143;
//	assign ptpF5 = 46'd354;
//	assign ptpFs5 = 46'd342;
//	assign ptpG5 = 46'd132;
//	assign ptpGs5 = 46'd128;
//	assign ptpA5 = 46'd0119;

	output reg [3:0]result;
	//output letter;
	reg [45:0]resultValue;
	parameter A4 = 4'b0000;
	parameter As4 = 4'b0001;
	parameter B4 = 4'b0010;
	parameter C5 = 4'b0011;
	parameter Cs5 = 4'b0100;
	parameter D5 = 4'b0101;
	parameter Ds5 = 4'b0110;
	parameter E5 = 4'b0111;
	parameter F5 = 4'b1000;
	parameter Fs5 = 4'b1001;
	parameter G5 = 4'b1010;
	parameter Gs5 = 4'b1011;
	parameter A5 = 4'b1100;
	parameter Ud = 4'b1111;
	reg [45:0]greaterOfA4As4;
	reg [45:0]greaterOfB4C5;
	reg [45:0]greaterOfCs5D5;
	reg [45:0]greaterOfDs5E5;
	reg [45:0]greaterOfF5Fs5;
	reg [45:0]greaterOfG5Gs5;

	reg [45:0]greaterofA4_to_C5;
	reg [45:0]greaterofCs5_to_E5;
	reg [45:0]greaterofF5_to_Gs5;
	reg [45:0]greaterofA4_to_E5;
	reg [45:0]greaterofF5_to_A5;

	always @(*)begin
		if(enable)begin

	//assign result = (A4 >= As4) ? A4 : As4;
		 greaterOfA4As4 = (ptpA4 >= ptpAs4) ? ptpA4 : ptpAs4;
		 greaterOfB4C5 = (ptpB4 >= ptpC5) ? ptpB4: ptpC5;
		 greaterOfCs5D5 = (ptpCs5 >= ptpD5) ? ptpCs5 : ptpD5;
		 greaterOfDs5E5 = (ptpDs5 >= ptpE5) ? ptpDs5 : ptpE5;
		 greaterOfF5Fs5 = (ptpF5 >= ptpFs5) ? ptpF5 : ptpFs5;
		 greaterOfG5Gs5 = (ptpG5 >= ptpGs5) ? ptpG5: ptpGs5;

		 greaterofA4_to_C5 = (greaterOfA4As4 >= greaterOfB4C5) ? greaterOfA4As4 : greaterOfB4C5;
		 greaterofCs5_to_E5 = (greaterOfCs5D5 >= greaterOfDs5E5) ? greaterOfCs5D5 : greaterOfDs5E5;
		 greaterofF5_to_Gs5 = (greaterOfF5Fs5 >= greaterOfG5Gs5) ? greaterOfF5Fs5 : greaterOfG5Gs5;

		 greaterofA4_to_E5 = (greaterofA4_to_C5 >= greaterofCs5_to_E5) ? greaterofA4_to_C5 : greaterofCs5_to_E5;
		 greaterofF5_to_A5 = (greaterofF5_to_Gs5 >= ptpA5) ?  greaterofF5_to_Gs5 : ptpA5;

		 resultValue = (greaterofA4_to_E5 >= greaterofF5_to_A5) ? greaterofA4_to_E5 : greaterofF5_to_A5; 
		 //greaterofF5_to_Gs5
		if(resultValue[34:27] == 8'd0)begin
			result = Ud;
		end 
		else begin
			if(resultValue == ptpA4)  result = A4;
			if(resultValue == ptpAs4)  result = As4;
			if(resultValue == ptpB4)  result = B4;
			if(resultValue == ptpC5)  result = C5;
			if(resultValue == ptpCs5)  result = Cs5;
			if(resultValue == ptpD5)  result = D5;
			if(resultValue == ptpDs5)  result = Ds5;
			if(resultValue == ptpE5)  result = E5;
			if(resultValue == ptpF5)  result = F5;
			if(resultValue == ptpFs5)  result = Fs5;
			if(resultValue == ptpG5)  result = G5;
			if(resultValue == ptpGs5)  result = Gs5;
			if(resultValue == ptpA5)  result = A5;
		end
		end
	end
endmodule
