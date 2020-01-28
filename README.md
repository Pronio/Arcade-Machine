# Arcade-Machine
Arcade Machine is a hardware architecture designed to implement the well know game - Pong - in verilog, which will be developed to be deployed in the Digilent Basys2 board. The players make use of four buttons in a PS/2 Keyboard in order to control the position of the rackets. The game is displayed in a monitor using VGA output. Also, the score of the game is displayed in a seven segment display. Additionaly, two buttons are used to start the game and reset it. 

For this project, the picoVersat - minimal hardware controller - will be used as a state machine. Specialized hardware will be created to handle the PS/2, the VGA and the seven segment display interfaces.

## Project Structure

````
.
├── docs
|   └── Initial User Guide
|   |   └──Arcade_Machine_Initial_User_Guide.pdf    #User Manual before development of Arcade Machine
│   └── Arcade_Machine_User_Guide.pdf     # User Manual
├── picoversat
│   ├── fpga                          
│   │   └── xilinx
│   │       └── 14.7
│   │           └── picoversat
│   │               ├── picoversat.xise   # xilinx ISE executable
│   │               └── ...
│   ├── rtl                             
│   │   ├── include
│   │   │   └── xdefs.vh                  # Header file with constants and parameters
│   │   ├── src
│   │   │   ├── xtop.v                    # Top module design
│   │   │   └── ...
│   │   └── testbench
│   │       ├── xtop_tb.v                 # Top module testbench
│   │       └── ...
│   ├── simulation
│   │   ├── icarus
│   │   │   ├── program.hex               # Compiled program to be loaded into HW mem
│   │   │   ├── xtop.vcd                  # Top module simulation output file
│   │   │   └── ...
│   │   └── ...
│   ├── tests                             
│   │   ├── test_am3
│   │   │   ├── program.hex               # Compiled program to be loaded into HW mem
│   │   │   ├── program.va                # Assembly Code to be run on PicoVersat core
│   │   │   └── ...
│   │   └── ...
│   └── Makefile                          # Makefile used to simulate Top module
├── rtl
│   ├── 7segdisplay
│   │   ├── src
│   │   │   └── 7segDisplay.v             # 7segDisplay module design
│   │   ├── 7segDisplay.vcd               # 7segDisplay module simulation output 
│   │   ├── 7segDisplay_tb.v              # 7segDisplay module testbench
│   │   ├── Makefile                      # Makefile used to simulate 7segDisplay module
│   │   └── ...
│   ├── PS2
│   │   ├── src
│   │   │   ├── paddleController.v        # paddleController module design
│   │   │   └── PS2.v                     # PS2 controller module design
│   │   ├── paddleController.vcd          # paddleController module simulation output 
│   │   ├── paddleController_tb.v         # paddleController module testbench
│   │   ├── PS2_tb.v                      # PS2 module testbench
│   │   ├── Makefile                      # Makefile used to simulate PS2 module
│   │   └── ...
│   ├── start
│   │   └── src
│   │       └── start_register.v          # start_register module design
│   └── vgadisplay
│       ├── src
│       │   ├── frame_detection.v         # frame_detection module design
│       │   ├── object_detection.v        # object_detection module design
│       │   ├── vgacontroller.v           # vgacontroller module design
│       │   └── vgadisplay.v              # vgadisplay module design
│       ├── vgadisplay.vcd                # vgadisplay module simulation output 
│       ├── vgadisplay_tb.v               # vgadisplay module testbench
│       ├── vgacontroller_tb.v            # vgacontroller module testbench
│       ├── object_detection_tb.v         # object_detection module testbench
│       ├── frame_detection_tb.v          # frame_detection module testbench
│       ├── Makefile                      # Makefile used to simulate vgadisplay module
│       └── ...
└── README.md                             # This file
````
All the peripheral hardware interface modules were developed in `rtl` directory, these were used in the PicoVersat top model, which corresponds to the top model of the project itself. The top model is located in `picoversat/rtl/src` directory in a file called `xtop.v`.

## How to simulate

To simulate peripheral hardware interface modules, go to the peripheral directory given by `rtl/<name_of_peripheral>` and execute the Makefile, the simulation output file has `.vcd` extension and will be located in the same directory of the makefile.

To simulate the top model, this is the Arcade Machine as a whole just go to `picoversat` directory and do:

```
make icarus test=test_am3
```

The simulation output file will be located in `picoversat/simulation/icarus` directory.

## How to implement

It is required to have Xilinx ISE 14.7 installed. Just open the `picoversat.xise` located in `picoversat/fpga/xilinx/14.7/picoversat` and generate programming file.
