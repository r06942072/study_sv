/*
	lab??, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
	
	sv_lrm2017 ???
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start = 0; 
    bit x1, y1; //design1, x ##1 x ##1 y

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
                y1 = 1;
                @(posedge clk);
                y1 = 0;
            end
       join
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    sequence s1(x, y);
        (x ##1 x ##1 y); 
    endsequence
 
    a1_design1: assert property(@(posedge clk) start |=> s1(x1, y1));  //pass
endmodule