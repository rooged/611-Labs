//Edited by Timothy Gedney and Caitlynn Jones
/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic [17:0] SW;
	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	logic [3:0] rst;
	logic [31:0] gpio_in, gpio_out;

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
		.HEX7(HEX7),
		
		.gpio_in(gpio_in),
		.gpio_out(gpio_out)
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

