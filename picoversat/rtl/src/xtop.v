`timescale 1ns / 1ps
`include "xdefs.vh"


module xtop (
	     input                clk,
	     input                rst,
             output               trap

`ifndef NO_EXT
	     // external parallel interface
	     , output [`ADDR_W-2:0] par_addr,
	     input [`DATA_W-1:0]  par_in,
             output               par_re, 
	     output [`DATA_W-1:0] par_out,
	     output               par_we
`endif

	     , output [3:0]	  an,
	     output [6:0]	  seg,
	     input                PS2C,
	     input                PS2D,
	     output 		  dp
	     );

   //
   //
   // CONNECTION WIRES
   //
   //
   
   // INSTRUCTION MEMORY INTERFACE
   wire [`INSTR_W-1:0] 		  instruction;
   wire [`ADDR_W-2:0]             pc;

   // DATA BUS
   wire 			  data_sel;
   wire 			  data_we;
   wire [`ADDR_W-1:0] 		  data_addr;
   wire [`DATA_W-1:0] 		  data_to_rd;
   wire [`DATA_W-1:0] 		  data_to_wr;

   
   // ADDRESS DECODER
   wire                           mem_sel;
   wire [`DATA_W-1:0] 		  mem_data_to_rd;
   
   wire				  regf_sel;
   wire [`DATA_W-1:0] 		  regf_data_to_rd;

   
`ifdef DEBUG
   reg 				  cprt_sel;
`endif

   wire				  score_sel;

`ifndef NO_EXT
   wire                           ext_sel;
   wire [`DATA_W-1:0]             ext_data_to_rd = par_in;


   
   //External interface
   assign par_addr = data_addr[`ADDR_W-2:0];
   assign par_re = ext_sel & ~data_we;
   assign par_out = data_to_wr;
   assign par_we = ext_sel & data_we;
`endif

   //Auxiliar
   wire				  rst_out;
   wire [7:0]			  cathode_aux;
   wire 			  valid;

   assign dp = cathode_aux[7];
   assign seg = cathode_aux[6:0];
 
   
   
   //
   // CONTROLLER MODULE
   //
   xctrl controller (
		     .clk(clk), 
		     .rst(rst),
		     
		     // Program memory interface
		     .pc(pc),
		     .instruction(instruction),
		     
		     // mem data bus
		     .mem_sel(data_sel),
		     .mem_we (data_we), 
		     .mem_addr(data_addr),
		     .mem_data_from(data_to_rd), 
		     .mem_data_to(data_to_wr)
		     );

   // MEMORY MODULE
   xram ram (
	       .clk(clk),

	       // instruction interface
	       .pc(pc),
       	       .instruction(instruction),

	       //data interface 
	       .data_sel(mem_sel),
	       .data_we(data_we),
	       .data_addr(data_addr[`ADDR_W-2 : 0]),
	       .data_in(data_to_wr),
	       .data_out(mem_data_to_rd)
	       );


   // REGISTER FILE
   xregf regf (
	       .clk(clk),
	       .sel(regf_sel),
	       .we(data_we),
	       .addr(data_addr[`REGF_ADDR_W-1:0]),
	       .data_in(data_to_wr),
	       .data_out(regf_data_to_rd)
	       );

   // INTERNAL ADDRESS DECODER

   xaddr_decoder addr_decoder (
	                       // input select and address
                               .sel(data_sel),
	                       .addr(data_addr),

			       .valid(valid),
                               
                               //memory 
	                       .mem_sel(mem_sel),
                               .mem_data_to_rd(mem_data_to_rd),

                               //registers
	                       .regf_sel(regf_sel),
                               .regf_data_to_rd(regf_data_to_rd),
`ifdef DEBUG
                               //debug char printer
	                       .cprt_sel(cprt_sel),
`endif

`ifndef NO_EXT
                               //external
                               .ext_sel(ext_sel),
                               .ext_data_to_rd(ext_data_to_rd),
`endif

                               //trap
                               .trap_sel(trap),
                               
                               //data output 
                               .data_to_rd(data_to_rd),

			       .score_sel(score_sel)
                               );
   
   //
   //
   // USER MODULES INSERTED BELOW
   //
   //

   segDisplay segment (
		   .clk(clk),
		   .rst(rst),
		   .sel(score_sel & data_we),
		   .addr(data_addr[`SCORE_ADDR_W-1:0]),
		   .data_in(data_to_wr[0]),
		   .cathode(cathode_aux),
		   .anode(an),
		   .rst_out(rst_out)
		   );

	PS2 keyboard(
  		.clk(clk),             // Input clock, 50MHz
  		.rst(rst),             // Reset signal
  		.ps2Clk(PS2C),          // PS/2 input clock, 10-16.7MHz
  		.ps2Data(PS2D),         // PS/2 data
  		.code(), // Code that was detected
  		.valid(valid)       // Whether output data is valid or not
  	);



   
`ifdef DEBUG
   xcprint cprint (
		   .clk(clk),
		   .sel(cprt_sel & data_we),
		   .data_in(data_to_wr[7:0])
		   );
`endif
   
endmodule
