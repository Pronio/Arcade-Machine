`timescale 1ns/1ps

module frame_detection #(
	parameter X_BITS=8,
	parameter Y_BITS=9,
	parameter HEIGHT=480,
	parameter WIDTH=640
)(
	input [X_BITS:0] 	 x_pos,
	input [Y_BITS:0] 	 y_pos,
	input [5:0]		 W,
	output reg	 detected 
); 


always @ (*) 
	begin
		if ((y_pos<W)||(x_pos<W)||(x_pos>HEIGHT-1-W)||(y_pos>WIDTH-1-W))
			detected = 1;
		else
			detected = 0;
   	end

endmodule
