module cpu (input logic [0:0] clk,
		input logic [3:0] rst,
		input logic [31:0] in,
		output logic [31:0] out);
	logic [31:0] instruction_mem [4095:0];
	wire [31:0] instruction_EX, readdata1_EX, readdata2_EX, R_EX;
	logic [11:0] PC_FETCH;
	wire [6:0] opcode_EX, funct7_EX;
	wire [4:0] rs1_EX, rs2_EX, rd_EX, shamt_EX;
	wire [2:0] funct3_EX, itype_EX;
	wire [20:0] immu_EX;
	wire [11:0] immi_EX, csr_EX;
	wire [3:0] instr_EX, aluop_EX;
	wire [0:0] alusrc_EX, regwrite_EX, gpio_we_EX;
	wire [1:0] regsel_EX;
	logic [4:0] rd_WB;
	logic [31:0] A_EX, B_EX, R_WB;
	logic [0:0] regwrite_WB;
	logic [1:0] regsel_WB;
	logic [31:0] writedata_WB;

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

	always_comb begin
		rd_WB <= rd_EX;

		if alusrc_EX
			B_EX <= instruction_EX[31:20];
		else
			B_EX <= readdata2_EX;

		regwrite_WB <= regwrite_EX;
		regsel_WB <= regsel_EX;
		R_WB <= R_EX;

		if (regsel_WB == 2'b00)
			writedata_WB <= in;
		else if (regsel_WB == 2'b01)
			writedata_WB <= regwrite_EX;
		else if (regsel_WB == 2'b10)
			writedata_WB <= R_WB;
			
		//rd_WB <= instruction_EX;
	end

	alu aluM(.A(readdata1_EX), .B(B_EX), .op(opcode_EX), .R(R_EX), .zero());

	control_unit ctrl(.itype(itype_EX), .instr(instr_EX), .alusrc(alusrc_EX),
		.regwrite(regwrite_EX), .regsel(regsel_EX), .aluop(aluop_EX), gpio_we(gpio_we_EX));

	hexdriver hexd(.val(), .HEX());

	instr_decode instd(.in(instruction_EX), .opcode(opcode_EX), .funct7(funct7_EX), .rs2(rs2_EX),
		.rs1(rs1_EX), .funct3(funct3_EX), .rd(rd_EX), .immu(immu_EX), .immi(immi_EX),
		.csr(csr_EX), .shamt(shamt_EX), .itype(itype_EX), .instr(instr_EX));

	regfile regf(.clk(clk), .rst(rst), .we(regwrite_WB), .readaddr1(instruction_EX[19:15]),
		.readaddr2(instruction_EX[24:20]), .writeaddr(rd_WB), .writedata(),
		.readdata1(readdata1_EX), .readdata2(readdata2_EX));
	
endmodule
