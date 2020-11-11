module SignExtend(instruction, signExtend);
  input wire [31:0]instruction;
  output reg [63:0]signExtend;
  always @ (*) begin
    signExtend[31:0] <= instruction; // primeiros 32bits compostos por bits de instrucao
    if(instruction[31] == 1) begin
      signExtend[63:32] <=  '{default:1}; // testar - restante dos bits preenchidos por extensao de sinal
    end
    else if(instruction[31] == 0) begin
      signExtend[63:32] <= '{default:0}; // testar - restante dos bits preenchidos por extensao de sinal
    end
  end
endmodule
// .in ({ {22{1'b0}}, valueA}) //  outra forma
// signExtend[63:32] <= 32'b000000000000000; // outra forma - restante dos bits preenchidos por extensao de sinal
