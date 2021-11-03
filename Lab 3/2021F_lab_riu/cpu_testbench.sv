//written by Timothy Gedney
module cpu_testbench;
	logic [0:0] clk;
	logic [3:0] rst;
	logic [31:0] gpio_in;
	wire [31:0] gpio_out;

	cpu uut (
		.clk(clk),
		.rst(rst),
		.gpio_in(gpio_in),
		.gpio_out(gpio_out)
	);
	
	initial begin
		//set possedge of clock
		gpio_in <= 0000 0000 0000 0000 0000 0000 0000 0000;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (alusrc == 1'b0 && regwrite == 1'b1 && regsel == 2'b10 &&
			aluop == 4'b0011 && gpio_we == 1'b0) begin
			$error("R-types: Test 1 Passed");
		end
	end
endmodule