module cpu (input logic [0:0] clk,
		input logic [3:0] rst,
		input logic [31:0] in,
		output logic [31:0] out); //enable writing to GPIO register
	logic [31:0] instruction_mem [4095:0];
	initial
		$readmemh ("hexcode.txt", instruction_mem);

	always_ff @ (posedge clk)
	if (rst) begin
		instruction_EX <= 32'b0;
	PC_FETCH <= 12'b0;
	end else begin
		instruction_EX <= instruction_mem[PC_FETCH];
		PC_FETCH <= PC_FETCH + 12'b1;
	end

	alu aluM(.A(), .B(), .op(), .R(), .zero());
	control_unit ctrl(.itype(), .instr(), .alusrc(), .regwrite(), .regsel(), .aluop(), gpio_we());
	hexdriver hexd(.val(), .HEX());
	instr_decode instd(.in(), .opcode(), .funct7(), .rs2(), .rs1(), .funct3(), .rd(), .immu(),
				.immi(), .csr(), .shamt(), .itype(), .instr());
	regfile regf(.clk(clk), .rst(rst), .we(), .readaddr1(), .readaddr2(), .readaddr3(),
			.writedata());
	
endmodule
