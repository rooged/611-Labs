module cpu (input logic [0:0] clk,
	input logic [0:0] rst,
	input logic [31:0] gpio_in,
	output logic [31:0] gpio_out);
	logic [31:0] instruction_mem [4095:0];
	logic [31:0] instruction_EX;
	logic [31:0] readdata1_EX, readdata2_EX, R_EX;
	logic [11:0] PC_FETCH;
	wire [6:0] opcode_EX, funct7_EX;
	logic [4:0] rs1_EX, rs2_EX, rd_EX, shamt_EX;
	wire [2:0] funct3_EX, itype_EX;
	logic [20:0] immu_EX;
	logic [11:0] immi_EX, csr_EX;
	wire [3:0] instr_EX, aluop_EX;
	logic [0:0] alusrc_EX, regwrite_EX, gpio_we_EX;
	logic [1:0] regsel_EX;
	logic [4:0] rd_WB;
	logic [31:0] A_EX, B_EX, R_WB;
	logic [0:0] regwrite_WB;
	logic [1:0] regsel_WB;
	logic [31:0] writedata_WB, gpio_in_WB, inst_WB;

	initial begin
		$readmemh ("instmem.dat", instruction_mem);
	end

	always_ff @ (posedge clk) begin
		if (rst) begin
			instruction_EX <= 32'b0;
			PC_FETCH <= 12'b0;
		end else begin
			instruction_EX <= instruction_mem[PC_FETCH];
			PC_FETCH <= PC_FETCH + 12'b1;
		end
		
		rd_WB <= rd_EX; //instruction_EX 11:7 -> writeaddr

		//alusrc_EX mux
		if (alusrc_EX) begin
			B_EX <= {{20{immi_EX[11]}}, immi_EX};
		end else begin
			B_EX <= readdata2_EX;
		end

		if (gpio_we_EX) begin //gpio register mux
			gpio_out <= readdata1_EX;
		end

		regwrite_WB <= regwrite_EX; //regwrite_EX -> we
		regsel_WB <= regsel_EX; //regsel_EX -> mux
		gpio_in_WB <= gpio_in; //gpio_in -> mux
		inst_WB <= {immu_EX, 12'b0}; //instruction_EX[31:12], 12'b0 -> mux
		R_WB <= R_EX; //R_EX -> R_WB

		if (regsel_WB == 2'b00) begin //final 3 part mux
			writedata_WB <= gpio_in_WB;
		end else if (regsel_WB == 2'b01) begin
			writedata_WB <= inst_WB;
		end else if (regsel_WB == 2'b10) begin
			writedata_WB <= R_WB;
		end
	end

	alu aluM(.A(readdata1_EX), .B(B_EX), .op(aluop_EX), .R(R_EX), .zero());

	control_unit ctrl(.itype(itype_EX), .instr(instr_EX), .alusrc(alusrc_EX),
		.regwrite(regwrite_EX), .regsel(regsel_EX), .aluop(aluop_EX), .gpio_we(gpio_we_EX));

	instr_decode instd(.in(instruction_EX), .opcode(opcode_EX), .funct7(funct7_EX), .rs2(rs2_EX),
		.rs1(rs1_EX), .funct3(funct3_EX), .rd(rd_EX), .immu(immu_EX), .immi(immi_EX),
		.csr(csr_EX), .shamt(shamt_EX), .itype(itype_EX), .instr(instr_EX));

	regfile regf(.clk(clk), .rst(rst), .we(regwrite_WB), .readaddr1(rs1_EX),
		     .readaddr2(rs2_EX), .writeaddr(rd_WB), .writedata(writedata_WB),
		.readdata1(readdata1_EX), .readdata2(readdata2_EX));
	
endmodule
