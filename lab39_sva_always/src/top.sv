/*
	lab39, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start; 
    bit x1; //design1
    bit x2; 
    bit x3; 

    initial begin
		$dumpfile("top.vcd"); $dumpvars;
       fork
            begin
                @(posedge clk);
                start = 1;
                @(posedge clk);
                start = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x1 = 1;
                @(posedge clk);
                @(posedge clk);
                x1 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x2 = 1;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                x2 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                x3 = 1;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                x3 = 0;
            end
        join
		#30;
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    property p1(x);
        start |=> always x;
    endproperty
    property p2(x);
        start |=> x;
    endproperty

    a1_design1: assert property(@(posedge clk) p1(x1)); //fail
    a1_design2: assert property(@(posedge clk) p1(x2)); //fail
    a1_design3: assert property(@(posedge clk) p1(x3)); //fail

    a2_design1: assert property(@(posedge clk) p2(x1)); //pass
    a2_design2: assert property(@(posedge clk) p2(x2)); //pass
    a2_design3: assert property(@(posedge clk) p2(x3)); //fail
endmodule