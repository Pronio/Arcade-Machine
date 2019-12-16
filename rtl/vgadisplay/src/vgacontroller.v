`timescale 1ns/1ps

module vgacontroller #(
	parameter HEIGHT=480,
	parameter WIDTH=640,
	parameter PERIOD_H=800,
	parameter PULSE_H=96,
	parameter BACK_H=48,
	parameter PERIOD_V=521,
	parameter PULSE_V=2,
	parameter BACK_V=29

) (
	input		 clk,
	input		 rst,
	output [clog2(HEIGHT)-1:0] 	 x_pos,
	output [clog2(WIDTH)-1:0] 	 y_pos,
	output reg	 display_en,
	output reg	 hs,
	output reg	 vs
); 

	reg clk_divider;
	reg [clog2(PERIOD_V)-1:0] vertical_counter;
	reg [clog2(PERIOD_H)-1:0] horizontal_counter;
	reg [clog2(HEIGHT)-1:0] x;
	reg [clog2(WIDTH)-1:0] y;

	always @ (posedge clk) 
	begin
		if (rst) begin
			clk_divider<= 0;
		end else begin 
			clk_divider<= ~clk_divider;
		end
   	end

/*	always @ (posedge clk)
	begin
		clk_divider<=0;
	end
*/

	always @ (posedge clk) 
	begin
		if (rst) begin
			horizontal_counter<= 0;
		end else if((clk_divider==0)&&(horizontal_counter==PERIOD_H-1)) begin 
			horizontal_counter<= 0;
		end else if(clk_divider==0) begin 
			horizontal_counter<= horizontal_counter+1;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			vertical_counter<= 0;
		end else if((horizontal_counter==PERIOD_H-1)&&(vertical_counter==PERIOD_V-1)&&(clk_divider==0)) begin 
			vertical_counter<= 0;
		end else if((horizontal_counter==PERIOD_H-1)&&(clk_divider==0)) begin 
			vertical_counter<= vertical_counter+1;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			hs <= 0;
		end else if((horizontal_counter==PULSE_H)&&(clk_divider==0)) begin 
			hs <= 1;
		end else if((horizontal_counter==0)&&(clk_divider==0)) begin
			hs <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			vs <= 0;
		end else if((vertical_counter==PULSE_V)&&(clk_divider==0)) begin 
			vs <= 1;
		end else if((vertical_counter==0)&&(clk_divider==0)) begin
			vs <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			display_en <= 0;
		end else if((vertical_counter>=PULSE_V+BACK_V)&&(vertical_counter<PULSE_V+BACK_V+HEIGHT)&&(horizontal_counter>=PULSE_H+BACK_H)&&(horizontal_counter<PULSE_H+BACK_H+WIDTH)&&(clk_divider==0)) begin 
			display_en <= 1;
		end else if(clk_divider==0) begin
			display_en <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			y <= 0;
		end else if((horizontal_counter>PULSE_H+BACK_H)&&(horizontal_counter<=PULSE_H+BACK_H+WIDTH)&&(clk_divider==0)) begin 
			y <= y+1;
		end else if(clk_divider==0) begin
			y <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			x <= 0;
		end else if((vertical_counter>=PULSE_V+BACK_V)&&(vertical_counter<PULSE_V+BACK_V+HEIGHT)&&(horizontal_counter==PERIOD_H-1)&&(clk_divider==0)) begin 
			x <= x+1;
		end else if(vertical_counter==PULSE_V+BACK_V-1) begin
			x <= 0;
		end
   	end

	assign x_pos = (display_en==1) ? x:0;
	assign y_pos = (display_en==1) ? y:0;

  //Solution from https://www.xilinx.com/support/answers/44586.html for clog2
  function integer clog2;
    input integer value;
    begin
      value = value-1;
      for (clog2=0; value>0; clog2=clog2+1)
        value = value>>1;
    end
  endfunction


endmodule
