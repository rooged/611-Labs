module control_unit (input logic [2:0] itype, //instruction type (r, i, u)
		     input logic [3:0] instr, //instruction
			 output logic [4:0] alusrc,
			 output logic [0:0] regwrite, //register file write enable
			 output logic [4:0] regsel,
			 output logic [3:0] aluop,
			 output logic [0:0] gpio_we); //enable writing to GPIO register
	aluop = instr;
	alusrc = 1'bx;
	reqwrite = 1'bx;
	regsel = 1'bx;
	gpio_we = 1'bx;

	always_comb begin
	
		if(itype == 3'b000) begin //r-types: add, sub, and, or, xor, sll, sra,
					// srl, slt, sltu, mul, mulh, mulhu, csrrw

			alusrc = 1'b0; //add, sub, mul, slt, and, sll, 
			regsel = 2'b10;
			regwrite = 1'b1;
			gpio_we = 1'b0;
			if(instr == 4'b1101) begin //csrrw
			aluop = 4'bx;
			alusrc = 1'bx;
			regsel = 4'bx;
			reqwrite = 1'b0;
			gpio_we = 1'b1;
			end else begin
		

		if(instr == 4'b1101) begin //sub

			end else begin

		if(instr == 4'b1101) begin //mul

			end else begin
			
		
	end
endmodule