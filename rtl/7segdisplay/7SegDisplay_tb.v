
`timescale 1ns / 1ps

module segDisplay_tb;
   
   reg	         clk;
   reg	         rst;
   reg		 sel;
   reg		 addr;
   reg	         data_in;
   wire [7:0]    cathode;      
   wire [3:0]    anode;
   wire 	 rst_out; 

   // Instantiate the Unit Under Test (UUT)
   segDisplay uut (
		.clk(clk),
		.rst(rst),
		.sel(sel),
		.addr(addr),
		.data_in(data_in),
		.cathode(cathode),
                .anode(anode),
		.rst_out(rst_out)
		);
 
   
   initial begin
      $dumpfile("7SegDisplay.vcd");
      $dumpvars();
      
      clk = 0;
      rst = 1;
      sel = 0;
      addr = 0;
      data_in = 0;
      #250000
      clk = 0;
      rst = 0;
      sel = 0;
      addr = 0;
      data_in = 0;
      #1000005
      rst = 0;
      sel = 1;
      addr = 0;
      data_in = 1;
      #20
      rst = 0;
      sel = 0;
      addr = 0;
      data_in = 1;
      #1000000
      rst = 0;
      sel = 1;
      addr = 1;
      data_in = 1;
      #20
      rst = 0;
      sel = 0;
      addr = 1;
      data_in = 1;

      repeat (12) begin
      #1000000
      rst = 0;
      sel = 1;
      addr = 1;
      data_in = 1;
      #20
      rst = 0;
      sel = 0;
      addr = 1;
      data_in = 1;
      end

      repeat (110) begin
      #1000000
      rst = 0;
      sel = 1;
      addr = 0;
      data_in = 1;
      #20
      rst = 0;
      sel = 0;
      addr = 0;
      data_in = 1;
      end
   
      #1000000	 
      $finish;

   end

   always #10
	clk = ~clk; //period=20ns => 100MHz 

endmodule

