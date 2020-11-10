`include "PC.v"
`include "InstructionMemory.v"
`include "DataMemory.v"
`include "RegisterFile.v"
`include "ALU.v"
`include "ALUControl.v"
`include "Control.v"
`include "SignExtend.v"
`include "MUX.v"
`include "ShiftLeft2.v"

module CaminhoDeDados (clock, Reset, Prx_PC, ALUResult, Instruction);
  input wire clock, Reset;
  output wire [31:0]Prx_PC, Instruction, ALUResult;
  wire [31:0]ResultPC, Soma;
  wire [31:0]ValSignExtend, Data1, Data2, DataAux, WriteData, ShiftValue, ReadData, PC;
  wire [4:0]WriteReg;
  wire [3:0]ALUCtrl;
  wire Cout, RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, ANDBranch;
  wire [1:0]ALUOp;
  PC CatchPC (.PC(PC), .Reset(Reset), .PC_Next(Prx_PC));
  Sum4 PC4 (.PC(Prx_PC), .Sum(PC));
  InstructionMemory CatchIns (.ReadAddress(Prx_PC), .Instruction(Instruction));
  Control CatchVal (.OpCode(Instruction[31:26]), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ALUOp(ALUOp));
  SignExtend CatchImdEnd (.ImdEnd(Instruction[15:0]), .ValSignExtend(ValSignExtend));
  ALUControl CatchOp (.ALUOp(ALUOp), .Funct(Instruction[5:0]), .ALUCtrl(ALUCtrl));
  MUX1 u1 (.A(Instruction[20:16]), .B(Instruction[15:11]), .Sel(RegDst), .Out(WriteReg));
  RegisterFile Reg (.Read1(Instruction[25:21]), .Read2(Instruction[20:16]), .WriteReg(WriteReg), .WriteData(WriteData), .RegWrite(RegWrite), .Data1(Data1), .Data2(Data2), .clock(clock), .Reset(Reset));
  MUX2 u2 (.A(Data2), .B(ValSignExtend), .Sel(ALUSrc), .Out(DataAux));
  ALU CatchResult (.ALUControl(ALUCtrl), .ReadData1(Data1), .ReadData2(DataAux), .ALUResult(ALUResult), .Zero(Zero));
  ShiftLeft2 CatchBranch (.ValSignExtend(ValSignExtend), .Result(ShiftValue));
  AND CatchBranch1 (.A(Branch), .B(Zero), .Exit(ANDBranch));
  ResultPC CatchPC2 (.A(PC), .B(ShiftValue), .Sum(Soma), .ANDBranch(ANDBranch), .clock(clock));
  DataMemory CatchDat (.MemWrite(MemWrite), .MemRead(MemRead), .Address(ALUResult), .WriteData(Data2), .Result(ReadData), .Reset(Reset), .clock(clock));
  MUX2 u4 (.A(ALUResult), .B(ReadData), .Sel(MemtoReg), .Out(WriteData));
endmodule //
