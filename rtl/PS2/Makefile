paddleController:    src/paddleController.v src/PS2.v paddleController_tb.v
	iverilog -o paddleController.out src/paddleController.v src/PS2.v paddleController_tb.v
	./paddleController.out

PS2:    src/PS2.v PS2_tb.v
	iverilog -o PS2.out src/PS2.v PS2_tb.v
	./PS2.out

clean: 
	rm -f paddleController.out *~ *.vcd PS2.out

.PHONY: clean all
