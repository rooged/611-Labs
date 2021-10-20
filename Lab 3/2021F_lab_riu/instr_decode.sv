module instr_decode (input logic [31:0] in, output logic [31:0] out);
logic [6:0] opcode;
assign opcode = in[6:0];

always_comb begin
	if (opcode === 7'b0110011 | opcode === 7'b1110011) begin
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
