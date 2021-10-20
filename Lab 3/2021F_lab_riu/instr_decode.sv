module instr_decode (input logic [31:0] in, output logic [31:0] op, output logic [11:0] imm, output logic [6:0] funct7, output logic [4:0] rs2, output logic [4:0] rs1, output logic [3:0] funct3, output logic [4:0] rd, output logic [11:0] csr);
assign opcode = in[6:0];

always_comb begin
	if (opcode === 7'b0110011) begin // r type
	//add
	assign funct7 = in[31:25];
	assign rs2 = in[24:20];
	assign rs1 = in[19:15];
	assign funct3 = in[14:12];
	assign rd = in[11:7];
	assign op = in[6:0];
end else if(opcode === 7'b1110011) begin //csrrw
	assign csr = in[31:20];
	assign rs1 = in[19:15];
	assign funct3 = in[14:12];
	assign rd = in[11:7];
	assign op = in[6:0];
	//add
//sub
//and
//or
//xor
//sll
//sra
//srl
//slt
//sltu
//mul
//mulh
//mulhu
//csrrw
	end else if (opcode === 7'b0010011) begin
	//addi
	//andi
	//ori
	//xori
	//slli
	//srai
	//srli
	end else if (opcode === 7'b0110111) begin
		//lui
	end
end



if(in[6:0] == "7'b0110011")


endmodule
