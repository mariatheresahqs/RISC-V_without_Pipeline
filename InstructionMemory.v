module InstructionMemory (PC, instruction);
  
  input wire [63:0]PC;
  output reg [31:0]instruction;
  reg [31:0]MemInstr[17:0];

	initial begin
		$readmemb("binario.asm", MemInstr);
	end
  
	always @(PC)begin
    	instruction = MemInstr[PC>>2];
	end
endmodule
