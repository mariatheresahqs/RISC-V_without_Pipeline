module InstructionMemory (addressPC, instruction);
  
  input wire [63:0]addressPC;
  output reg [63:0]instruction;

  /*always @ (*) begin
    case (addressPC)

      64'b0000000000000000000000000000000000000000000000000000000000000000: instruction <= 64'b0000000000000000000000000000000000000000000100000000000100110011;// Tipo R - add x2, x0, x1

    endcase
  end
  */

	integer               data_file    ; // file handler
	integer               scan_file    ; // file handler
	reg [21:0] captured_data;
	`define NULL 0

	initial begin
		data_file = $fopen("saida.asm", "r");
		if (data_file == `NULL) begin
			$display("Erro ao abrir o arquivo");
			$finish;
		end
	end

	always @(posedge clk) begin
		scan_file = $fscanf(data_file, "%dn", captured_data); //ja esta sedo lido como inteiro
		
		if (!$feof(data_file)) begin
			//use captured_data as you would any other wire or reg value;
			//chamar os modulos Controle, Registradores e Gerador de Imediato
		end
	end

endmodule
