/*
	lab23, sv_lrm2017 18.8, 18.9 rand_mode, constraint_mode
	rand_mode default on 1
	constraint_mode default on 1
*/

module top;
	class C;
		integer repeat_times;
		rand bit [1:0] num_2b; //rand_mode, default on
		rand bit [2:0] num_3b; //constraint_mode
		
		function new (); //constructor
			this.repeat_times = 5;
		endfunction
	
		constraint c1 { num_3b == 3'd1; }
		//constraint c2;        // sv_lrm2017 18.5.1 implicit, not recommend
		//extern constraint c3; // sv_lrm2017 18.5.1 explicit
	endclass

	//constraint C::c2 {1;} // sv_lrm2017 18.5.1 implicit, not recommend
	// C::c3 { num_2b >= 2'd2; }; // sv_lrm2017 18.5.1 explicit
	
	C inst1 = new();
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
		
		$display("test, as default");
        repeat(inst1.repeat_times) begin
			inst1.randomize();
			$display("num_2b=%0d, num_3b=%0d", inst1.num_2b, inst1.num_3b);
        end
		
		$display("test, rand_mode(0)");
		inst1.num_2b.rand_mode(0); //off
		repeat(inst1.repeat_times) begin
			inst1.randomize();
			$display("num_2b=%0d, num_3b=%0d", inst1.num_2b, inst1.num_3b);
        end
		
		$display("test, con_mode(0)");
		inst1.c1.constraint_mode(0);
		repeat(inst1.repeat_times) begin
			inst1.randomize();
			$display("num_2b=%0d, num_3b=%0d", inst1.num_2b, inst1.num_3b);
        end
		
		$display("test, 1");  // back to default. rand_mode on, constraint_mode on
		inst1.num_2b.rand_mode(1);
		inst1.c1.constraint_mode(1);
		repeat(inst1.repeat_times) begin
			inst1.randomize();
			$display("num_2b=%0d, num_3b=%0d", inst1.num_2b, inst1.num_3b);
        end
		
		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule