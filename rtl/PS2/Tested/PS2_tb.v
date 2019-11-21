`timescale 1ns / 1ps

module PS2_tb;

	// Inputs
	reg clk;
	reg ps2Clk;
	reg ps2Data;

	// Outputs
	wire valid;
	wire [7:0] code;

	// Instantiate the Unit Under Test (UUT)
	PS2 uut (
		.clk(clk),
		.ps2Clk(ps2Clk),
		.ps2Data(ps2Data),
		.valid(valid),
		.code(code)
	);

	initial begin
		clk = 1;
		forever begin
		#1 clk = ~clk;
		end
	end

	initial begin
      		$dumpfile("top.vcd");
      		$dumpvars();
		// Initialize Inputs
		ps2Clk = 1;
		ps2Data = 1;

		// Wait 100 ns for global reset to finish
		#100;

      		#45 ps2Data = 0; //START 0
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //1
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //2
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //3
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //4
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //5
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //6
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //7
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //8
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //PARITY 9
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1;// STOP 10
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;
		// Add stimulus here

		#45 ps2Data = 0; //START 0
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //1
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //2
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //3
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //4
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //5
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //6
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //7
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //8
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //PARITY 9
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1;// STOP 10
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;
	//BRAKE CODE
		#45 ps2Data = 0; //START 0
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //1
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //2
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //3
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //4
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //5
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //6
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1; //7
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //8
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 0; //PARITY 9
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;

		#45 ps2Data = 1;// STOP 10
		#5 ps2Clk = 0;
		#50 ps2Clk = 1;
		#500;
		$finish;
	end

endmodule
