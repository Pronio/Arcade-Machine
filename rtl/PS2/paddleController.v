`timescale 1ns / 1ps

module paddleController
  // Parameter dimensions to set paddles motion are in pixels
  #(parameter SCREEN_HEIGHT = 480, // Total screen height, in pixels
  parameter PADDLE_LENGTH = 40,    // Total length of each one of the paddles
  parameter START_POS = (SCREEN_HEIGHT - PADDLE_LENGTH)/2, //Starting position of the paddles
  parameter FRAME_WIDTH = 10,      // Size of the border
  parameter MOTION_STEP = 10,      // How many pixels the paddle move each time
  parameter BOTTOM_POS = SCREEN_HEIGHT - (PADDLE_LENGTH + FRAME_WIDTH), // Bottom limit to where paddle can go
  parameter COUNT = 1000) ( // Value used in a counter, in order to create a signal
                            // in a certain time in order to increase/decrease
                            // paddle positions
  input clk,             // Input clock, 50MHz
  input rst,             // Reset signal
  input ps2Clk,          // PS/2 input clock, 10-16.7MHz
  input ps2Data,         // PS/2 data
  output reg [$clog2(BOTTOM_POS)-1 : 0] paddle1, // Position in each the Paddle 1 is
  output reg [$clog2(BOTTOM_POS)-1 : 0] paddle2  // Position in each the Paddle 2 is
  );

  reg [$clog2(COUNT) : 0] counter = 0;
  reg breakCode;
  wire [7 : 0] code;
  wire valid;

  wire [7:0] BREAK_CODE = 8'hF0; // Break code
  // Player 1 keys
  wire [7:0] W = 8'h1D;	         // Q key code
  wire [7:0] S = 8'h1B;          // S key code
  // Player 2 keys
  wire [7:0] O = 8'h44;	         // O key code
  wire [7:0] L = 8'h4B;          // L key code

  //wire [7:0] ARROW_LEFT = 8'h6B;
  //wire [7:0] ARROW_RIGHT = 8'h74;
  //wire [7:0] EXTENDED = 8'hE0;	//codes
  //wire [7:0] RELEASED = 8'hF0;

  PS2 keyboard (
    .clk(clk),
    .rst(rst),
    .ps2Clk(ps2Clk),
    .ps2Data(ps2Data),
    .code(code),
    .valid(valid)
  );

  // Create signal every clk/COUNT in order to increment/decrement paddle positions
  always @(posedge clk) begin
    if(rst) begin
      counter <= 0;
      paddle1 <= START_POS;
      paddle2 <= START_POS;
    end else if(counter == COUNT)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  //check if a new code has been outputted by the PS2 module
  always @(posedge clk) begin
    if(valid) begin

    end
  end

  endmodule
