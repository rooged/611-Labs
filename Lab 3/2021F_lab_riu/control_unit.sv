module instr_decode (input logic [2:0] itype //instruction type (r, i, u)
		     input logic [3:0] instr, //instruction
			 output logic [4:0] alusrc,
			 output logic [0:0] regwrite, //register file write enable
			 output logic [4:0] regsel,
			 output logic [3:0] aluop,
			 output logic [0:0] gpio_we); //enable writing to GPIO register
	assign aluop = instr;

	always_comb begin
		//r-types: add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu, csrrw
		if (itype == 3'b000) begin
			case (funct3)
				3'b000: instr = funct7[0] ? 4'b1010 : (funct7[5] ? 4'b0001 : 4'b0000); //add = 4'b0000, sub = 4'b0001, mul = 4'b1010
				3'b001: instr = opcode[6] ? 4'b1101 : (funct7[0] ? 4'b1011 : 4'b0101); //sll = 4'b0101, mulh = 4'b1011, csrrw = 4'b1101
				3'b010: instr = 4'b1000; //slt = 4'b1000
				3'b011: instr = funct7[0] ? 4'b1100 : 4'b1001; //sltu = 4'b1001, mulhu = 4'b1100
				3'b100: instr = 4'b0100; //xor = 4'b0100
				3'b101: instr = funct7[5] ? 4'b0110 : 4'b0111; //sra = 4'b0110, srl = 4'b0111
				3'b110: instr = 4'b0011; //or = 4'b0011
				3'b111: instr = 4'b0010; //and = 4'b0010
		//i-type: addi, andi, ori, xori, slli, srai, srli
		end else if (itype = 3'b001) begin
			case (funct3)
				3'b000: instr = 4'b0000; //addi = 4'b0000
				3'b001: instr = 4'b0100; //slli = 4'b0100
				3'b100: instr = 4'b0011; //xori = 4'b0011
				3'b101: instr = funct7[5] ? 4'b0101 : 4'b0110; //srai = 4'b0101, srli = 4'b0110
				3'b110: instr = 4'b0010; //ori = 4'b0010
				3'b111: instr = 4'b0001; //andi = 4'b0001
		//u-type: lui
		end else if (itype == 3'b010) begin
			intr = 4'b0000; //lui = 4'b0000
		end/* else if (opcode === 7'b"B-type opcode") begin
			assign itype = 3'b100;
		end else if (opcode === 7'b"J-type opcode") begin
			assign itype = 3'b101;
		end*/
	end
endmodule
