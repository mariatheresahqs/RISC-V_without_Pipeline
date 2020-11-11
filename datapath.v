`include "PC.v"
`include "InstructionMemory.v"
`include "Control.v"

module datapath (clk, reset, nextPC, ALUResult, instruction);
  input wire clk, reset;
  output wire [31:0]nextPC, instruction, ALUResult;
  wire [31:0]resultPC, sum;
  wire [31:0]signExtend, Data1, Data2, DataTemp, WriteData, shiftValue, ReadData, PC;
  wire [4:0]regWrite;
  wire count, ANDBranch, zero;
  wire ALUSrc, MemtoReg, MemWrite, MemRead, RegWrite, Branch;  // instrucoes de controle
  wire [1:0]ALUOp; // instrucoes de controle
  wire [3:0]ALUCtrl; // temporariamente pra nao esquecer. CHECAR os bits

  //-----------------------------------------------------------------
  // Program Counter Modules
  //-----------------------------------------------------------------
  PC PC_datapath (.PC(PC), .reset(reset), .nextPC(nextPC));
  Sum4 PC_4 (.PC(nextPC), .sum(PC));
  ResultPC PC_Branch (.PC(PC), .shiftValue(shiftValue), .sum(sum), .ANDBranch(ANDBranch), .clk(clk));
  ShiftLeft ImmShiftedOneLeft (.signExtend(signExtend), .result(shiftValue));
  //-----------------------------------------------------------------
  // Memory Instruction Modules
  //-----------------------------------------------------------------
  InstructionMemory Instruction_Value (.addressPC(nextPC), .instruction(instruction));
  //-----------------------------------------------------------------
  // Control Modules
  //-----------------------------------------------------------------
  Control Control_Values (.OpCode(instruction[6:0]), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
endmodule
