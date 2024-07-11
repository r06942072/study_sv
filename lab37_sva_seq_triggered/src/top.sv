/*
	lab37, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start; 
    bit x1, y1, z1; //design1
    bit x2, y2, z2; 

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
                @(posedge clk);
                z1 = 1;
                @(posedge clk);
                z1 = 0;
            end
            begin
                @(posedge clk);
                x2 = 1;
                @(posedge clk);
                x2 = 0;
                y2 = 1;
                @(posedge clk);
                y2 = 0;
                @(posedge clk);
                z2 = 1;
                @(posedge clk);
                z2 = 0;
            end
        join
		#30;
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
	sequence s0(x, y);
        x ##1 y; 
    endsequence

    sequence s1(sequence seq, bit sig);
        seq ##2 sig;
    endsequence

    sequence s2(sequence seq, bit sig);
        seq.triggered ##2 sig;
    endsequence

    a1_design1: assert property(@(posedge clk) start |=> s1(s0(x1, y1), z1)); //pass 
		//to decompose: 
		//	s1(s0(x1, y1), z1)
		//		s0(x1, y1) ##2 z1
		//			x1 ##1 y1 ##2 z1
		//          	start ##1 x1 ##1 y1 ##2 z1
    a1_design2: assert property(@(posedge clk) start |=> s1(s0(x2, y2), z2)); //fail
		//to decompose: 
		//				start ##1 x2 ##1 y2 ##2 z2
		//              start ##1 y2 ##2 z2  		--> pass
		
    a2_design1: assert property(@(posedge clk) start |=> s2(s0(x1, y1), z1)); //fail
		//to decompose: 
		//	s2(s0(x1, y1), z1)
		//  	s0(x1,y1).triggered ##2 z1
		//  		start ##1 (x1 ##1 y1).triggered ##2 z1
		
		//          timepoint = <15ns> <25ns>                    <35ns>  <45ns>
		//                      start  (x1 ##1 y1).triggered     none    z1
    a2_design2: assert property(@(posedge clk) start |=> s2(s0(x2, y2), z2)); //pass
		//to decompose: 
		//  		start ##1 (x2 ##1 y2).triggered ##2 z2
		
		//          timepoint = <15ns> <25ns>                    <35ns>  <45ns>
		//                      start  (x2 ##1 y2).triggered     none    z2
endmodule


/*
module top;
	int ans;
	
	
	initial begin
		ans = 6 + 2;
		ans = add(6, 2);
	end
	
endmodule
*/

/*
	sequence seqq;
		expression throughout (s1 and s2 intersect s3) ##1 sig==1 [*3] sig2==0;
	endsequence
*/