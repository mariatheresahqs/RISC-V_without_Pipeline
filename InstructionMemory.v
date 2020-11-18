module InstructionMemory (PC, instruction);
  
  input wire [63:0]PC;
  output reg [31:0]instruction;

  /*always @ (*) begin
    case (addressPC)

      64'b0000000000000000000000000000000000000000000000000000000000000000: instruction <= 64'b0000000000000000000000000000000000000000000100000000000100110011;// Tipo R - add x2, x0, x1

    endcase
  end
  */

	always @(*)begin
		$readmemb("binario.asm", instruction);
	end
endmodule
