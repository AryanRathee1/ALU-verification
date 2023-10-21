module Interface(input clk);
  logic [7:0] A, B;
  logic rst, mode;
  logic [3:0] cmd;
  logic [7:0] res = 8'bz;  
  logic [7:0] flag = 8'b0;
  
  // clocking block
  /*clocking drv_cb @(posedge clk);
    output A, B, mode, cmd, rst;
  endclocking;

  clocking mon_cb @(posedge clk);
    input A, B, mode, cmd, flag, res;
  endclocking;*/
  
  modport DRV(output A, B, mode, cmd, rst);
  modport MON(input A, B, mode, cmd, flag, res);

endmodule
