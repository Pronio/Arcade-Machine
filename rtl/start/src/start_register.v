`timescale 1ns/1ps

module start_register(
	input clk,
	input rst,
	input button,
	output reg start 
); 

	always @ (posedge clk)
	begin
		if (rst)
			start<=0;
		else
			start<=button;
   	end

endmodule
