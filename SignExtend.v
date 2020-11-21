module SignExtend(OpCode, instruction, signExtend); //pegar o imediato e replicar pra 64
  
  input wire [6:0]OpCode;
  input wire [31:0]instruction;
  output reg [63:0]signExtend;
  
  always @ (*) begin
    if(OpCode == 7'b0000011)begin //Instrucao de load
      signExtend[11:0] <= instruction[31:25];
      case(instruction[31])
        1: signExtend[63:12] <= 52'b1111111111111111111111111111111111111111111111111111;
        0: signExtend[63:12] <= 52'b0000000000000000000000000000000000000000000000000000;
      endcase
    end
    else begin
      signExtend <= 64'b0;
    end
  end

    /*
    signExtend[31:0] <= instruction; // primeiros 32bits compostos por bits de instrucao
    if(instruction[31] == 1) begin
      //signExtend[63:32] <=  '{default:1}; // testar - restante dos bits preenchidos por extensao de sinal
      signExtend[63:32] <= 32'b11111111111111111111111111111111;
    end
    else if(instruction[31] == 0) begin
      //signExtend[63:32] <= '{default:0}; // testar - restante dos bits preenchidos por extensao de sinal
      signExtend[63:32] <= 32'b00000000000000000000000000000000;
    end
  end
  */
endmodule
// .in ({ {22{1'b0}}, valueA}) //  outra forma
// signExtend[63:32] <= 32'b00000000000000000000000000000000; // outra forma - restante dos bits preenchidos por extensao de sinal

