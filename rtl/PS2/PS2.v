//https://www.avrfreaks.net/sites/default/files/PS2%20Keyboard.pdf
`timescale 1ns / 1ps

module PS2(
  input clk,             // Input clock, 50MHz
  input rst,             // Reset signal
  input ps2Clk,          // PS/2 input clock, 10-16.7MHz
  input ps2Data,         // PS/2 data
  output reg [7:0] code, // Code that was detected
  output reg valid       // Whether output data is valid or not
  );

  reg [10:0] counter = 0;
  reg [10:0] dataRead = 0;
  reg [3:0]  bitsReceived = 0;
  reg previousClk = 1;

  // Create signal every clk/1000 (50kHz) in order to verify the PS/2 inputs
  // This signal needs to be greater than 2 x PS/2 clock = 33.4kHz
  always @(posedge clk) begin
    if(rst) begin
      counter <= 0;
      //valid <= 0;
      //code <= 0;
      //bitsReceived <= 0;
    end else if(counter[10])
      counter <= 0;
    else
      counter <= counter + 1;
  end

  always @(posedge clk) begin
    if(counter[10]) begin
      if(!ps2Clk) begin                   // "Data sent from the device to the host is...
        if(ps2Clk != previousClk) begin   // ...read on the falling edge of the clock signal"
          dataRead[10:0] <= {ps2Data, dataRead[10:1]};	// add up the data received by shifting bits and adding one new bit
          bitsReceived <= bitsReceived + 1;
          valid <= 0;
        end
      end else if(bitsReceived == 4'd11) begin   // If the 11 bits of the PS2 data were received
        bitsReceived <= 4'd0;
        // 1 start bit - always 0. 1 parity bit (odd parity). 1 stop bit - always 1
        // The parity bit is set if there is an even number of 1's in the data bits
        // and reset (0) if there is an odd number of 1's in the data bits
        if(!(dataRead[0] || !dataRead[10] || !(dataRead[1] ^ dataRead[2] ^ dataRead[3]
           ^ dataRead[4] ^ dataRead[5] ^ dataRead[6] ^ dataRead[7] ^ dataRead[8]
           ^ dataRead[9]))) begin
          code <= dataRead[8:1];
          valid <= 1;
        end
      end else
	  valid <= 0;
      previousClk <= ps2Clk;
    end
  end

endmodule
