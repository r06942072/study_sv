/*
	lab08
	sv_lrm2017
*/
module top;
	bit clk;    //clock
	logic sig1; //signal 1
	
	always #5 clk = ~clk; //clock with period 10sec

	generate
        for (genvar i=0; i<2; i=i+1) begin: gen
            sub inst_sub();
        end
    endgenerate
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

module sub;
	bit sig_in_sub;
endmodule