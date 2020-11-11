module InstructionMemory (addressPC, instruction);
  input wire [63:0]addressPC;
  output reg [63:0]instruction;

  always @ (*) begin
    case (addressPC)

      64'b0000000000000000000000000000000000000000000000000000000000000000: instruction <= 64'b0000000000000000000000000000000000000000000100000000000100110011;// Tipo R - add x2, x0, x1

    endcase
  end
endmodule
