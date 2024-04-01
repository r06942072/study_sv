/*
	lab24, sv_lrm2017 18.5.14 soft constraint

*/
module top;
	class C ;
		integer repeat_times;
		rand bit num_1b;
		rand int num_int1;
		rand int num_int2;

		function new (); //constructor
			this.repeat_times = 5;
		endfunction

		constraint c { soft num_1b == 0; } 

		constraint c1{ soft num_int1 > 1; soft num_int1 < 4; } 
		constraint c2{ soft num_int2 < 1; soft num_int2 > 4; } //cannot satisfied simultaneously, so discard 
	endclass
	
	C inst1 = new();
	
    initial begin
		$display("as default");
        repeat(inst1.repeat_times) begin
			inst1.randomize();
			$display("num_1b=%0d, num_int1=%0d, num_int2=%0d", inst1.num_1b, inst1.num_int1, inst1.num_int2);
        end
		
		$display("with inline constraint {num_1b == 1}");
        repeat(inst1.repeat_times) begin
			inst1.randomize() with { num_1b == 1; };
			$display("num_1b=%0d, num_int1=%0d, num_int2=%0d", inst1.num_1b, inst1.num_int1, inst1.num_int2);
        end

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule