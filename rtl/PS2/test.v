`timescale 1ns / 1ps

module add_shft_mul (
		     input clk,
                     output reg                done,
	             output reg [3:0] aquele
                     );

   reg [3:0]                     counter = 10;
   reg [3:0]			test = 10;


   always @(posedge clk) begin
        aquele <= test;
	if (counter + test > 15) begin
		test <= test - 1;
		done <= 1;
	end else
		done <= 0;
   end


endmodule


module add_shft_mul_tb ();

   wire        done;
   wire [3:0] aquele;
   reg clk = 0;
   
   add_shft_mul mult0 (
		       .clk(clk),
                       .done(done),
.aquele(aquele)
                     );   

   initial begin

      $dumpfile("dump.vcd");
      $dumpvars;
      

      @(posedge clk);
      @(posedge clk);
      @(posedge clk);


      @(posedge clk);
      @(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
      
      $finish;
   end
   
   always #10 clk = ~clk;
 
endmodule
