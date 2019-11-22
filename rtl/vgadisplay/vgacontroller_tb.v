
`timescale 1ns / 1ps

module vgacontroller_tb;
   
   reg	         clk;
   reg	         rst;
   wire [8:0]    x_pos;      
   wire [9:0]    y_pos;
   wire 	 display_en;
   wire		 hs;
   wire		 vs;

   // Instantiate the Unit Under Test (UUT)
   vgacontroller uut (
		.clk(clk),
		.rst(rst),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.display_en(display_en),
		.hs(hs),
                .vs(vs)
		);
 
   
   initial begin
      $dumpfile("vgacontroller.vcd");
      $dumpvars();
      
      clk = 0;
      rst = 1;
      #40
      rst = 0;   
      #100000000	 
      $finish;

   end

   always #10
	clk = ~clk; //period=20ns => 100MHz 

endmodule

