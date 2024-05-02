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

///////////////////////////////
// method1.      C::c3 { num_2b >= 2'd2; }; // sv_lrm2017 18.5.1 explicit
// method2.      inst1.randomize() with { num_1b == 1; };
/*
class C;
	rand bit [1:0] num_2b; //2 or 3
	constraint c3;
endclass
C::c3 { num_2b >= 2'd2; };

C inst1 = new();
C inst2 = new();
C inst3 = new();

initial begin
	repeat(10) begin
		inst1.randomize();
	end
	
	repeat(100) begin
		inst2.randomize();
	end	
	
	repeat(1000) begin
		inst3.randomize() with { num_2b >= 2'd3; }; //runtime modification
	end	
end
*/