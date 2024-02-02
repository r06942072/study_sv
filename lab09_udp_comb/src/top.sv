/*
	lab09
*/
module top;
	bit clk;    //clock
	logic a10, b10, out10;
	
	always #5 clk = ~clk; //clock with period 10sec
	my_comb_gate inst_my_comb_gate(out10, a10, b10);
	
    always_comb begin
		$display("at time = %0d", $time, ", a10, b10=", a10, ", ", b10);
    end
    always_comb begin
		$display("at time = %0d", $time, ", out10=", out10);
    end
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
        #1;
        a10 = 0;
        b10 = 0;
        #1;
        a10 = 0;
        b10 = 1;
        #1;
        a10 = 1;
        b10 = 0;
        #1;
        a10 = 1;
        b10 = 1;
        #1;
		#1;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

primitive my_comb_gate (
    output out10,
    input a10, 
    input b10
);
    table
        //a10, b10, out10
        0 0: 0;
        0 1: 1;
        1 0: 0;
        //1 1: ;   //not explict specified will drive an x output
    endtable
endprimitive