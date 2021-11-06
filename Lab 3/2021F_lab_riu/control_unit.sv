module control_unit (input logic [2:0] itype, //instruction type (r, i, u)
		     input logic [3:0] instr, //instruction
			 output logic [0:0] alusrc,
			 output logic [0:0] regwrite, //register file write enable
			 output logic [1:0] regsel,
			 output logic [3:0] aluop,
			 output logic [0:0] gpio_we); //enable writing to GPIO register

	always_comb begin
		aluop <= 4'b0000;
		alusrc <= 1'b0;
		regwrite <= 1'b1;
		regsel <= 2'b10;
		gpio_we <= 1'b0;

		//r-types: add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu, csrrw
		if (itype == 3'b000) begin
			if (instr == 4'b1101) begin //csrrw
				aluop <= 4'bxxxx;
				alusrc <= 1'bx;
				regsel <= 2'bxx;
				regwrite <= 1'b0;
				gpio_we <= 1'b1;
			end else begin
				aluop <= instr;
				alusrc <= 1'b0;
				regsel <= 2'b10;
				regwrite <= 1'b1;
				gpio_we <= 1'b0;
			end
		end else if (itype == 3'b001) begin //addi, andi, ori, xori, slli, srai, srli
			aluop <= instr;
			alusrc <= 1'b1;
			regwrite <= 1'b1;
			regsel <= 2'b10;
			gpio_we <= 1'b0;
		end else if (itype == 3'b010) begin //lui
			aluop <= instr;
			alusrc <= 1'bx;
			regwrite <= 1'b1;
			regsel <= 2'b01;
			gpio_we <= 1'b0;
		end/* else if (istr == 3'b011) begin
		
		end else if (istr == 3'b100) begin
		
		end*/
	end
endmodule
