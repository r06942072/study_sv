/*
	lab22, sv_lrm ch18
	num_4b is fix
*/

module top;
	class C;
		integer repeat_times;
		rand bit [1:0] num_2b; //rand_mode
		rand bit [2:0] num_3b; //constraint_mode
		bit [3:0] num_4b;
		
		function new (); //constructor
			this.repeat_times = 5;
		endfunction

	endclass
	
	C inst1 = new();
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
	
        repeat(inst1.repeat_times) begin
			inst1.randomize();
			$display("num_2b=%0d, num_3b=%0d, num_4b=%0d", inst1.num_2b, inst1.num_3b, inst1.num_4b);
        end

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule