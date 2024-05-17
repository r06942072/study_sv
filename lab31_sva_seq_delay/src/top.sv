/*
	lab31, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
	
	sv_lrm2017 16.7 sva sequence delay
		use assertion1 to verify design1
		use assertion1 to verify design2
		use assertion2 to verify design1
		use assertion2 to verify design2
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
	bit start = 0; 
    bit x1, y1; //design1, x ##2 y
    bit x2, y2; //design2, x ##1 y
    bit x3, y3; //design3, x ##0 y  
    initial begin
		$dumpfile("top.vcd"); $dumpvars;
        fork
            begin
                @(posedge clk);
                start = 1;
                @(posedge clk);
                start = 0;
            end
            begin: design1
                @(posedge clk);
                @(posedge clk);
                x1 = 1;
                @(posedge clk);
                x1 = 0;
                @(posedge clk);
                y1 = 1;
                @(posedge clk);
                y1 = 0;
				@(posedge clk);
				@(posedge clk);
            end
            begin: design2
                @(posedge clk);
                @(posedge clk);
                x2 = 1;
                @(posedge clk);
                x2 = 0;
                y2 = 1;
                @(posedge clk);
                y2 = 0;
            end
            begin: design3
                @(posedge clk);
                @(posedge clk);
                x3 = 1;
                y3 = 1;
                @(posedge clk);
                x3 = 0;
                y3 = 0;
            end
        join
		$display("----", $time, " ns,  finish");
		$finish;
    end
		
	sequence s1(x, y); //sv_lrm2017 16.8.1 formal argument in seq
        (x ##2 y); 
    endsequence
    sequence s2(x, y);
        (x ##[2:3] y); //same as (x ##2 y) or (x ##3 y)
    endsequence
	sequence s3(x, y);
        x ##[0:$] y; 
    endsequence
    sequence s4(x, y);
        x ##[*] y; // ##[*] is eq to ##[0:$]
    endsequence
    sequence s5(x, y);
        x ##[1:$] y; 
    endsequence
    sequence s6(x, y);  
        x ##[+] y; // ##[+] is eq to ##[1:$]
    endsequence
	
    a1_design1: assert property(@(posedge clk) start |=> s1(x1, y1)); //pass
    a2_design1: assert property(@(posedge clk) start |=> s2(x1, y1)); //pass

    a1_design2: assert property(@(posedge clk) start |=> s1(x2, y2)); //fail
    a2_design2: assert property(@(posedge clk) start |=> s2(x2, y2)); //fail
	
    a3_design3: assert property(@(posedge clk) start |=> strong( s3(x3, y3) )); //pass
    a4_design3: assert property(@(posedge clk) start |=> strong( s4(x3, y3) )); //pass
    a5_design3: assert property(@(posedge clk) start |=> strong( s5(x3, y3) )); //fail
    a6_design3: assert property(@(posedge clk) start |=> strong( s6(x3, y3) )); //fail	
endmodule

//
//assert 
//	property
//		sequence