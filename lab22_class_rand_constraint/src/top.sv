/*
	lab22, sv_lrm2017 ch18
	num_4b is fix
*/

module top;
	class C;
		integer repeat_times;
		rand bit [1:0] num_2b; //0~3
		rand bit [2:0] num_3b; //0~7
		bit [3:0] num_4b;
		
		function new (); //constructor
			//repeat_times = 5;
			this.repeat_times = 5;
		endfunction
		
		// built-in function randomize, sv_lrm2017 G.5
		// function void randomize( ... );   //casting, void'(inst1.randomize());
		// function int randomize( ... ); 
		//		a...
		//		b...
		// endfunction
	endclass
	
	C inst1 = new();
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
	
        repeat(inst1.repeat_times) begin  //repeat(5)
			inst1.randomize();
			$display("num_2b=%0d, num_3b=%0d, num_4b=%0d", inst1.num_2b, inst1.num_3b, inst1.num_4b);
        end

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule
//////////////////////////////////////

/*
//verification scheme

module top;
	logic [1:0] data;
	logic result;
	
	// class based
	program tb(
		output [1:0] data,
		input result
	);
		class C;
			rand [1:0] num_2b;
		endclass
		
		C inst1 = new();
		assign data = num_2b;
		// test pattern. sequence
		// random pattern, as below
		initial begin
			#10;
			inst1.randomize();
			if(result==1)
				$display("dut verification pass.")
			else
				$error("dut verification fail.")
			#10;
			inst1.randomize();
			if(result==1)
				$display("dut verification pass.")
			else
				$error("dut verification fail.")
			#10;
			inst1.randomize();
			//...
		end

		// fix pattern, below
		initial begin
			#10;
			data = 2'd0;
			#10;
			data = 2'd1;
			#10;
			data = 2'd2;
			//...
		end
	endprogram
	
	// design
	module dut(
		input [1:0] data,
		output result  //1:pass, 0:fail
	);
	endmodule
endmodule
*/