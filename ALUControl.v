module ALUControl (Funct7, Funct3, ALUOp, ALUCtrl);
  input wire [6:0]Funct7;
  input wire [2:0]Funct3;
  input wire [1:0]ALUOp;
  output reg [3:0]ALUCtrl;

  always @ (*) begin
    if(ALUOp == 2'b00) begin // tipo load e store
      ALUCtrl <= 4'b0010; // funcao alu soma
    end
    else if(ALUOp == 2'b01) begin // tipo beq
      ALUCtrl <= 4'b0110; // funcao subtracao
    end
    else if(Funct7 == 7'b0000000
     && Funct3 == 3'b000 && ALUOp == 2'b10) begin // tipo R - ADD
      ALUCtrl <= 4'b0010; // funcao alu soma
    end
    else if(Funct7 == 7'b0100000
     && Funct3 == 3'b000 && ALUOp == 2'b10) begin // tipo R - SUB
      ALUCtrl <= 4'b0110;
    end
    else if(Funct7 == 7'b0000000
     && Funct3 == 3'b111 && ALUOp == 2'b10) begin // tipo R - AND
      ALUCtrl <= 4'b0000; // funcao and
    end
    else if(Funct7 == 7'b0000000
     && Funct3 == 3'b110 && ALUOp == 2'b10) begin // tipo R - 
      ALUCtrl <= 4'b0001;
    end
    else begin
      ALUCtrl <= 4'b0;
    end
  end
endmodule

