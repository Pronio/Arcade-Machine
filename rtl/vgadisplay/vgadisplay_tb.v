
`timescale 1ns / 1ps

module vgadisplay_tb;
   
   reg		         clk;
   reg		         rst;
   reg				 sel;
   reg [1:0]		 addr;
   reg [9:0]		 data_in;
   wire reg			 HS;      
   wire reg			 VS;
   wire	reg [2:0]	 red;
   wire	reg [2:0]	 green;
   wire	reg [1:0]	 blue;

   // Instantiate the Unit Under Test (UUT)
   vgadisplay uut (
		.clk(clk),
		.rst(rst),
		.sel(sel),
		.addr(addr),
		.data_in(data_in),
		.HS(HS),
        .VS(VS),
		.red(red),
		.green(green),
		.blue(blue)
		);
 
   
   initial begin
      $dumpfile("vgadisplay.vcd");
      $dumpvars();
      
      clk = 0;
      rst = 1;
      sel = 0;
      addr = 0;
      data_in = 0;
      #40
      rst = 0; 
      sel = 1;
      addr = 0;
      data_in = 200;
      #100
      sel = 1;
      addr = 1;
      data_in = 200;
      #100
      sel = 1;
      addr = 2;
      data_in = 30;
      #100
      sel = 1;
      addr = 3;
      data_in = 400;
      #100
      sel = 0;
      addr = 0;
      data_in = 0;
      #50000000 //first frame
      sel = 1;
      addr = 0;
      data_in = 400;
      #100
      sel = 1;
      addr = 1;
      data_in = 400;
      #100
      sel = 1;
      addr = 2;
      data_in = 200;
      #100
      sel = 1;
      addr = 3;
      data_in = 100;
      #100
      sel = 0;
      addr = 0;
      data_in = 0;
      #50000000 //secound frame
      $finish;

   end

   always #10
	clk = ~clk; //period=10ns => 50MHz 

endmodule

