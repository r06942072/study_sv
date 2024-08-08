

module adder_rtl(

		input	logic[3:0]		a,b,
  		output	logic[4:0]		y

		);
		
		
		always_comb  begin: B1	
		
			y = a + b;
		end: B1
			
		
endmodule: adder_rtl






// ------------------------------- interface -------------------------------


interface adder_if();


	logic [3:0]a,b;
	logic [4:0]y;

endinterface: adder_if
