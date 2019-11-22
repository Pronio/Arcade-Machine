`timescale 1ns/1ps

module vgacontroller (
	input		 clk,
	input		 rst,
	output [8:0] 	 x_pos,
	output [9:0] 	 y_pos,
	output reg	 display_en,
	output reg	 hs,
	output reg	 vs
); 

	reg clk_divider;
	reg [9:0] vertical_counter;
	reg [9:0] horizontal_counter;
	reg [8:0] x;
	reg [9:0] y;

	always @ (posedge clk) 
	begin
		if (rst) begin
			clk_divider<= 0;
		end else begin 
			clk_divider<= ~clk_divider;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			horizontal_counter<= 0;
		end else if((clk_divider==0)&&(horizontal_counter==800)) begin 
			horizontal_counter<= 0;
		end else if(clk_divider==0) begin 
			horizontal_counter<= horizontal_counter+1;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			vertical_counter<= 0;
		end else if((horizontal_counter==800)&&(vertical_counter==521)) begin 
			vertical_counter<= 0;
		end else if((horizontal_counter==800)&&(clk_divider==0)) begin 
			vertical_counter<= vertical_counter+1;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			hs <= 0;
		end else if((horizontal_counter==96)&&(clk_divider==0)) begin 
			hs <= 1;
		end else if((horizontal_counter==0)&&(clk_divider==0)) begin
			hs <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			vs <= 0;
		end else if((vertical_counter==2)&&(clk_divider==0)) begin 
			vs <= 1;
		end else if((vertical_counter==0)&&(clk_divider==0)) begin
			vs <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			display_en <= 0;
		end else if((vertical_counter>=31)&&(vertical_counter<511)&&(horizontal_counter>=144)&&(horizontal_counter<784)&&(clk_divider==0)) begin 
			display_en <= 1;
		end else if(clk_divider==0) begin
			display_en <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			y <= 0;
		end else if((horizontal_counter>144)&&(horizontal_counter<=784)&&(clk_divider==0)) begin 
			y <= y+1;
		end else if(clk_divider==0) begin
			y <= 0;
		end
   	end

	always @ (posedge clk) 
	begin
		if (rst) begin
			x <= 0;
		end else if((vertical_counter>=31)&&(vertical_counter<511)&&(horizontal_counter==800)&&(clk_divider==0)) begin 
			x <= x+1;
		end else if(vertical_counter==30) begin
			x <= 0;
		end
   	end

	assign x_pos = (display_en==1) ? x:0;
	assign y_pos = (display_en==1) ? y:0;


endmodule
