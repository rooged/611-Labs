//written by Timothy Gedney
module cpu_testbench;
	logic [0:0] clk;
	logic [0:0] rst;
	logic [31:0] gpio_in;
	wire [31:0] gpio_out;

	cpu uut (
		.clk(clk),
		.rst(rst),
		.gpio_in(gpio_in),
		.gpio_out(gpio_out)
	);
	
	initial begin
		//00c00093: addi x1, x0, 12
		//gpio_in <= 0000 0000 1100 0000 0000 0000 1001 0011;
		rst <= 1;
		#1
		rst <= 0;
		#1
		clk <= 0;
		#1
		clk <= 1;
		#7
		if (gpio_in == 32'b00000000110000000000000010010011) begin
			$error("addi: Test 1 Passed");
		end
/*
01100113
0020f1b3
401181b3
01b19193
02310233
02311233
023132b3
00122333
00123333
001273b3
00126433
0020c4b3
8001f513
80016593
00e14613
001116b3
0021d733
4021d7b3
00109813
00115893
4011d913
dbeef9b7
f0219a73
f0019af3*/
	end
endmodule