`timescale 1ns/1ps

module object_detection (
	input [8:0] 	 x_pos,
	input [9:0] 	 y_pos,
	input  [8:0]	 Px,
	input  [9:0]	 Py,
	input  [9:0]	 W,
	input  [8:0]	 H,
	output reg		 detected 
); 


always @ (*) 
	begin
		if ((y_pos>=Py)&&(y_pos<Py+W)&&(x_pos>=Px)&&(x_pos<Px+H))
			detected = 1;
		else
			detected = 0;
   	end

endmodule
