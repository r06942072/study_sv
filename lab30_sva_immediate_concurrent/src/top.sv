/*
	lab30, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
		a1 is immediate, comb logic
		a2 is concurrent, seq logic
*/
module top;
	logic a, not_a;
	assign not_a = !a; 
	
	always_comb begin
		a1: assert #0 (not_a != a);  
		//a1_fail: assert #0 (not_a == a);  
	end
	
	initial begin	
		a = 1;
		#1;
		a = 0;
		#1;
	end
	//////////////////////////////////////////////////////////////
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	bit sig1;
	initial begin
		repeat (2) begin
			@(posedge clk);
		end
		sig1 = 1;
		@(posedge clk);
		sig1 = 0;
	end
	
	//expectation: pulse width is one clock cycle
	a2: assert property(@(posedge clk) sig1 |=> ~sig1);
	/*
	The alternative way to write as below:
		property p_one_cycle;
			sig1 |=> ~sig1
		endproperty
	
		a3: assert property(@(posedge clk) p_one_cycle);
	*/
	
	/*
	The alternative way to write as below:
		sequence s1;
			sig1;
		endsequence
		
		sequence s2;
			~sig1 ##1 sig1 [*2] sig2;
		endsequence
		
		property p_one_cycle;
			s1 |=> s2
		endproperty
	
		a3: assert property(@(posedge clk) p_one_cycle);
	*/
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars;
		#100;
		$display("at time = %5d, ", $time, " end of the sim");
		$finish;
	end
endmodule

//architecture of concurrent assertion
//assert/assume/cover	
//		property
//				sequence


//assert/assume/cover	clk
//		property
//				sequence

//consecutive
//sig1 [*3] sig2;
//sig1 ##1 sig2 ##1 sig2 ##1 sig2;
// 
//sig1 ##3 sig2