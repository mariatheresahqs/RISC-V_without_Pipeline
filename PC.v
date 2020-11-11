module PC (PC, reset, nextPC);
  input wire reset;
  output reg [31:0]PC;
  output reg [31:0]nextPC;

  always @ (*) begin
    if(reset) begin // inicializar (ou resetar) valores de PC com 0s
      nextPC<= 32'd0;
    end
    else begin // caso contrario NextPC passara a ser o valor de PC
      nextPC <= PC;
    end
  end
endmodule

//-----------------------------------------------------------------
// Atualizacao do PC quando nao ha branch: PC + 4 (proxima instrucao)
//-----------------------------------------------------------------
module Sum4 (PC, sum);
  input wire [31:0]PC;
  output reg [31:0]sum;
  always @ (*) begin
    sum <= PC + 32'd4;
  end
endmodule

//-----------------------------------------------------------------
// Atualizacao de PC quando a instrucao de desvio for verdadeira (beq): PC + ShiftLeft = Sum
//-----------------------------------------------------------------
module ShiftLeft (signExtend, result);
  input wire [31:0]signExtend;
  output reg [31:0]result;
  always @ (*) begin
    result <= signExtend  <<  1; //Shift Left, Logical (fill with zero)
  end
endmodule

module ResultPC (PC, shiftValue, sum, ANDBranch, clk);  // desempenhara o papel do AddSum(pc + shiftValue) + Mux(ANDBranch "flag")
  input wire [31:0] PC, shiftValue; // valores que sao recebidos pelo AddSum
  input wire ANDBranch, clk;
  output reg [31:0] sum;
  always @ (posedge clk) begin
    if(ANDBranch) begin
      sum <= PC + shiftValue;
    end
    else if(~ANDBranch) begin
      sum <= PC;  // PC +4 (sum4)
    end
  end
endmodule
