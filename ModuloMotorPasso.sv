//
//						   MUX 4 EM 1
//
//		    	AUTOR: EDWILDSON C. RODRIGUES
//
//				   	 DATA:22/07/2018
//


module motor_de_passo(
	input rst,
	input dir,
	input clk,
	input en,
	output reg [3:0] sinal
);

	localparam sin0 = 4'b0000;
	localparam sin1 = 4'b0001;
	localparam sin2 = 4'b0010;
	localparam sin3 = 4'b0100;
	localparam sin4 = 4'b1000;
	
	reg [2:0] estado_atual, estado_prox;
	
	// REALIZA A TRANSIÇÃO DO ESTADO ATUAL PARA O PRÓXIMO
	always @ (posedge clk, posedge rst) begin
		if(rst == 1'b1)
			estado_atual = sin0;
		else	
			estado_atual = estado_prox;
		end
	
	
	// DEFINIÇÃO DO PRÓXIMO ESTADO
	always @ (estado_atual,dir, en) begin
		case(estado_atual)
		sin4: 
		begin
			if(dir == 1'b0 && en == 1'b1)
				estado_prox = sin3;
			else
			if(dir == 1'b1 && en == 1'b1)
				estado_prox = sin1;
			else
				estado_prox = sin0;
		end
		
		sin3:
		begin
			if(dir == 1'b0 && en == 1'b1)
				estado_prox = sin2;
			else
			if(dir == 1'b1 && en == 1'b1)
				estado_prox = sin4;
			else
				estado_prox = sin0;
		end
		
		sin2:
		begin
			if(dir == 1'b0 && en == 1'b1)
				estado_prox = sin1;
			else
			if(dir == 1'b1 && en == 1'b1)
				estado_prox = sin3;
			else
				estado_prox = sin0;
		end
		
		sin1:
		begin
			if(dir == 1'b0 && en == 1'b1)
				estado_prox = sin4;
			else
			if(dir == 1'b1 && en == 1'b1)
				estado_prox = sin2;
			else
				estado_prox = sin0;
		end
		
		sin0:
		begin
			if(en == 1'b1)
				estado_prox = sin1;
			else
				estado_prox = sin0;
		end
		
		default:
			estado_prox = sin0;
		endcase
	end
	
	// SINAL DE CONTROLE
	always @ (posedge clk)
	begin
		if(estado_atual == sin4)
			sinal = 4'b0001;
		else if(estado_atual == sin3)
			sinal = 4'b0010;
		else if(estado_atual == sin2)
			sinal = 4'b0100;
		else if(estado_atual == sin1)
			sinal = 4'b1000;
		else	
			sinal = 4'b0000;
	end

	
	
	
endmodule
