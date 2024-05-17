/*
	lab35, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start = 0; 
    bit x1, y1, z1;

    initial begin
		$dumpfile("top.vcd"); $dumpvars;
        fork
            begin
                @(posedge clk);
                x1 = 1;
                @(posedge clk);
                x1 = 0;
                y1 = 1;
                @(posedge clk);
                z1 = 1;
                @(posedge clk);
                y1 = 0;
                z1 = 0;
            end
        join
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    sequence s1;
        x1 ##[1:2] y1;
    endsequence

    sequence s1_fm;
        first_match(x1 ##[1:2] y1);
    endsequence

    a1:    assert property(@(posedge clk) s1    |=> z1); //fail
    a1_fm: assert property(@(posedge clk) s1_fm |=> z1); //pass
endmodule