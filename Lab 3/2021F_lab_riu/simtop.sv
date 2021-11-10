//Edited by Timothy Gedney and Caitlynn Jones
/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic [17:0] SW;
	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	logic [3:0] rst;

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
		.KEY(rst),

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
		.HEX7(HEX7)
	);
	//self checking testbench
	always begin
		clk = 0;
		#5;
		clk = 1;
		#5;
	end

	initial begin
		SW <= 18'd12345;
		rst <= 0;
		#10;
		rst <= 1;
		#500
		if (HEX7 != 7'h40 || HEX6 != 7'h40 || HEX5 != 7'h40 || HEX4 != 7'h79 ||
			HEX3 != 7'h24 || HEX2 != 7'h30 || HEX1 != 7'h19 || HEX0 != 7'h12) begin
			$error("Test 1 Failed");
		end

		SW <= 18'd6789;
		rst <= 0;
		#10;
		rst <= 1;
		#500
		if (HEX7 != 7'h40 || HEX6 != 7'h40 || HEX5 != 7'h40 || HEX4 != 7'h40 ||
			HEX3 != 7'h02 || HEX2 != 7'h78 || HEX1 != 7'h00 || HEX0 != 7'h18) begin
			$error("Test 2 Failed");
		end

		SW <= 18'd262143;
		rst <= 0;
		#10;
		rst <= 1;
		#500
		if (HEX7 != 7'h40 || HEX6 != 7'h40 || HEX5 != 7'h24 || HEX4 != 7'h02 ||
			HEX3 != 7'h24 || HEX2 != 7'h79 || HEX1 != 7'h19 || HEX0 != 7'h30) begin
			$error("Test 3 Failed");
		end

		SW <= 18'd0897;
		rst <= 0;
		#10;
		rst <= 1;
		#500
		if (HEX7 != 7'h40 || HEX6 != 7'h40 || HEX5 != 7'h40 || HEX4 != 7'h40 ||
			HEX3 != 7'h40 || HEX2 != 7'h00 || HEX1 != 7'h18 || HEX0 != 7'h78) begin
			$error("Test 4 Failed");
		end
	end
endmodule
