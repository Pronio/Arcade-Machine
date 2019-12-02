`include "xdefs.vh"
`timescale 1ns / 1ps

module xaddr_decoder (
	             // address and global select signal
	              input [`ADDR_W-1:0] addr,
                      input               sel,
             
                      // ports

                      //memory
	              output reg          mem_sel,
                      input [31:0]        mem_data_to_rd,

	              output reg          regf_sel,
                      input [31:0]        regf_data_to_rd,
		      
		      input [8:0]         paddle1,
                      input [8:0]         paddle2,

`ifdef DEBUG	
	              output reg          cprt_sel,
`endif

`ifndef NO_EXT
                      output reg          ext_sel,
                      input [31:0]        ext_data_to_rd,
`endif
                      
                      output reg          score_sel,

                      output reg          object_sel,

                      output reg          trap_sel,

                      //read port
                      output reg [31:0]   data_to_rd
                     );

    reg paddle1_sel;
    reg paddle2_sel;

   
   //select module
   always @* begin
      mem_sel = 1'b0;
      regf_sel = 1'b0;
`ifdef DEBUG
      cprt_sel = 1'b0;
`endif
`ifndef NO_EXT
      ext_sel = 1'b0;
`endif
      trap_sel = 1'b0;
      score_sel = 1'b0;
      paddle1_sel = 1'b0;
      paddle2_sel = 1'b0;
      object_sel = 1'b0;

      //mask offset and compare with base
      if ( (addr & {  {`ADDR_W-`MEM_ADDR_W{1'b1}}, {`MEM_ADDR_W{1'b0}}  }) == `MEM_BASE)
        mem_sel = sel;
      else if ( (addr & {  {`ADDR_W-`REGF_ADDR_W{1'b1}}, {`REGF_ADDR_W{1'b0}}  }) == `REGF_BASE)
        regf_sel = sel;
`ifdef DEBUG
      else if ( (addr &  {  {`ADDR_W-`CPRT_ADDR_W{1'b1}}, {`CPRT_ADDR_W{1'b0}}  }) == `CPRT_BASE)
        cprt_sel = sel;
 `endif
      else if ( (addr &  {  {`ADDR_W-`SCORE_ADDR_W{1'b1}}, {`SCORE_ADDR_W{1'b0}}  }) == `SCORE_BASE)
        score_sel = sel;
      else if ( (addr &  {  {`ADDR_W-`PADDLE_ADDR_W{1'b1}}, {`PADDLE_ADDR_W{1'b1}}  }) == `PADDLE_BASE)
        paddle1_sel = sel;
      else if ( (addr &  {  {`ADDR_W-`PADDLE_ADDR_W{1'b1}}, {`PADDLE_ADDR_W{1'b1}}  }) == `PADDLE_BASE+1)
        paddle2_sel = sel; 
      else if ( (addr &  {  {`ADDR_W-`OBJECT_ADDR_W{1'b1}}, {`OBJECT_ADDR_W{1'b0}}  }) == `OBJECT_BASE)
        object_sel = sel; 
      else
          trap_sel = sel;
   end

   //select data to read
   always @(*) begin
      data_to_rd = `DATA_W'd0;

      if(mem_sel)
        data_to_rd = mem_data_to_rd;
      else if(regf_sel)
        data_to_rd = regf_data_to_rd;
      else if(paddle1_sel)
	data_to_rd = {23'b0,paddle1};
      else if(paddle2_sel)
	data_to_rd = {23'b0,paddle2};
`ifndef NO_EXT
      else if(ext_sel)
        data_to_rd = ext_data_to_rd;
`endif
   end

endmodule
