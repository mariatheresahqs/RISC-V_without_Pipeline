module InstructionMemory (Control_RegWrite, instruction, reg1, reg2, WriteRegister, WriteData, ReadData1, ReadData2);
	
	input wire [4:0]reg1;
	input wire [4:0]reg2;
	input wire [4:0]WriteRegister;
	input wire [63:0]WriteData; // n tenho certeza da quantidade de bits

	output reg [63:0]ReadData1;
	output reg [63:0]ReadData2;

	always @(*) begin
		reg1 <= [19:15]instruction;
		reg2 <= [24:20]instruction;
		WriteRegister <= [11:7]instruction;
		//WriteData nao sei o que fazer	


		ReadData1 <= reg1;
		ReadData1 <= reg2;

		//tem que ver a questao do mux 

	end
endmodule



