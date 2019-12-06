`timescale 1ns/1ps

module object_detection #(
	parameter X_BITS=8,
	parameter Y_BITS=9
)(
	input [X_BITS:0] 	 x_pos,
	input [Y_BITS:0] 	 y_pos,
	input  [X_BITS:0]	 Px,
	input  [Y_BITS:0]	 Py,
	input  [Y_BITS:0]	 W,
	input  [X_BITS:0]	 H,
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
