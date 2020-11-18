
module muxALU(ReadData2, signExtend, ALUSrc, muxResult);

	input wire [63:0]ReadData2, signExtend;
	input wire ALUSrc;
	output reg [63:0] muxResult;

	always @(ReadData2, signExtend, ALUSrc) begin
		case(ALUSrc)
			0: muxResult <= ReadData2;
			1: muxResult <= signExtend;
		endcase
	end

endmodule


module ALUValues (ReadData1, muxResult, ALUCtrl, ALUResult, Zero);

	input wire [63:0]ReadData1, muxResult;
	input wire [3:0]ALUCtrl;
	output reg [63:0]ALUResult;
	output reg Zero;

	always @(*) begin
		
		if(ALUCtrl == 4'b0010)begin //funcao de soma
			ALUResult <= ReadData1 + muxResult;
		end
		else if(ALUCtrl == 4'b0000)begin //funcao de and
			ALUResult <= ReadData1 & muxResult;
		end
		else if(ALUCtrl == 4'b0001)begin //funcao de or
			ALUResult <= ReadData1 | muxResult;
		end
		else if(ALUCtrl == 4'b0110)begin //funcao de sub
			ALUResult <= ReadData1 - muxResult;
		end

		if(ALUResult == 0) begin
			Zero <= 1;
		end
		else begin
			Zero <= 0;
		end

	end

endmodule
