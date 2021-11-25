//written by Timothy Gedney & Caitlynn Jones
module control_unit (input logic [2:0] itype, //instruction type (r, i, u)
		     input logic [3:0] instr, //instruction
			 output logic [0:0] alusrc,
			 output logic [0:0] regwrite, //register file write enable
			 output logic [1:0] regsel,
			 output logic [3:0] aluop,
			 output logic [0:0] gpio_we, //enable writing to GPIO register
			 output logic [0:0] branch, //enable branch
			 output logic [0:0] jump); //enable jump

	always_comb begin
		aluop <= 4'b0000;
		alusrc <= 1'b0;
		regsel <= 2'b10;
		regwrite <= 1'b1;
		gpio_we <= 1'b0;
		branch <= 1'b0;
		jump <= 1'b0;

		//r-types: add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu, csrrw
		if (itype == 3'b000) begin
			if (instr == 4'b1101) begin //csrrw
				aluop <= 4'bxxxx;
				alusrc <= 1'bx;
				regsel <= 2'b00;
				regwrite <= 1'b1;
				gpio_we <= 1'b1;
			end else begin //everything else
				aluop <= instr;
				alusrc <= 1'b0;
				regsel <= 2'b10;
				regwrite <= 1'b1;
				gpio_we <= 1'b0;
			end
		end else if (itype == 3'b001) begin //addi, andi, ori, xori, slli, srai, srli, jalr
			if (instr = 4'b1011) begin //jalr
				aluop <= 4'b0011;
				alusrc <= 1'b0;
				regwrite <= 1'b0;
				regsel <= 2'b00;
				gpio_we <= 1'b0;
				jump <= 1'b1;
			end else begin //everything else
				aluop <= instr;
				alusrc <= 1'b1;
				regwrite <= 1'b1;
				regsel <= 2'b10;
				gpio_we <= 1'b0;
			end
		end else if (itype == 3'b010) begin //lui
			aluop <= instr;
			alusrc <= 1'bx;
			regwrite <= 1'b1;
			regsel <= 2'b01;
			gpio_we <= 1'b0;
		end else if (istr == 3'b011) begin //beq, bge, bgeu, blt, bltu
			aluop <= instr;
			alusrc <= 1'b0;
			regwrite <= 1'b0;
			regsel <= 2'b01;
			gpio_we <= 1'b0;
			branch <= 1'b1;
		end else if (istr == 3'b100) begin //jal
			aluop <= instr;
			alusrc <= 1'b0;
			regwrite <= 1'b0;
			regsel <= 2'b00;
			gpio_we <= 1'b0;
			jump <= 1'b1;
		end
	end
endmodule
