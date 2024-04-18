/*
	lab20, sv_lrm 8.7 constructor
	run on https://edaplayground.com/
*/
module top;
	class C;
		int c1 = 1;
		int c2 = 1;
		int c3 = 1;
		
		function disp();
			$display("In class C, c1 = %0d, c2= %0d, c3 = %0d", this.c1, this.c2, this.c3);
		endfunction
	endclass

	class D extends C;
		int d1 = 4;
		int d2 = c2;
		int d3 = 6;
		
		function disppp();
			$display("In class D, c1 = %0d, c2= %0d, c3 = %0d", this.c1, this.c2, this.c3);
			$display("In class D, d1 = %0d, d2= %0d, d3 = %0d", this.d1, this.d2, this.d3);
		endfunction
		
		function fun2();
			this.d2 = 999;
		endfunction
	endclass

	C inst1;
	D inst2; //object
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
		#10;
		
		inst1 = new();
		inst1.disp();
		#10;
		
		inst2 = new();
		inst2.disppp();
		
		inst2.fun2();
		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule