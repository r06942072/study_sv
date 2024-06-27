/*
	lab35, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start; 
    bit x1, y1, exp1; //design1
    bit x2, y2, exp2;
    bit x3, y3, exp3;
    bit x4, y4, exp4;
    bit x5, y5, exp5;

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
                exp1 = 1;
                x1 = 1;
                @(posedge clk);
                x1 = 0;
                y1 = 1;
                @(posedge clk);
                exp1 = 0;
                y1 = 0;
            end
            begin
                @(posedge clk);
                exp2 = 1;
                @(posedge clk);
                x2 = 1;
                @(posedge clk);
                x2 = 0;
                y2 = 1;
                @(posedge clk);
                y2 = 0;
                @(posedge clk);
                exp2 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                exp3 = 1;
                x3 = 1;
                @(posedge clk);
                exp3 = 0;
                x3 = 0;
                y3 = 1;
                @(posedge clk);
                y3 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x4 = 1;
                @(posedge clk);
                x4 = 0;
                y4 = 1;
                @(posedge clk);
                y4 = 0;
            end
            begin
                #20;
                exp4 = 1;
                #15;
                exp4 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                exp5 = 1;
                x5 = 1;
                @(posedge clk);
                x5 = 0;
                @(posedge clk);
                y5 = 1;
                @(posedge clk);
                y5 = 0;
            end
        join
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    sequence s1(x, y);
        (x ##1 y);  //need to sample twice.  two sample points
    endsequence

    a_design1: assert property(@(posedge clk) start |=> exp1 throughout s1(x1, y1));  //pass
    a_design2: assert property(@(posedge clk) start |=> exp2 throughout s1(x2, y2));  //pass, exp2 long
    a_design3: assert property(@(posedge clk) start |=> exp3 throughout s1(x3, y3));  //fail, beacuse exp3 is too short
    a_design4: assert property(@(posedge clk) start |=> exp4 throughout s1(x4, y4));  //pass, exp4 async, exp4 need to be true in all sample points of sequence1
    a_design5: assert property(@(posedge clk) start |=> exp5 throughout s1(x5, y5));  //fail, seq not match, so not related to exp5
	
	a_design6: assert property(@(posedge clk) start |=> s1(x5, y5));  //fail
	
	// exp1[*0:$] intersect s1(x1, y1)
	
	//exp throughout seq
	//		expression must be true during the sequence
endmodule