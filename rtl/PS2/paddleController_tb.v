`timescale 1ns / 1ps

module paddleController_tb;

	// Inputs
	reg clk;
	reg ps2Clk;
	reg ps2Data;
	reg rst;

	// Outputs
	wire [8:0] paddle1;
	wire [8:0] paddle2;

	// Instantiate the Unit Under Test (UUT)
	//paddleController #(.START_POS(420), .COUNT(250000)) uut (
	paddleController #(.COUNT(250000)) uut (
		.clk(clk),
		.rst(rst),
		.ps2Clk(ps2Clk),
		.ps2Data(ps2Data),
		.paddle1(paddle1),
		.paddle2(paddle2)
	);

	task oKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //1
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

			#45000 ps2Data = 0; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task lKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask


	task wKey;
		begin
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

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task sKey;
		begin
			#45000 ps2Data = 0; //START 0
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //1
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //2
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //3
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //4
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //5
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //6
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //7
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 0; //8
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1; //PARITY 9
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;

			#45000 ps2Data = 1;// STOP 10
			#5000 ps2Clk = 0;
			#50000 ps2Clk = 1;
		end
	endtask

	task breakCode;
		begin
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
		end
	endtask

	task randKey;
		begin
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

			#45000 ps2Data = 1; //4
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
		end
	endtask

	initial begin
		clk = 1;
		forever begin
		#10 clk = ~clk;
		end
	end

	initial begin
      		$dumpfile("paddleController.vcd");
      		$dumpvars();
		// Initialize Inputs
		ps2Clk = 1;
		ps2Data = 1;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100 rst = 0;

		wKey();
		lKey();
		oKey();
		#6000000;
    		breakCode();
		wKey();
		#1000000;
    		breakCode();
		oKey();
		randKey();
		#16000000;
		$finish;
	end

endmodule
