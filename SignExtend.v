module SignExtend(OpCode, instruction, signExtend); //pegar o imediato e replicar pra 64
  
  input wire [6:0]OpCode;
  input wire [31:0]instruction;
  output reg [63:0]signExtend;
  wire [11:0]immLd;
  wire [11:0]immSd;
  wire [11:0]immBeq;
  assign immLd[11:0] = instruction[31:20];
  assign immSd[11:5] = instruction[31:25];
  assign immSd[4:0] = instruction[11:7];
  assign immBeq[11] = instruction[31]; //imm[12]
  assign immBeq[10] = instruction[7]; //imm[11]
  assign immBeq[9:4] = instruction[30:25]; //imm[10:5]
  assign immBeq[3:0] = instruction[11:8]; //imm[4:1]

  always @ (*) begin
      if(OpCode == 7'b0000011)begin //Instrucao de load
      
      signExtend = {{52{instruction[31]}}, immLd};
      /*
      case(instruction[31]) //tava case(instruction[31])
        1: signExtend[63:12] <= 52'b1111111111111111111111111111111111111111111111111111;
        0: signExtend[63:12] <= 52'b0000000000000000000000000000000000000000000000000000;
      endcase
      */
    end
    else if(OpCode == 7'b0100011) begin //Instrucao de store
      signExtend = {{52{instruction[31]}}, immSd};
      /*
      signExtend[11:5] <= instruction[31:25];
      signExtend[4:0] <= instruction[11:7];
      case(instruction[31]) //tava case(instruction[31])
        1: signExtend[63:12] <= 52'b1111111111111111111111111111111111111111111111111111;
        0: signExtend[63:12] <= 52'b0000000000000000000000000000000000000000000000000000;
      endcase
      */
    end
  
    else if(OpCode == 7'b1100011)begin //Instrucao de beq
      signExtend = {{52{instruction[31]}}, immBeq};
    /*
      Segundo a tabela do RISC-V, o imediato das instrucoes de desvio possuem 13 bits, porem descarta o ultimo
      que e sempre zero. Como aqui o imediato foi declarado de 11 a 0 (12 bits) e o 13o bit do imediato e descartado,
      dei um "shift" nos bits para a direita, para que mantivesse a saida de 11 a 0 (12 bits) ao inves de 12 a 1 (12 bits)
    
      signExtend[11] <= instruction[31]; //imm[12]
      signExtend[10] <= instruction[7]; //imm[11]
      signExtend[9:4] <= instruction[30:25]; //imm[10:5]
      signExtend[3:0] <= instruction[11:8]; //imm[4:1]

      case(instruction[31]) //tava case(instruction[31])
        1: signExtend[63:12] <= 52'b1111111111111111111111111111111111111111111111111111;
        0: signExtend[63:12] <= 52'b0000000000000000000000000000000000000000000000000000;
      endcase
      */
    end
/*
    else begin
      signExtend <= 64'b0;
    end
  */
  end

endmodule

/*
wire [11:0] data1;
wire [11:0] data2;
wire [11:0] data3;
wire [1:0] mode;

assign data1 = instruction[31:20];
assign data2[4:0] = instruction[11:7];
assign data2[11:5] = instruction[31:25];
assign data3[3:0] = instruction[11:8];
assign data3[9:4] = instruction[30:25];
assign data3[10] = instruction[7];
assign data3[11] = instruction[31];
assign mode = instruction[6:5];

always@(*)
begin
if (mode == 2'b00) //load
 imm_data = {{52{instruction[31]}}, data1};
else if (mode == 2'b01) //store
 imm_data = {{52{instruction[31]}}, data2};
else //beq
 imm_data = {{52{instruction[31]}}, data3};
end
*/