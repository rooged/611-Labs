//written by Timothy Gedney & Caitlynn Jones
module control_testbench;
	logic [2:0] itype;
	logic [3:0] instr;
	wire [0:0] alusrc, regwrite, gpio_we, branch, jump;
	wire [1:0] regsel;
	wire [3:0] aluop;
	
	control_unit uut (
		.itype(itype),
		.instr(instr),
		.alusrc(alusrc),
		.regwrite(regwrite),
		.gpio_we(gpio_we),
		.regsel(regsel),
		.aluop(aluop),
		.branch(branch),
		.jump(jump)
	);
	
	initial begin
		//I-types
		itype <= 3'b001;

		//jalr
		instr <= 4'b0011;
		#10
		if (alusrc != 1'b0 && regwrite != 1'b0 && regsel != 2'b00 &&
			aluop != 4'b0011 && gpio_we != 1'b0 && branch != 1'b0 && jump != 1'b1) begin
			$error("I-type, jalr: Test 1 Failed");
		end
		
		//B-types
		itype <= 3'b011;

		//beq
		instr <= 4'b0100;
		#10
		if (alusrc != 1'b0 && regwrite != 1'b0 && regsel != 2'b01 &&
			aluop != 4'b0100 && gpio_we != 1'b0 && branch != 1'b1 && jump != 1'b0) begin
			$error("B-types: Test 2 Failed");
		end
		
		//J-types
		itype <= 3'b100;

		//jal
		instr <= 4'b0011;
		#10
		if (alusrc != 1'b0 && regwrite != 1'b0 && regsel != 2'b00 &&
			aluop != 4'b0011 && gpio_we != 1'b0 && branch != 1'b0 && jump != 1'b1) begin
			$error("J-types: Test 3 Failed");
		end

		//Project 3 tests
		/*//R-types
		itype <= 3'b000;

		//add, sub, and, or, xor, sll, sra, srl, slt, sltu, mul, mulh, mulhu
		instr <= 4'b0011;
		#10
		if (alusrc != 1'b0 && regwrite != 1'b1 && regsel != 2'b10 &&
			aluop != 4'b0011 && gpio_we != 1'b0) begin
			$error("R-types: Test 1 Failed");
		end
		
		//csrrw
		instr <= 4'b1101;
		#10
		//dont check for alursrc, regsel, aluop because theyre dont cares
		if (regwrite != 1'b0 && gpio_we != 1'b1) begin
			$error("R-type csrrw: Test 2 Failed");
		end
		
		//I-types
		itype <= 3'b001;

		//addi, andi, ori, xori, slli, srai, srli
		instr <= 4'b0011;
		#10
		if (alusrc != 1'b1 && regwrite != 1'b1 && regsel != 2'b10 &&
			aluop != 4'b0011 && gpio_we != 1'b0) begin
			$error("I-types: Test 3 Failed");
		end
		
		//U-types
		itype <= 3'b010;

		//lui
		instr <= 4'b0000;
		#10
		//dont check for alusrc because its dont care
		if (regwrite != 1'b1 && regsel != 2'b01 && aluop != 4'b0000 &&
			gpio_we != 1'b0) begin
			$error("U-Types: Test 4 Failed");
		end*/
	end
endmodule
