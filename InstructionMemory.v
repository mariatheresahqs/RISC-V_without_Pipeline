module InstructionMemory (AddressPC, Instruction);
  input wire [31:0]AddressPC;
  output reg [31:0]Instruction;

  always @ (*) begin
    case (AddressPC)

      32'b00000000000000000000000000000000: Instruction <= 32'b00000000000100000000000100110011;// Tipo R - add x2, x0, x1 

    endcase
  end
endmodule