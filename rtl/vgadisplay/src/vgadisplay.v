`timescale 1ns/1ps

module vgadisplay
  // Parameters to set screen output (VGA)
	#(parameter WIDTH = 640, //Standard screen width is 640ppx
		parameter HEIGHT = 480 //Standard screen height is 480px
	)(
	input			 clk,
	input			 rst,
	input			 sel,
	input  [1:0] 	 addr,
	input  [9:0]   	 data_in,
	output reg		 HS,
	output reg		 VS,
	output reg [2:0] red,
	output reg [2:0] green,
	output reg [1:0] blue
);

	wire [8:0] x_pos;
	wire [9:0] y_pos;
	wire [4:0] detected;
	wire display_en;
	wire hs_1;
	wire vs_1;

	reg [8:0] ball_x;
	reg [9:0] ball_y;
	reg [8:0] paddle_1;
	reg [8:0] paddle_2;

	reg [8:0] ball_x_1;
	reg [9:0] ball_y_1;
	reg [8:0] paddle_1_1;
	reg [8:0] paddle_2_1;

	//Object positon registers connected to data bus, waiting to enter the main object postion registers
	always @ (posedge clk)
	begin
		if (rst)
			ball_x_1<=0;
		else if(sel&&(addr==2'b00))
			ball_x_1<=data_in[8:0];
   	end

	always @ (posedge clk)
	begin
		if (rst)
			ball_y_1<=0;
		else if(sel&&(addr==2'b01))
			ball_y_1<=data_in[9:0];
   	end

	always @ (posedge clk)
	begin
		if (rst)
			paddle_1_1<=0;
		else if(sel&&(addr==2'b10))
			paddle_1_1<=data_in[8:0];
   	end

	always @ (posedge clk)
	begin
		if (rst)
			paddle_2_1<=0;
		else if(sel&&(addr==2'b11))
			paddle_2_1<=data_in[8:0];
   	end

	//Main object postion registers
	always @ (posedge clk)
	begin
		if (rst) begin
			ball_x<=0;
			ball_y<=0;
			paddle_1<=0;
			paddle_2<=0;
		end else if((x_pos == HEIGHT - 1)&&(y_pos == WIDTH - 1)) begin
			ball_x<=ball_x_1;
			ball_y<=ball_y_1;
			paddle_1<=paddle_1_1;
			paddle_2<=paddle_2_1;
		end
   	end

	vgacontroller controller (
		.clk(clk),
		.rst(rst),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.display_en(display_en),
		.hs(hs_1),
    .vs(vs_1)
		);

	object_detection ball (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(ball_x),
		.Py(ball_y),
		.W(10'd10),
		.H(9'd10),
    .detected(detected[4])
		);

	object_detection paddle1 (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(paddle_1),
		.Py(10'd30),
		.W(10'd10),
		.H(9'd40),
    .detected(detected[3])
		);

	object_detection paddle2 (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(paddle_2),
		.Py(10'd600),
		.W(10'd10),
		.H(9'd40),
    .detected(detected[2])
		);

	object_detection middle_line (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(9'd0),
		.Py(10'd317),
		.W(10'd6),
		.H(HEIGHT),
    .detected(detected[1])
		);

	frame_detection frame (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.W(6'd10),
    .detected(detected[0])
		);

	always @ (posedge clk)
	begin
		if (rst)
			HS<=0;
<<<<<<< HEAD
		else
			HS=hs_1;
=======
		else 
			HS<=hs_1;
>>>>>>> bcaa00bcba6f32c00ee36eb552f7cd58ef2cd697
   	end

	always @ (posedge clk)
	begin
		if (rst)
			VS<=0;
<<<<<<< HEAD
		else
			VS=vs_1;
=======
		else 
			VS<=vs_1;
>>>>>>> bcaa00bcba6f32c00ee36eb552f7cd58ef2cd697
   	end


always @ (posedge clk)
	begin
		if ((detected[4])&&display_en) begin
			red <= 3'b110;
			green <= 3'b000;
			blue <= 2'b00;
		end else if ((detected[3])&&display_en) begin
			red <= 3'b000;
			green <= 3'b000;
			blue <= 2'b11;
		end else if ((detected[2])&&display_en) begin
			red <= 3'b000;
			green <= 3'b000;
			blue <= 2'b11;
		end else if ((detected[1])&&display_en) begin
			red <= 3'b011;
			green <= 3'b011;
			blue <= 2'b01;
		end else if ((detected[0])&&display_en) begin
			red <= 3'b011;
			green <= 3'b011;
			blue <= 2'b01;
		end else begin
			red <= 3'b000;
			green <= 3'b000;
			blue <= 2'b00;
		end
   	end

endmodule
