`timescale 1ns/1ps

module vgadisplay
  // Parameters to set screen output (VGA)
	#(parameter WIDTH = 640, //Standard screen width is 640ppx
		parameter HEIGHT = 480, //Standard screen height is 480px
		parameter X_BIT=8,
		parameter Y_BIT=9
	)(
	input			 clk,
	input			 rst,
	input			 sel,
	input  [1:0] 	 addr,
	input  [Y_BIT:0]   	 data_in,
	output reg		 HS,
	output reg		 VS,
	output reg [2:0] red,
	output reg [2:0] green,
	output reg [1:0] blue
);

	wire [X_BIT:0] x_pos;
	wire [Y_BIT:0] y_pos;
	wire [4:0] detected;
	wire display_en;
	wire hs_1;
	wire vs_1;

	reg [X_BIT:0] ball_x;
	reg [Y_BIT:0] ball_y;
	reg [X_BIT:0] paddle_1;
	reg [X_BIT:0] paddle_2;

	reg [X_BIT:0] ball_x_1;
	reg [Y_BIT:0] ball_y_1;
	reg [X_BIT:0] paddle_1_1;
	reg [X_BIT:0] paddle_2_1;

	//Object positon registers connected to data bus, waiting to enter the main object postion registers
	always @ (posedge clk)
	begin
		if (rst)
			ball_x_1<=0;
		else if(sel&&(addr==2'b00))
			ball_x_1<=data_in[X_BIT:0];
   	end

	always @ (posedge clk)
	begin
		if (rst)
			ball_y_1<=0;
		else if(sel&&(addr==2'b01))
			ball_y_1<=data_in[Y_BIT:0];
   	end

	always @ (posedge clk)
	begin
		if (rst)
			paddle_1_1<=0;
		else if(sel&&(addr==2'b10))
			paddle_1_1<=data_in[X_BIT:0];
   	end

	always @ (posedge clk)
	begin
		if (rst)
			paddle_2_1<=0;
		else if(sel&&(addr==2'b11))
			paddle_2_1<=data_in[X_BIT:0];
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

	vgacontroller #( 
		.HEIGHT(HEIGHT),
		.WIDTH(WIDTH)
		//,.PERIOD_H(1040),
		//.PULSE_H(120),
		//.BACK_H(64),
		//.PERIOD_V(666),
		//.PULSE_V(6),
		//.BACK_V(23)
		) controller (
		.clk(clk),
		.rst(rst),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.display_en(display_en),
		.hs(hs_1),
    	.vs(vs_1)
		);

	object_detection #(.X_BITS(X_BIT), .Y_BITS(Y_BIT) ) ball (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(ball_x),
		.Py(ball_y),
		.W(10'd10),
		.H(9'd10),
    		.detected(detected[4])
		);

	object_detection #(.X_BITS(X_BIT), .Y_BITS(Y_BIT) ) paddle1 (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(paddle_1),
		.Py(10'd30),
		.W(10'd10),
		.H(9'd80),
    		.detected(detected[3])
		);

	object_detection #(.X_BITS(X_BIT), .Y_BITS(Y_BIT) ) paddle2 (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(paddle_2),
		.Py(10'd600),
		.W(10'd10),
		.H(9'd80),
    		.detected(detected[2])
		);

	object_detection #(.X_BITS(X_BIT), .Y_BITS(Y_BIT) ) middle_line (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.Px(9'd0),
		.Py(10'd317),
		.W(10'd6),
		.H(HEIGHT),
    		.detected(detected[1])
		);

	frame_detection #(
		.X_BITS(X_BIT), 
		.Y_BITS(Y_BIT),
		.WIDTH(WIDTH),
		.HEIGHT(HEIGHT) 
		) frame (
		.x_pos(x_pos),
		.y_pos(y_pos),
		.W(6'd10),
    		.detected(detected[0])
		);

	always @ (posedge clk)
	begin
		if (rst)
			HS<=0;
		else
			HS<=hs_1;
   	end

	always @ (posedge clk)
	begin
		if (rst)
			VS<=0;
		else
			VS<=vs_1;
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
