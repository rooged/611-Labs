//written by Caitlynn Jones & Timothy Gedney
module instr_decode (input logic [31:0] in, //input
		     output logic [6:0] opcode, //opcode
		     output logic [6:0] funct7, //function 7
		     output logic [4:0] rs2, //register 2
		     output logic [4:0] rs1, //register 1
		     output logic [2:0] funct3, //function 3
		     output logic [4:0] rd, //destination register
		     output logic [20:0] immu, //immediate for u-type
		     output logic [11:0] immi, //immediate for i-type
			 output logic [11:0] immb, //immediate for b-type
			 output logic [19:0] immj, //immediate for j-type
		     output logic [11:0] csr, //csr value for csrrw
			 output logic [4:0] shamt, //shamt value for slli, srai, srli
		     output logic [2:0] itype, //instruction type (r, i, u)
		     output logic [3:0] instr); //instruction
	//assigns values
	assign opcode = in[6:0];
	assign rd = in[11:7];
	assign funct7 = in[31:25];
	assign rs2 = in[24:20];
	assign rs1 = in[19:15];
	assign funct3 = in[14:12];
	assign csr = in[31:20];
	assign immi = in[31:20];
	assign immu = in[31:12];
	assign shamt = in[24:20];
	assign immb = {in[31], in[7], in[30:25], in[11:8]};
	assign immj = {in[31], in[19:12], in[20], in[30:21]};

	always_comb begin
		itype <= 3'b000;
		instr <= 4'b0000;
		//r-types: add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu, csrrw
		if (opcode == 7'b0110011 | opcode == 7'b1110011) begin
			itype <= 3'b000;
			case (funct3)
				3'b000: instr <= funct7[0] ? 4'b0101 : (funct7[5] ? 4'b0100 : 4'b0011); //add = 4'b0011, sub = 4'b0100, mul = 4'b0101
				3'b001: instr <= opcode[6] ? 4'b1101 : (funct7[0] ? 4'b0110 : 4'b1000); //sll = 4'b1000, mulh = 4'b0110, csrrw = 4'b1101
				3'b010: instr <= 4'b1010; //slt = 4'b1010
				3'b011: instr <= funct7[0] ? 4'b0111 : 4'b1100; //sltu = 4'b1100, mulhu = 4'b0111
				3'b100: instr <= 4'b0010; //xor = 4'b0010
				3'b101: instr <= funct7[5] ? 4'b1011 : 4'b1001; //sra = 4'b1011, srl = 4'b1001
				3'b110: instr <= 4'b0001; //or = 4'b0001
				3'b111: instr <= 4'b0000; //and = 4'b0000
			endcase
		//i-type: addi, andi, ori, xori, slli, srai, srli, jalr
		end else if (opcode == 7'b0010011 || opcode == 7'b1100111) begin
			itype <= 3'b001;
			case (funct3)
				3'b000: instr <= ppcode[6] ? 4'b1011 : 4'b0011; //addi = 4'b0011, jalr = 4'b1011
				3'b001: instr <= 4'b1000; //slli = 4'b1000
				3'b100: instr <= 4'b0010; //xori = 4'b0010
				3'b101: instr <= funct7[5] ? 4'b1100 : 4'b1001; //srai = 4'b1100, srli = 4'b1001
				3'b110: instr <= 4'b0001; //ori = 4'b0001
				3'b111: instr <= 4'b0000; //andi = 4'b0000
			endcase
		//u-type: lui
		end else if (opcode == 7'b0110111) begin
			itype <= 3'b010;
			instr <= 4'b0000; //lui = 4'b0000
		//b-type: beq, bge, bgeu, blt, bltu
		end else if (opcode === 7'b1100011) begin
			itype <= 3'b011;
			case (funt3)
				3'b000: instr <= 4'b0100; //beq = sub alu op
				3'b100: instr <= 4'b1010; //blt = slt alu op
				3'b101: instr <= 4'b1010; //bge = slt alu op
				3'b110: instr <= 4'b1100; //bltu = sltu alu op
				3'b111: instr <= 4'b1100; //bgeu = sltu alu op
			endcase
		//j-type: jal
		end else if (opcode === 7'b1101111) begin
			itype <= 3'b100;
			instr <= 4'b0011; //jal = add alu op
		end*/
	end
endmodule
