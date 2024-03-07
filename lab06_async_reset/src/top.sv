/*
	lab06
	sync reset: 
		CLK takes priority over RESET
		RESET condition checked after the clock edge 
	async reset:
		RESET takes priority over CLK
		RESET condition checked before the clock edge
		RESET added to sensitivity list
*/
module top;
	bit clk;
	always #5 clk = ~clk; //clock with period 10sec
	bit reset;
	
	logic [1:0] q1; 
	logic [1:0] q2; 
	
	logic [1:0] d; //data
	
	always @(posedge clk) begin 
		if (reset)  //sync reset
			q1 <= 2'd0;
		else 
			q1 <= d;
	end

	always @(posedge clk, posedge reset) begin //async reset
		if (reset)
			q2 <= 2'd0;
		else
			q2 <= d;
	end	
	
    initial begin //100
        $dumpfile("top.vcd");
		$dumpvars;
		#100;
		$display("at time = ", $time, " end of the sim");
		$finish;    
    end
	initial begin //49
		#12;
		reset = 1;
		#37;
		reset = 0;
	end
	initial begin //52
		#32;
		d = 2'd2;
		#20;
		d = 2'd3;
	end
endmodule

/*
The alternative of three initial begin-end block

initial begin //sequential block
	fork //parallel 
		begin: block1
		end
		begin: block2
		end
		begin: block3
		end
	join
	join-any
	join-none
end

*/