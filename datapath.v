`include "ALU.v"
`include "PC.v"
`include "InstructionMemory.v"
`include "Control.v"
`include "DataMemory.v"
`include "Registers.v"
`include "SignExtend.v"
`include "ALUControl.v"

module datapath (clk, reset, nextPC, ALUResult, instruction);
  input wire clk, reset;
  output wire [63:0]nextPC, ALUResult; // Alterar tamanho da instrucao ao imprimir
  output wire[31:0]instruction;
  wire [63:0]resultPC, sum, muxResult, muxDataResult;
  wire [63:0]signExtend, ReadData1, ReadData2, DataTemp, WriteData, shiftValue, ReadData, PC;
  wire [4:0]WriteReg;
  wire ANDBranch, Zero, ANDResult;
  wire ALUSrc, MemtoReg, MemWrite, MemRead, RegWrite, Branch;  // instrucoes de controle
  wire [1:0]ALUOp; // instrucoes de controle
  wire [3:0]ALUCtrl; 

  //-----------------------------------------------------------------
  // Program Counter Modules
  //-----------------------------------------------------------------
  //PC PC_datapath (.PC(PC), .reset(reset), .nextPC(nextPC));
  //Sum4 PC_4 (.PC(nextPC), .sum(PC));
  ResultPC PC_Branch (.PC(nextPC), .shiftValue(shiftValue), .sum(nextPC), .ANDBranch(1'b0), .clk(clk));
  ShiftLeft ImmShiftedOneLeft (.signExtend(signExtend), .result(shiftValue));
  BranchAND BranchAND(.Zero(Zero), .Branch(Branch), .ANDResult(ANDResult));
  //-----------------------------------------------------------------
  // Memory Instruction Modules
  //-----------------------------------------------------------------
  InstructionMemory InstructionMemory (.PC(nextPC), .instruction(instruction));
  //-----------------------------------------------------------------
  // Control Modules
  //-----------------------------------------------------------------
  Control Control_Values (.OpCode(instruction[6:0]), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
  //-----------------------------------------------------------------
  // SingExtend Modules
  //-----------------------------------------------------------------
  SignExtend ImmGen (.OpCode(instruction[6:0]), .instruction(instruction[31:0]), .signExtend(signExtend));
  //-----------------------------------------------------------------
  // Registers Modules
  //-----------------------------------------------------------------
  Registers Regs (.ReadReg1(instruction[19:15]), .ReadReg2(instruction[24:20]), .RegWrite(instruction[11:7]), .ReadData1(ReadData1), .ReadData2(ReadData2), .WriteReg(RegWrite), .WriteData(muxDataResult), .clk(clk), .reset(reset));
  //-----------------------------------------------------------------
  // ALU Modules
  //-----------------------------------------------------------------
  ALUValues ALUValues (.ReadData1(ReadData1), .muxResult(muxResult), .ALUCtrl(ALUCtrl), .ALUResult(ALUResult), .Zero(Zero));
  ALUControl ALUControl (.Funct7(instruction[31:25]), .Funct3(instruction[14:12]), .ALUOp(ALUOp), .ALUCtrl(ALUCtrl));
  muxALU muxALU(.ReadData2(ReadData2), .signExtend(signExtend), .ALUSrc(ALUSrc), .muxResult(muxResult));
  //-----------------------------------------------------------------
  // Data Memory
  //-----------------------------------------------------------------
  DataMemory DataMemory(.ALUResult(ALUResult), .ReadData2(ReadData2), .MemWrite(MemWrite), .MemRead(MemRead), .ReadData(ReadData), .clk(clk), .reset(reset));
  muxDataMem muxDataMem(.ReadData(ReadData), .ALUResult(ALUResult), .MemtoReg(MemtoReg), .muxDataResult(muxDataResult));

endmodule
