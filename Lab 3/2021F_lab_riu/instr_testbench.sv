//written by Timothy Gedney
module instr_testbench;
	logic [31:0] in;
	wire [6:0] opcode, funct7;
	wire [4:0] rs2, rs1, rd, shamt;
	wire [2:0] funct3, itype;
	wire [20:0] immu;
	wire [11:0] immi, csr;
	wire [3:0] instr;
	
	instr_decode uut (
		.in(in),
		.opcode(opcode),
		.funct7(funct7),
		.rs2(rs2),
		.rs1(rs1),
		.rd(rd),
		.shamt(shamt),
		.funct3(funct3),
		.itype(itype),
		.immu(immu),
		.immi(immi),
		.csr(csr),
		.instr(instr)
	);
	
	initial begin
		//add $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b000, 5'b00000, 7'b0110011};
		#10
		if (funct7 == 0000000 && rs2 == 5'b00010 && rs1 == 5'b00001 &&
			funct3 == 3'b000 && rd == 5'b00000 && opcode == 7'b0110011 &&
			itype == 3'b000 && instr == 4'b0011) begin
			$error("add: Test 1 Passed");
		end

		//sub $t8, $t3, $t7
		in <= {7'b0100000, 5'b00111, 5'b00011, 3'b000, 5'b01000, 7'b0110011};
		#10
		if (funct7 == 0100000 && rs2 == 5'b00111 && rs1 == 5'b00011 &&
			funct3 == 3'b000 && rd == 5'b01000 && opcode == 7'b0110011 &&
			itype == 3'b000 && instr == 4'b0100) begin
			$error("sub: Test 2 Passed");
		end
		
		//and $t10, $t4, $t5
		in <= {7'b0000000, 5'b00101, 5'b00100, 3'b111, 5'b01010, 7'b0110011};
		#10
		if (funct7 == 0000000 && rs2 == 5'b00101 && rs1 == 5'b00011 &&
			funct3 == 3'b111 && rd == 5'b01000 && opcode == 7'b0110011 &&
			itype == 3'b000 && instr == 4'b0000) begin
			$error("and: Test 3 Passed");
		end
		
		//or $t2, $t1, $t0
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b110, 5'b00000, 7'b0110011};
		#10
		if (funct7 == 0000000 && rs2 == 5'b00101 && rs1 == 5'b00011 &&
			funct3 == 3'b111 && rd == 5'b01000 && opcode == 7'b0110011 &&
			itype == 3'b000 && instr == 4'b0001) begin
			$error("or: Test 4 Passed");
		end
	end
endmodule