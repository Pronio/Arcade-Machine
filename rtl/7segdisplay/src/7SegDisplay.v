`timescale 1ns/1ps

module segDisplay (
	input		 clk,
	input		 rst,
	input		 sel,
	input		 addr,
	input        data_in,
	output reg [7:0] cathode,      //a, b, c, d, e, f, g and dp (active low)
	output reg [3:0] anode,        //anode for display 0, 1, 2 and 3 (active low)
	output reg 		 rst_out
); 

	//divide system clock by 2^N using a counter
	//parameter is used so value can be changed when module is called in other module (top)
	parameter divider = 16;
   

	reg inc_player1;
	reg inc_player2;

	//whatever <= {1'b1, (Nbits-1) {1'b0}}; 
	reg [15:0] counter = {16 {1'b0}};
	//players score is up to 99, divided in two parameters
	reg [3:0] scorePlayer1_2;
	reg [3:0] scorePlayer1_1;
	reg [3:0] scorePlayer2_2;
	reg [3:0] scorePlayer2_1;
	//start reg that will store number to be represented with the equivalent to a dash - none number from 1-9
	reg [3:0] displayValue = 4'd10;

	reg data_in_mutex, data_in_mutex2;
	reg [3:0] carry_mutex_1, carry_mutex_2;
	

	always @ * begin
		case (addr)
			1'b0: data_in_mutex <= data_in;  
			1'b1: data_in_mutex <= 0;
		endcase
	end

	always @ * begin
		case (addr)
			1'b0: data_in_mutex2 <= 0; 
			1'b1: data_in_mutex2 <= data_in;
		endcase
	end

	always @ * begin
		case (scorePlayer1_1 != 4'd9)
			1'b0: carry_mutex_1 <= 0; 
			1'b1: carry_mutex_1 <= scorePlayer1_1+1;
		endcase
	end

	always @ * begin
		case (scorePlayer2_1 != 4'd9)
			1'b0: carry_mutex_2 <= 0; 
			1'b1: carry_mutex_2 <= scorePlayer2_1+1;
		endcase
	end

	always @ (posedge clk) 
	begin
		if (rst || inc_player1) begin
			inc_player1<= 0;
		end else if(sel) begin 
			inc_player1 <= data_in_mutex;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst || inc_player2) begin
			inc_player2<= 0;
		end else if(sel) begin 
			inc_player2 <= data_in_mutex2;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			counter <= 0;
		end else begin 
			counter <= counter + 1;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			scorePlayer1_1<=4'd0;
		end else if(inc_player1) begin 
			scorePlayer1_1 <= carry_mutex_1;	
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			scorePlayer2_1<=4'd0;
		end else if(inc_player2) begin 
			scorePlayer2_1 <= carry_mutex_2;	
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			scorePlayer1_2<=4'd0;
		end else if((scorePlayer1_1==4'd9)&&inc_player1) begin 
			scorePlayer1_2 <= scorePlayer1_2 + 1;	
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			scorePlayer2_2<=4'd0;
		end else if((scorePlayer2_1==4'd9)&&inc_player2) begin 
			scorePlayer2_2 <= scorePlayer2_2 + 1;	
		end
   	end

   always @ * //2 MSBs of counter are used to select the value of anode and which value of cathode to use
   begin
      case(counter[15:14])
         2'b00: 
	 begin
            anode <= 4'b1110; 
            displayValue <= scorePlayer1_1;
         end
         2'b01: 
	 begin
            anode <= 4'b1101; 
            displayValue <= scorePlayer1_2;
         end
         2'b10: 
	 begin
            anode <= 4'b1011; 
            displayValue <= scorePlayer2_1;
         end
         2'b11: 
	 begin
            anode <= 4'b0111; 
            displayValue <= scorePlayer2_2;
         end
         default: 
	 begin
            anode <= 4'b0000;  
            displayValue <= 4'd10;
         end
      endcase
   end

    // Cathode patterns of the 7-segment LED display 
   always @(displayValue)
   begin
      case(displayValue)
         4'd0: cathode <= 8'b11000000; // "0"     
         4'd1: cathode <= 8'b11111001; // "1" 
         4'd2: cathode <= 8'b10100100; // "2" 
         4'd3: cathode <= 8'b10110000; // "3" 
         4'd4: cathode <= 8'b10011001; // "4" 
         4'd5: cathode <= 8'b10010010; // "5" 
         4'd6: cathode <= 8'b10000010; // "6" 
         4'd7: cathode <= 8'b11111000; // "7" 
         4'd8: cathode <= 8'b10000000; // "8"     
         4'd9: cathode <= 8'b10010000; // "9" 
         default: cathode <= 8'b10111111; // "-"
      endcase
    end

    always @*
    begin
	if(((scorePlayer1_1 == 4'd9) && (scorePlayer1_2 == 4'd9)) || ((scorePlayer2_1 == 4'd9) && (scorePlayer2_2 == 4'd9)))
    		rst_out <= 1;
	else
		rst_out <= 0;
    end

endmodule
