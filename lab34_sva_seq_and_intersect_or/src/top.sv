/*
	lab34, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start;
    bit x1, y1; //design1, x ##1 y
    bit x2, y2; //design2, x ##2 y
    bit x3, y3; //design3, x ##3 y
    bit x4, y4; //design4, x and y no vc, tie0
    bit x5, y5; //design5, y no vc

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
                x1 = 0;
                y1 = 1;
                @(posedge clk);
                y1 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x2 = 1;
                @(posedge clk);
                x2 = 0;
                @(posedge clk);
                y2 = 1;
                @(posedge clk);
                y2 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x3 = 1;
                @(posedge clk);
                x3 = 0;
                @(posedge clk);
                @(posedge clk);
                y3 = 1;
                @(posedge clk);
                y3 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x5 = 1;
                @(posedge clk);
                x5 = 0;
            end
       join
	   #50;
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    sequence s1;
        x1 ##1 y1; 
    endsequence
    sequence s2;
        x2 ##2 y2; 
    endsequence
    sequence s3;
        x3 ##3 y3; 
    endsequence
    sequence s4;
        x4 ##1 y4; 
    endsequence
    sequence s5;
        x5 ##1 y5; 
    endsequence

    a_and_1:  assert property(@(posedge clk) start |=> s1 and s2);  //pass
    a_and_2:  assert property(@(posedge clk) start |=> s2 and s1);  //pass
    a_and_3:  assert property(@(posedge clk) start |=> s1 and s2 and s3); //pass
    a_and_4:  assert property(@(posedge clk) start |=> s1 and s4); //fail

    a_intersect_1:  assert property(@(posedge clk) start |=> s1 intersect s2); //fail

    a_or_1:  assert property(@(posedge clk) start |=> s1 or s4); //pass
    a_or_2:  assert property(@(posedge clk) start |=> s1 or s2 or s3 or s4); //pass
    a_or_3:  assert property(@(posedge clk) start |=> s4 or s5); //fail
endmodule