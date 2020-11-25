//-----------------------------------------------------------------
// Atualizacao de PC quando a instrucao de desvio for verdadeira (beq): PC + ShiftLeft = Sum
//-----------------------------------------------------------------
module ShiftLeft (signExtend, result);
  input wire [63:0]signExtend;
  output reg [63:0]result;
  always @ (*) begin
    result <= signExtend  <<  1; //Shift Left, Logical (fill with zero)
  end
endmodule


module BranchAND(Zero, Branch, ANDResult);
  input wire Zero, Branch;
  output reg ANDResult;

  always @(*)begin
    ANDResult <= Zero & Branch;
  end
endmodule


module ResultPC (PC, shiftValue, sum, ANDBranch, clk);  // desempenhara o papel do AddSum(pc + shiftValue) + Mux(ANDBranch "flag")
  input wire [63:0] PC, shiftValue; // valores que sao recebidos pelo AddSum
  input wire ANDBranch, clk;
  output reg [63:0] sum;

  initial begin
    sum = 0;
  end

  always @ (posedge clk) begin
    if(ANDBranch) begin
      sum <= PC + shiftValue;
    end
    else if(~ANDBranch) begin
      sum <= PC + 64'd4; // PC +4 (sum4)
    end
  end
endmodule
