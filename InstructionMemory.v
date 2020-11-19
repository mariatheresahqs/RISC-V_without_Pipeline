module InstructionMemory (PC, instruction);
  
  input wire [63:0]PC;
  output reg [31:0]instruction;
  reg [31:0]MemInstr[13:0];

  
	always @(PC)begin
		$readmemb("binario.asm", MemInstr);
    instruction = MemInstr[PC];
	end
endmodule
