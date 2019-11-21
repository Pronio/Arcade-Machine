`timescale 1ns / 1ps

module paddleController
  // Parameter dimensions to set paddles motion are in pixels
  #(parameter SCREEN_HEIGHT = 480, // Total screen height, in pixels
  parameter PADDLE_LENGTH = 40,    // Total length of each one of the paddles
  parameter START_POS = (SCREEN_HEIGHT - PADDLE_LENGTH)/2, //Starting position of the paddles
  parameter FRAME_WIDTH = 10,      // Size of the border
  parameter MOTION_STEP = 10,      // How many pixels the paddle move each time
  parameter BOTTOM_POS = SCREEN_HEIGHT - (PADDLE_LENGTH + FRAME_WIDTH), // Bottom limit to where paddle can go
  parameter COUNT = 500000) ( // Value used in a counter, in order to create a signal, default is every 10ms
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
  reg [15 : 0] resetCounter = 0;
  reg breakCode = 0;
  reg incPaddle1, decPaddle1; // Incremente or decrease Paddle 1 position
  reg incPaddle2, decPaddle2; // Incremente or decrease Paddle 2 position
  wire [7 : 0] code;
  wire valid;

  wire [7:0] BREAK_CODE = 8'hF0; // Break code
  // Player 1 keys
  wire [7:0] W = 8'h1D;	         // Q key code
  wire [7:0] S = 8'h1B;          // S key code
  // Player 2 keys
  wire [7:0] O = 8'h44;	         // O key code
  wire [7:0] L = 8'h4B;          // L key code

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
    if(rst)   // Reset to default values
      counter <= 0;
    else if(counter == COUNT)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  // Reset counter for when a break code is recieved but if in a given time
  // the rest of the code is not received, reset breakCode
  always @(posedge clk) begin
    if(rst)   // Reset to default values
      resetCounter <= 0;
    else if(resetCounter[15])
      resetCounter <= 0;
    else
      resetCounter <= resetCounter + 1;
  end

  //check if a new code has been outputted by the PS2 module
  always @(posedge clk) begin
    if(rst) begin   // Reset to default value
      breakCode <= 0;
      incPaddle1 <= 0;
      decPaddle1 <= 0;
      incPaddle2 <= 0;
      incPaddle2 <= 0;
    end else if(resetCounter[15])
      breakCode <= 0;
    end else if(valid) begin
      if(code == BREAK_CODE)
        breakCode <= 1;
      else if(code == W) begin
        if(breakCode) begin
          breakCode <= 0;
          incPaddle1 <= 0;
        end else begin
          incPaddle1 <= 1;
          decPaddle1 <= 0;
        end
      end else if(code == S) begin
        if(breakCode) begin
          breakCode <= 0;
          decPaddle1 <= 0;
        end else begin
          incPaddle1 <= 0;
          decPaddle1 <= 1;
        end
      end else if(code == O) begin
        if(breakCode) begin
          breakCode <= 0;
          incPaddle2 <= 0;
        end else begin
          incPaddle2 <= 1;
          decPaddle2 <= 0;
        end
      end else if(code == L) begin
        if(breakCode) begin
          breakCode <= 0;
          decPaddle2 <= 0;
        end else begin
          incPaddle2 <= 0;
          decPaddle2 <= 1;
        end
      end
    end
  end

  // Increment/Decrease Paddle positions depending on the keys that are pressed
  always @(posedge clk) begin
    if(rst) begin   // Reset to default values
      paddle1 <= START_POS;
      paddle2 <= START_POS;
    end else if(counter == COUNT) begin
      if(incPaddle1) begin
        if(paddle1 + MOTION_STEP <= BOTTOM_POS)
          paddle1 <= paddle1 + MOTION_STEP;
      end else if(decPaddle1) begin
        if(paddle1 - MOTION_STEP >= FRAME_WIDTH)
          paddle1 <= paddle1 - MOTION_STEP;
      end else if(incPaddle2) begin
        if(paddle2 + MOTION_STEP <= BOTTOM_POS)
          paddle2 <= paddle2 + MOTION_STEP;
      end else if(decPaddle2) begin
        if(paddle2 - MOTION_STEP >= FRAME_WIDTH)
          paddle2 <= paddle2 - MOTION_STEP;
      end
    end
  end

  endmodule
