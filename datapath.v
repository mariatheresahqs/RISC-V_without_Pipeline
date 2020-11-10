`include "PC.v"

module datapath (clock, Reset, NextPC, ALUResult, Instruction);
  input wire clock, Reset;
  output wire [31:0]NextPC, Instruction, ALUResult; // instrucoes de saida com 32 bits
  wire [31:0]ResultPC, Sum;
  wire [31:0]SignExtend, Data1, Data2, DataTemp, WriteData, ShiftValue, ReadData, PC;
  wire [4:0]RegWrite;
  wire Count, ANDBranch, Zero;
  wire ALUSrc, MemtoReg, MemWrite, MemRead, RegWrite, Branch;  // instrucoes de controle
  wire [1:0]ALUOp;  // instrucoes de controle
  wire [3:0]ALUCtrl; // temporariamente pra nao esquecer. CHECAR os bits

  PC PC_datapath (.PC(PC), .Reset(Reset), .NextPC(NextPC));
  Sum4 PC_4 (.PC(NextPC), .Sum(PC));
  ResultPC PC_Branch (.PC(PC), .ShiftValue(ShiftValue), .Sum(Sum), .ANDBranch(ANDBranch), .clock(clock));
endmodule //
