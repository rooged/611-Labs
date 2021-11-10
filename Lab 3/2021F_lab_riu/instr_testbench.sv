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
		//R-types
		//add $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b000, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b000 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0011) begin
			$error("add: Test 1 Failed");
		end

		//sub $t8, $t3, $t7
		in <= {7'b0100000, 5'b00111, 5'b00011, 3'b000, 5'b01000, 7'b0110011};
		#10
		if (funct7 != 7'b0100000 && rs2 != 5'b00111 && rs1 != 5'b00011 &&
			funct3 != 3'b000 && rd != 5'b01000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0100) begin
			$error("sub: Test 2 Failed");
		end
		
		//and $t10, $t3, $t5
		in <= {7'b0000000, 5'b00101, 5'b00011, 3'b111, 5'b01010, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00101 && rs1 != 5'b00011 &&
			funct3 != 3'b111 && rd != 5'b01010 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0000) begin
			$error("and: Test 3 Failed");
		end
		
		//or $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b110, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b110 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0001) begin
			$error("or: Test 4 Failed");
		end
		
		//xor $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b100, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b100 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0010) begin
			$error("xor: Test 5 Failed");
		end
		
		//sll $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b001, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b001 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b1000) begin
			$error("sll: Test 6 Failed");
		end
		
		//sra $t0, $t1, $t2
		in <= {7'b0100000, 5'b00010, 5'b00001, 3'b101, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0100000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b101 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b1011) begin
			$error("sra: Test 7 Failed");
		end
		
		//srl $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b101, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b101 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b1001) begin
			$error("srl: Test 8 Failed");
		end
		
		//slt $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b010, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b010 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b1010) begin
			$error("slt: Test 9 Failed");
		end
		
		//sltu $t0, $t1, $t2
		in <= {7'b0000000, 5'b00010, 5'b00001, 3'b011, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000000 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b011 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b1100) begin
			$error("sltu: Test 10 Failed");
		end
		
		//mul $t0, $t1, $t2
		in <= {7'b0000001, 5'b00010, 5'b00001, 3'b000, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000001 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b000 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0101) begin
			$error("mul: Test 11 Failed");
		end
		
		//mulh $t0, $t1, $t2
		in <= {7'b0000001, 5'b00010, 5'b00001, 3'b001, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000001 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b001 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0110) begin
			$error("mulh: Test 12 Failed");
		end
		
		//mulhu $t0, $t1, $t2
		in <= {7'b0000001, 5'b00010, 5'b00001, 3'b011, 5'b00000, 7'b0110011};
		#10
		if (funct7 != 7'b0000001 && rs2 != 5'b00010 && rs1 != 5'b00001 &&
			funct3 != 3'b011 && rd != 5'b00000 && opcode != 7'b0110011 &&
			itype != 3'b000 && instr != 4'b0111) begin
			$error("mulhu: Test 13 Failed");
		end
		
		//csrrw $t0, csr, $t1
		in <= {12'b111100001111, 5'b00001, 3'b001, 5'b00000, 7'b1110011};
		#10
		if (csr != 12'b111100001111 && rs1 != 5'b00001 &&
			funct3 != 3'b001 && rd != 5'b00000 && opcode != 7'b1110011 &&
			itype != 3'b000 && instr != 4'b1101) begin
			$error("csrrw: Test 14 Failed");
		end
		
		//I-types
		//addi $t0, $t1, immediate
		in <= {12'b111100001111, 5'b00001, 3'b000, 5'b00000, 7'b0010011};
		#10
		if (immi != 12'b111100001111 && rs1 != 5'b00001 &&
			funct3 != 3'b000 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b0011) begin
			$error("addi: Test 15 Failed");
		end
		
		//andi $t0, $t1, immediate
		in <= {12'b111100001111, 5'b00001, 3'b111, 5'b00000, 7'b0010011};
		#10
		if (immi != 12'b111100001111 && rs1 != 5'b00001 &&
			funct3 != 3'b111 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b0000) begin
			$error("andi: Test 16 Failed");
		end
		
		//ori $t0, $t1, immediate
		in <= {12'b111100001111, 5'b00001, 3'b110, 5'b00000, 7'b0010011};
		#10
		if (immi != 12'b111100001111 && rs1 != 5'b00001 &&
			funct3 != 3'b110 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b0001) begin
			$error("ori: Test 17 Failed");
		end
		
		//xori $t0, $t1, immediate
		in <= {12'b111100001111, 5'b00001, 3'b100, 5'b00000, 7'b0010011};
		#10
		if (immi != 12'b111100001111 && rs1 != 5'b00001 &&
			funct3 != 3'b100 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b0010) begin
			$error("xori: Test 18 Failed");
		end
		
		//slli $t0, $t1, immediate
		in <= {7'b0000000, 5'b00001, 5'b00001, 3'b001, 5'b00000, 7'b0010011};
		#10
		if (funct7 != 7'b0000000 && shamt != 5'b00001 && rs1 != 5'b00001 &&
			funct3 != 3'b001 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b1000) begin
			$error("slli: Test 19 Failed");
		end
		
		//srai $t0, $t1, immediate
		in <= {7'b0100000, 5'b00001, 5'b00001, 3'b101, 5'b00000, 7'b0010011};
		#10
		if (funct7 != 7'b0100000 && shamt != 5'b00001 && rs1 != 5'b00001 &&
			funct3 != 3'b101 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b1100) begin
			$error("srai: Test 20 Failed");
		end
		
		//srli $t0, $t1, immediate
		in <= {7'b0000000, 5'b00001, 5'b00001, 3'b101, 5'b00000, 7'b0010011};
		#10
		if (funct7 != 7'b0000000 && shamt != 5'b00001 && rs1 != 5'b00001 &&
			funct3 != 3'b101 && rd != 5'b00000 && opcode != 7'b0010011 &&
			itype != 3'b001 && instr != 4'b1001) begin
			$error("srli: Test 21 Failed");
		end
		
		//U-types
		//lui $t0, immediate
		in <= {20'b00001111000011110000, 5'b00000, 7'b0110111};
		#10
		if (immu != 20'b00001111000011110000 && rd != 5'b00000 &&
			opcode != 7'b0110111 && itype != 3'b010 && instr != 4'b0000) begin
			$error("lui: Test 22 Failed");
		end
	end
endmodule
