//Edited by Timothy Gedney and Caitlynn Jones
/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic [17:0] SW;
	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	logic [31:0] in;
	logic [6:0] opcode, funct7;
	logic [4:0] rs2, rs1, rd, shamt;
	logic [2:0] funct3, itype;
	logic [20:0] immu;
	logic [11:0] immi, csr;
	logic [3:0] instr;

	top dut
	(
		//////////// CLOCK //////////
		.CLOCK_50(clk),
		.CLOCK2_50(),
	    .CLOCK3_50(),

		//////////// LED //////////
		.LEDG(),
		.LEDR(),

		//////////// KEY //////////
		.KEY(),

		//////////// SW //////////
		.SW(SW),

		//////////// SEG7 //////////
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7),
		
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

	//self checking testbench
	initial begin
		//checks first display at 0
		SW <= 18'b000000000000000000;
		#10;
		if (HEX0 !== 7'b1000000) begin
			$error("HEX0 %x was not 7'b1000000", HEX0);
		end

endmodule

