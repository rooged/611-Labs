module instr_decode (input logic [31:0] in,
		     output logic [31:0] op,
		     output logic [11:0] imm,
		     output logic [6:0] funct7,
		     output logic [4:0] rs2,
		     output logic [4:0] rs1,
		     output logic [2:0] funct3,
		     output logic [4:0] rd,
		     output logic [20:0] immu,
		     output logic [20:0] immi,
		     output logic [11:0] csr,
		     output logic [2:0] itype
		     output logic [3:0] instr);
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

	always_comb begin
		//r-types: add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu
		if (opcode === 7'b0110011 | opcode === 7'b1110011) begin
			assign itype = 3'b001;
			case (funct3)
				3'b000: instr = funct7 === 7'b00000 ? 4'b0000 : 4'b0001;
			
		//i-type: addi, andi, ori, xori, slli, srai, srli
		end else if (opcode === 7'b0010011) begin
			assign itype = 3'b010;
		//u-type: lui
		end else if (opcode === 7'b0110111) begin
			assign itype = 3'b011;
		end/* else if (opcode === 7'b"B-type opcode") begin
			assign itype = 3'b100;
		end else if (opcode === 7'b"J-type opcode") begin
			assign itype = 3'b101;
		end*/
	end
endmodule
