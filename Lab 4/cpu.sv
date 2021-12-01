//written by Timothy Gedney & Caitlynn Jones
module cpu (input logic [0:0] clk,
	input logic [0:0] rst,
	input logic [31:0] gpio_in,
	output logic [31:0] gpio_out);
	logic [31:0] instruction_mem [4095:0];
	logic [31:0] instruction_EX;
	logic [31:0] readdata1_EX, readdata2_EX, R_EX;
	logic [11:0] PC_FETCH, PC_EX;
	logic [6:0] opcode_EX, funct7_EX;
	logic [4:0] rs1_EX, rs2_EX, rd_EX, shamt_EX;
	logic [2:0] funct3_EX, itype_EX;
	logic [20:0] immu_EX;
	logic [11:0] immi_EX, csr_EX, immb_EX, jalr_offset, jalr_addr;
	logic [3:0] instr_EX, aluop_EX;
	logic [0:0] alusrc_EX, regwrite_EX, gpio_we_EX;
	logic [1:0] regsel_EX;
	logic [4:0] rd_WB;
	logic [31:0] A_EX, B_EX, R_WB;
	logic [0:0] regwrite_WB, branch_EX, jump_EX;
	logic [1:0] regsel_WB;
	logic [31:0] writedata_WB, gpio_in_WB, inst_WB;
	logic [19:0] immj_EX;
	logic [12:0] branch_offset_EX, branch_addr_EX;
	logic [20:0] jal_offset_EX, jal_addr_EX;

	initial begin
		$readmemh ("instmem.dat", instruction_mem);
	end

	assign branch_offset_EX = {instruction_EX[31], instruction_EX[7], instruction_EX[30:25],
		instruction_EX[11:8], 1'b0};
	assign branch_addr_EX = PC_EX + {branch_offset_EX[12], branch_offset_EX[12:2]};
	assign jal_offset_EX = {instruction_EX[31], instruction_EX[19:12], instruction_EX[20],
		instruction_EX[30:21], 1'b0};
	assign jal_addr_EX = PC_EX + jal_offset_EX[13:12];
	assign jalr_offset = instruction_EX[31:20];
	assign jalr_addr = readdata1_EX[13:2] + {{2{jalr_offset[11]}}, jalr_offset[11:2]};

	always_ff @ (posedge clk) begin
		if (rst) begin
			instruction_EX <= 32'b0;
			PC_FETCH <= 12'b0;
			PC_EX <= 12'b0;
		end else begin
			if (branch_EX) begin
				PC_FETCH <= branch_addr_EX;
				PC_EX <= PC_FETCH;
			end else if (jump_EX && instr_EX == 4'b1011) begin
				PC_FETCH <= jalr_addr;
				PC_EX <= PC_FETCH;
			end else if (jump_EX) begin
				PC_FETCH <= jal_addr;
				PC_EX <= PC_FETCH;
			end else begin
				instruction_EX <= instruction_mem[PC_FETCH];
				PC_FETCH <= PC_FETCH + 12'b1;
				PC_EX <= PC_EX + 1;
			end
		end

		if (gpio_we_EX) begin //gpio register mux
			gpio_out <= readdata1_EX;
		end
		
		rd_WB <= rd_EX; //instruction_EX 11:7 -> writeaddr
		regwrite_WB <= regwrite_EX; //regwrite_EX -> we
		regsel_WB <= regsel_EX; //regsel_EX -> mux
		gpio_in_WB <= gpio_in; //gpio_in -> mux
		inst_WB <= {instruction_EX[31:12], 12'b0}; //instruction_EX[31:12], 12'b0 -> mux
		R_WB <= R_EX; //R_EX -> R_WB
	end

	always_comb begin
		if (!jump_EX || !branch_EX) begin
			if (alusrc_EX) begin //alusrc_EX mux
				B_EX = {{20{instruction_EX[31]}}, instruction_EX[31:20]};
			end else begin
				B_EX = readdata2_EX;
			end

			if (regsel_WB == 2'b00) begin //final 3 part mux
				writedata_WB = gpio_in_WB;
			end else if (regsel_WB == 2'b01) begin
				writedata_WB = inst_WB;
			end else if (regsel_WB == 2'b10) begin
				writedata_WB = R_WB;
			end else if (regsel_WB == 2'b11) begin
				writedata_WB = PC_FETCH;
			end else begin
				writedata_WB = gpio_in_WB;
			end
		end else begin
				
		end
	end

	alu aluM(.A(readdata1_EX), .B(B_EX), .op(aluop_EX), .R(R_EX), .zero());

	control_unit ctrl(.itype(itype_EX), .instr(instr_EX), .alusrc(alusrc_EX),
		.regwrite(regwrite_EX), .regsel(regsel_EX), .aluop(aluop_EX), .gpio_we(gpio_we_EX),
		.branch(branch_EX), .jump(jump_EX));

	instr_decode instd(.in(instruction_EX), .opcode(opcode_EX), .funct7(funct7_EX), .rs2(rs2_EX),
		.rs1(rs1_EX), .funct3(funct3_EX), .rd(rd_EX), .immu(immu_EX), .immi(immi_EX),
		.immb(immb_EX), .immj(immj_EX), .csr(csr_EX), .shamt(shamt_EX), .itype(itype_EX),
		.instr(instr_EX));

	regfile regf(.clk(clk), .rst(rst), .we(regwrite_WB), .readaddr1(rs1_EX),
		     .readaddr2(rs2_EX), .writeaddr(rd_WB), .writedata(writedata_WB),
		.readdata1(readdata1_EX), .readdata2(readdata2_EX));
	
endmodule
