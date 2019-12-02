`timescale 1ns / 1ps

`include "xdefs.vh"

module xtop_tb;
   
   //parameters 
   parameter clk_period = 20;

   //
   // Interface signals
   //
   reg clk;
   reg rst;
   wire trap;
   
`ifndef NO_EXT
   //external parallel interface
   wire [`ADDR_W-2:0] par_addr;
   wire               par_we;
   reg [`DATA_W-1:0]  par_in;
   wire [`DATA_W-1:0] par_out;
`endif

   wire [3:0]	      an;
   wire [6:0]         seg;
   wire 	      dp;

   reg                ps2Clk;
   reg                ps2Data;

   wire               HSYNC;
   wire               VSYNC;
   wire [2:0]         OutRed;
   wire [2:0]         OutGreen;
   wire [1:0]         OutBlue;


   //iterator and timer
   integer 		   k, start_time;

   // Testbench data memory
   reg [`DATA_W-1:0] data [2**`REGF_ADDR_W-1:0];
   
   // Instantiate the Unit Under Test (UUT)
   xtop uut (
	     .clk(clk),
             .rst(rst),
             .trap(trap)
	     
`ifndef NO_EXT
   	     // external parallel interface
	     , .par_addr(par_addr),
	     .par_we(par_we),
	     .par_in(par_in),
	     .par_out(par_out)
`endif

	     , .an(an),
	     .seg(seg),
	     .dp(dp),
             .PS2C(ps2Clk),
             .PS2D(ps2Data),
             .HSYNC(HSYNC),
             .VSYNC(VSYNC),
             .OutRed(OutRed),
             .OutGreen(OutGreen),
             .OutBlue(OutBlue)
	     );
   
	task oKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task lKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask


	task wKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task sKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task breakCode;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task randKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask


   initial begin
      
`ifdef DEBUG
      $dumpfile("xtop.vcd");
      $dumpvars(0,xtop_tb);
`endif
        
      // Initialize Inputs
      clk = 1;
      rst = 0;
      ps2Clk = 1;
      ps2Data = 1;  
      
     // assert reset for 1 clock cycle
      #(clk_period+1)
      rst = 1;
      #clk_period;
      rst = 0;
      
      //
      // Run picoVersat
      //
      start_time = $time;

      #20000000;
      wKey();
      lKey();
      oKey();
      #12000000;
      breakCode();
      wKey();
      #2000000;
      breakCode();
      oKey();
      #2400000;
      breakCode();
      lKey();


      //
      // Dump reg file data to outfile
      //
      for (k = 0; k < 2**`REGF_ADDR_W; k=k+1)
	   data[k] = uut.regf.regf[k];
  
      $writememh("data_out.hex", data, 0, 2**`REGF_ADDR_W - 1);

   end // initial begin


   //
   // End simulation
   //   
   always @(posedge clk)
     if(trap) begin 
        $display("Catched Trap at time  %0d clock cycles:",($time-start_time)/clk_period);
        $display("%s address %d, PC 0x%x", uut.data_we? "Write": "Read", uut.data_addr, uut.pc);
        $finish;
     end 

   // CLOCK
   always 
     #(clk_period/2) clk = ~clk;

   // show registers
   wire [`DATA_W-1:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
   assign r0 = uut.regf.regf[0];
   assign r1 = uut.regf.regf[1];
   assign r2 = uut.regf.regf[2];
   assign r3 = uut.regf.regf[3];
   assign r4 = uut.regf.regf[4];
   assign r5 = uut.regf.regf[5];
   assign r6 = uut.regf.regf[6];
   assign r7 = uut.regf.regf[7];
   assign r8 = uut.regf.regf[8];
   assign r9 = uut.regf.regf[9];
   assign r10 = uut.regf.regf[10];
   assign r11 = uut.regf.regf[11];
   assign r12 = uut.regf.regf[12];
   assign r13 = uut.regf.regf[13];
   assign r14 = uut.regf.regf[14];
   assign r15 = uut.regf.regf[15];  

endmodule

