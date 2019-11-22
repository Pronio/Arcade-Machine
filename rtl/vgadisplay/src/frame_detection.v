`timescale 1ns/1ps

module frame_detection (
	input [8:0] 	 x_pos,
	input [9:0] 	 y_pos,
	input [5:0]		 W,
	output reg	 detected 
); 


always @ (*) 
	begin
		if ((y_pos<W)||(x_pos<W)||(x_pos>479-W)||(y_pos>639-W))
			detected = 1;
		else
			detected = 0;
   	end

endmodule
