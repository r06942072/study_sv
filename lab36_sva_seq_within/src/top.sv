/*
	lab36, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start; 
    bit x1, y1, z1; //design1
    bit x2, y2, z2; 
    bit x3, y3, z3; 
    bit x4, y4, z4; 

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
                y1 = 1;
                @(posedge clk);
                x1 = 0;
                y1 = 0;
                z1 = 1;
                @(posedge clk);
                z1 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                y2 = 1;
                @(posedge clk);
                x2 = 1;
                y2 = 0;
                z2 = 1;
                @(posedge clk);
                z2 = 0;
                x2 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                y3 = 1;
                @(posedge clk);
                y3 = 0;
                z3 = 1;
                @(posedge clk);
                z3 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                y4 = 1;
                @(posedge clk);
                z4 = 1;
                @(posedge clk);
                y4 = 0;
                z4 = 0;
            end
        join
		#30;
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    sequence s1(x);
        x; 
    endsequence
    sequence s2(y, z);
        (y && ~z ##1 ~y && z);  //2 sample points
    endsequence

    a_design1: assert property(@(posedge clk) start |=> s1(x1) within s2(y1, z1)); //pass
    a_design2: assert property(@(posedge clk) start |=> s1(x2) within s2(y2, z2)); //pass
    a_design3: assert property(@(posedge clk) start |=> s1(x3) within s2(y3, z3)); //fail, because x3 never be 1 within s2 interval
    a_design4: assert property(@(posedge clk) start |=> s1(x4) within s2(y4, z4)); //fail, because s2 not match
	
	//summary, seq1(short) within seq2(long)
endmodule

//3 + 4
//seq1 <opeartor> seq2