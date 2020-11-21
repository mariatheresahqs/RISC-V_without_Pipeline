`timescale 1ns / 100ps
`include "datapath.v"

module testbench ();
  reg clk, reset;
  wire [63:0]PC, ALUResult; // Mostrar apenas as 32 bits
  wire [31:0]instruction;
  wire [4:0]ReadReg1, ReadReg2, RegWrite;
  //wire [4:0]ReadData1, ReadData2, WriteData;

  datapath Call (.clk(clk), .reset(reset), .nextPC(PC), .ALUResult(ALUResult), .instruction(instruction));

  initial begin
    $dumpfile("datapath.vcd");
    $dumpvars(0, testbench);
    $display("Exibindo os resultados:");
    clk = 0;
    #1; $monitor("Instruction: %b\nExit PC: %b\nExit ALU: %b\n",instruction, PC, ALUResult);
    #1; $monitor("ReadReg1: %b\nReadReg2: %b\nRegWrite: %b\n",ReadReg1, ReadReg2, RegWrite);

    #300000 $finish;
  end

  always begin
    #10 clk = ~clk;
  end

/*  initial begin
    #1; clk = 0;
    #1; clk = 1; reset = 1;
    #1; clk = 0;
    #1; clk = 1; reset = 0;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1;
    #1; clk = 0;
    #1; clk = 1; reset = 1;
    #1; clk = 0; reset = 0;
    #1;
    $finish;
  end
  */

endmodule //

