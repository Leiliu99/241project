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