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
		     output logic [11:0] csr);
	//assigns opcode
	assign opcode = in[6:0];

	always_comb begin
		//r-types: add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu
		if (opcode === 7'b0110011) begin
			assign funct7 = in[31:25];
			assign rs2 = in[24:20];
			assign rs1 = in[19:15];
			assign funct3 = in[14:12];
			assign rd = in[11:7];
			assign op = in[6:0];
		//csrrw
		end else if(opcode === 7'b1110011) begin
			assign csr = in[31:20];
			assign rs1 = in[19:15];
			assign funct3 = in[14:12];
			assign rd = in[11:7];
			assign op = in[6:0];
		//i-type: addi, andi, ori, xori, slli, srai, srli
		end else if (opcode === 7'b0010011) begin
			assign immi = in[31:20];
			assign rs1 = in[19:15];
			assign funct3 = in[14:12];
			assign rd = in[11:7];
		//u-type: lui
		end else if (opcode === 7'b0110111) begin
			assign immu = in[31:12];
			assign rd = in[11:7];
		end
	end
endmodule
