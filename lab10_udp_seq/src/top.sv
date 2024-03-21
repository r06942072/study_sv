/*
	lab10
	sv_lrm2017 29.7 seq udp
		input: current_state: output
	
*/
primitive my_dff1 (q, clk, d); //not complete, falling edge, bug
    output q; reg q;
    input clk, d;
    table
        //clk d: current q: next q+
        (01) 0: ?: 0;  //? = 0, 1, and x
        (01) 1: ?: 1;
    endtable
endprimitive

primitive my_dff2 (q, clk, d);
    output q; reg q;
    input clk, d;
    table
        //clk d: current q: next q+
        (01) 0: ?: 0; //rising edge
        (01) 1: ?: 1; //rising edge
        (10) ?: ?: -; //falling edge, - no change
    endtable
endprimitive

primitive my_dff3 (q, clk, d);
    output q; reg q;
    input clk, d;
    table
        //clk d: current q: next q+
        r 0: ?: 0; //rising edge
        r 1: ?: 1; //rising edge
        f ?: ?: -; //falling edge, - no change
    endtable
endprimitive

module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec
	
	logic d;
    logic q1;
    logic q2;
    logic q3;
	
	my_dff1 inst_my_dff1(q1, clk, d);
    my_dff2 inst_my_dff2(q2, clk, d);
    my_dff3 inst_my_dff3(q3, clk, d);
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
		
		d = 0;
		@(posedge clk);
		@(negedge clk);
		d = 1;
		@(posedge clk);
		@(negedge clk);
		#10;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule