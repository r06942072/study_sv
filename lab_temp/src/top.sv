/*
	lab??
*/
module top;
	bit clk;    //clock
	logic sig1; //signal 1
	
	always #5 clk = ~clk; //clock with period 10sec
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule