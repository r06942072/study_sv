/*
	lab30,
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
	a1 is immediate
	a2 is concurrent
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
	
	a2: assert property(@(posedge clk) sig1 |=> ~sig1);
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars;
		#100;
		$display("at time = %5d, ", $time, " end of the sim");
		$finish;
	end
endmodule