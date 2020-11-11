module InstructionMemory (addressPC, instruction);
  input wire [31:0]addressPC;
  output reg [31:0]instruction;

  always @ (*) begin
    case (addressPC)

      32'b00000000000000000000000000000000: instruction <= 32'b00000000000100000000000100110011;// Tipo R - add x2, x0, x1 

    endcase
  end
endmodule
