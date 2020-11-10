module PC (PC, Reset, NextPC);
  input wire Reset;
  output reg [31:0]PC;
  output reg [31:0]NextPC;

  always @ (*) begin
    if(Reset) begin // inicializar (ou resetar) valores de PC com 0s
      NextPC<= 32'd0;
    end
    else begin // caso contrario NextPC passara a ser o valor de PC
      NextPC <= PC;
    end
  end
endmodule

module Sum4 (PC, Sum); // atualizacao do PC quando nao ha desvio: PC + 4
  input wire [31:0]PC;
  output reg [31:0]Sum;
  always @ (*) begin
    Sum <= PC + 32'd4;
  end
endmodule

module ResultPC (PC, ShiftValue, Sum, ANDBranch, clock); // atualizacao de PC quando a instrucao de desvio e verdadeira (beq)
  input wire [31:0] PC, ShiftValue; // valores a serem recebidos pelo ADD SUM
  input wire ANDBranch, clock; // valor de ANDBranch recebido pelo Mux
  output reg [31:0] Sum;
  always @ (posedge clock) begin
    if(ANDBranch) begin // AndBranch verdadeiro = 1
      Sum <= PC + ShiftValue;
    end
    else if(~ANDBranch) begin // AndBranch falso = 0
      Sum <= PC; // PC ja foi atualizado no Sum4
    end
  end
endmodule
