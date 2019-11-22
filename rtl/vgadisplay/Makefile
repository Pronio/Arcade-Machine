top:    src/vgacontroller.v vgacontroller_tb.v
	iverilog -o vgacontroller.out src/vgacontroller.v vgacontroller_tb.v
	./vgacontroller.out

clean: 
	rm -f vgacontroller.out *~ *.vcd

.PHONY: clean all
