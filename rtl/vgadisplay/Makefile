vgadisplay:    src/vgadisplay.v src/frame_detection.v src/vgacontroller.v src/object_detection.v vgadisplay_tb.v
	iverilog -o vgadisplay.out src/vgadisplay.v src/frame_detection.v src/vgacontroller.v src/object_detection.v vgadisplay_tb.v
	./vgadisplay.out

vgacontroller:    src/vgacontroller.v vgacontroller_tb.v
	iverilog -o vgacontroller.out src/vgacontroller.v vgacontroller_tb.v
	./vgacontroller.out

object_detection:    src/object_detection.v object_detection_tb.v
	iverilog -o object_detection.out src/object_detection.v object_detection_tb.v
	./object_detection.out

frame_detection:    src/frame_detection.v frame_detection_tb.v
	iverilog -o frame_detection.out src/frame_detection.v frame_detection_tb.v
	./frame_detection.out

clean: 
	rm -f vgacontroller.out *~ *.vcd object_detection.out frame_detection.out vgadisplay.out

.PHONY: clean all
