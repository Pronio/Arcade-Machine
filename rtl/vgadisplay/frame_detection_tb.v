
`timescale 1ns / 1ps

module frame_detection_tb;
   
   reg [8:0] 	 x_pos;
   reg [9:0] 	 y_pos;
   reg  [5:0]	 W;
   wire		 detected; 

   // Instantiate the Unit Under Test (UUT)
   frame_detection uut (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.W(W),
                .detected(detected)
		);
 
   
   initial begin
      $dumpfile("frame_detection.vcd");
      $dumpvars();
      
      y_pos = 0;
      x_pos = 0;
      W = 10;
    
      #10000000	 
      $finish;

   end

   always #10 begin
      if((x_pos<479)&&(y_pos==639))
         x_pos = x_pos+1;
      else if(y_pos==639)
         x_pos = 0;

      if(y_pos<639)
         y_pos = y_pos+1;
      else
         y_pos = 0;
   end
	

endmodule

