module instr_decode (input logic [31:0] in, output logic [31:0] out);
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
//addi
//andi
//ori
//xori
//slli
//srai
//srli
//lui
always_comb begin
if(in[6:0] == "7'b0110011")


endmodule
