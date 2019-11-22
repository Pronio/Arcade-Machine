`timescale 1ns / 1ps

module PS2_tb;

	// Inputs
	reg clk;
	reg ps2Clk;
	reg ps2Data;
	reg rst;

	// Outputs
	wire valid;
	wire [7:0] code;

	// Instantiate the Unit Under Test (UUT)
	PS2 uut (
		.clk(clk),
		.rst(rst),
		.ps2Clk(ps2Clk),
		.ps2Data(ps2Data),
		.valid(valid),
		.code(code)
	);

	initial begin
		clk = 1;
		forever begin
		#10 clk = ~clk;
		end
	end

	initial begin
      		$dumpfile("PS2.vcd");
      		$dumpvars();
		// Initialize Inputs
		ps2Clk = 1;
		ps2Data = 1;
		#5
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100 rst = 0;

    #45000 ps2Data = 0; //START 0
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //1
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //2
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //3
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //4
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //5
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //6
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //7
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //8
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //PARITY 9
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1;// STOP 10
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;
		// Add stimulus here

		#45000 ps2Data = 0; //START 0
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //1
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //2
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //3
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 0; //4
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //5
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //6
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //7
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //8
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1; //PARITY 9
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;

		#45000 ps2Data = 1;// STOP 10
		#5000 ps2Clk = 0;
		#50000 ps2Clk = 1;


	//BREAK CODE

	#45000 ps2Data = 0; //START 0
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 1; //1
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 0; //2
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 1; //3
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 0; //4
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 1; //5
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 1; //6
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 1; //7
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 0; //8
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 0; //PARITY 9
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;

	#45000 ps2Data = 1;// STOP 10
	#5000 ps2Clk = 0;
	#50000 ps2Clk = 1;
	
		// #45000 ps2Data = 0; //START 0
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 1; //1
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 0; //2
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 1; //3
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 0; //4
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 1; //5
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 1; //6
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 1; //7
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 0; //8
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 0; //PARITY 9
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		//
		// #45000 ps2Data = 1;// STOP 10
		// #5000 ps2Clk = 0;
		// #50000 ps2Clk = 1;
		#100000;
		$finish;
	end

endmodule
