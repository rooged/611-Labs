//Edited by Timothy Gedney and Caitlynn Jones
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module top (

	//////////// CLOCK //////////
	input 		          		CLOCK_50,
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,

	//////////// LED //////////
	output		     [8:0]		LEDG,
	output		    [17:0]		LEDR,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		    [17:0]		SW,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,
	output		     [6:0]		HEX6,
	output		     [6:0]		HEX7
);
	wire [31:0] gpio_out;

	cpu cpuM(.clk(CLOCK_50), .rst(!KEY[0]), .gpio_in({14'b0, SW[17:0]}), .gpio_out(gpio_out));
	//assigns switches to display & sends to hexdriver
	hexdriver hex0(.val(gpio_out[3:0]), .HEX(HEX0));
	hexdriver hex1(.val(gpio_out[7:4]), .HEX(HEX1));
	hexdriver hex2(.val(gpio_out[11:8]), .HEX(HEX2));
	hexdriver hex3(.val(gpio_out[15:12]), .HEX(HEX3));
	hexdriver hex4(.val(gpio_out[19:16]), .HEX(HEX4));
	hexdriver hex5(.val(gpio_out[23:20]), .HEX(HEX5));
	hexdriver hex6(.val(gpio_out[27:24]), .HEX(HEX6));
	hexdriver hex7(.val(gpio_out[31:28]), .HEX(HEX7));

//=======================================================
//  REG/WIRE declarations
//=======================================================

	/* 24 bit clock divider, converts 50MHz clock signal to 2.98Hz */
	logic [23:0] clkdiv;
	logic ledclk;
	assign ledclk = clkdiv[23];

	/* driver for LEDs */
	logic [25:0] leds;
	assign LEDR = leds[25:8];
	assign LEDG = leds[7:0];

	/* LED state register, 0 means going left, 1 means going right */
	logic ledstate;


//=======================================================
//  Behavioral coding
//=======================================================


	initial begin
		clkdiv = 26'h0;
		/* start at the far right, LEDG0 */
		leds = 26'b1;
		/* start out going to the left */
		ledstate = 1'b0;
	end

	always @(posedge CLOCK_50) begin
		/* drive the clock divider, every 2^26 cycles of CLOCK_50, the
		* top bit will roll over and give us a clock edge for clkdiv
		* */
		clkdiv <= clkdiv + 1;
	end

	always @(posedge ledclk) begin
		/* going left and we are at the far left, time to turn around */
		if ( (ledstate == 0) && (leds == 26'b10000000000000000000000000) ) begin
			ledstate <= 1;
			leds <= leds >> 1;

		/* going left and not at the far left, keep going */
		end else if (ledstate == 0) begin
			ledstate <= 0;
			leds <= leds << 1;

		/* going right and we are at the far right, turn around */
		end else if ( (ledstate == 1) && (leds == 26'b1) ) begin
			ledstate <= 0;
			leds <= leds << 1;

		/* going right, and we aren't at the far right */
		end else begin
			leds <= leds >> 1;
		end
	end

endmodule
