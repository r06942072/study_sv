/*
	lab33, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
	
	sv_lrm2017 16.9.2 *0
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start = 0; 
    bit x1, y1, z1; //design
    bit x2, y2, z2; //design
    bit x3, y3, z3; //design
    bit x4, y4, z4; //design

    bit x11, y11, z11; //design
    bit x12, y12, z12; //design
    bit x13, y13, z13; //design
    bit x14, y14, z14; //design
    bit x15, y15, z15; //design

    bit x21, y21, z21; //design
    bit x22, y22, z22; //design
    bit x23, y23, z23; //design
    bit x24, y24, z24; //design
    bit x25, y25, z25; //design

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
                y1 = 1;
                @(posedge clk);
                y1 = 0;
                z1 = 1;
                @(posedge clk);
                z1 = 0;
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
                z2 = 1;
                @(posedge clk);
                z2 = 0;
            end
            begin: design3
                @(posedge clk);
                @(posedge clk);
                x3 = 1;
                @(posedge clk);
                @(posedge clk);
                x3 = 0;
                y3 = 1;
                @(posedge clk);
                y3 = 0;
                z3 = 1;
                @(posedge clk);
                z3 = 0;
            end
            begin: design4
                @(posedge clk);
                @(posedge clk);
                x4 = 1;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                x4 = 0;
                y4 = 1;
                @(posedge clk);
                y4 = 0;
                z4 = 1;
                @(posedge clk);
                z4 = 0;
            end
            begin: design11
                @(posedge clk);
                @(posedge clk);
                x11 = 1;
                @(posedge clk);
                x11 = 0;
                z11 = 1;
                @(posedge clk);
                z11 = 0;
            end
            begin: design12
                @(posedge clk);
                @(posedge clk);
                x12 = 1;
                @(posedge clk);
                x12 = 0;
                @(posedge clk);
                z12 = 1;
                @(posedge clk);
                z12 = 0;
            end
            begin: design13
                @(posedge clk);
                @(posedge clk);
                x13 = 1;
                @(posedge clk);
                x13 = 0;
                y13 = 1;
                @(posedge clk);
                y13 = 0;
                z13 = 1;
                @(posedge clk);
                z13 = 0;
            end
            begin: design14
                @(posedge clk);
                @(posedge clk);
                x14 = 1;
                @(posedge clk);
                x14 = 0;
                y14 = 1;
                @(posedge clk);
                @(posedge clk);
                y14 = 0;
                z14 = 1;
                @(posedge clk);
                z14 = 0;
            end
            begin: design15
                @(posedge clk);
                @(posedge clk);
                x15 = 1;
                @(posedge clk);
                x15 = 0;
                y15 = 1;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                y15 = 0;
                z15 = 1;
                @(posedge clk);
                z15 = 0;
            end
            begin: design21
                @(posedge clk);
                @(posedge clk);
                x21 = 1;
                @(posedge clk);
                x21 = 0;
                y21 = 1;
                @(posedge clk);
                y21 = 0;
            end
            begin: design22
                @(posedge clk);
                @(posedge clk);
                x22 = 1;
                @(posedge clk);
                x22 = 0;
                y22 = 1;
                @(posedge clk);
                y22 = 0;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                z22 = 1;
                @(posedge clk);
                z22 = 0;
            end
            begin: design23
                @(posedge clk);
                @(posedge clk);
                x23 = 1;
                @(posedge clk);
                x23 = 0;
                y23 = 1;
                @(posedge clk);
                y23 = 0;
                z23 = 1;
                @(posedge clk);
                z23 = 0;
            end
            begin: design24
                @(posedge clk);
                @(posedge clk);
                x24 = 1;
                @(posedge clk);
                x24 = 0;
                y24 = 1;
                @(posedge clk);
                y24 = 0;
                z24 = 1;
                @(posedge clk);
                @(posedge clk);
                z24 = 0;
            end
            begin: design25
                @(posedge clk);
                @(posedge clk);
                x25 = 1;
                @(posedge clk);
                x25 = 0;
                y25 = 1;
                @(posedge clk);
                y25 = 0;
                z25 = 1;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                z25 = 0;
            end
        join
		#50;
        $display("----", $time, " ns, finish");
	    $finish;
    end

    sequence s1(x, y, z);
        (x[*0:2] ##1 y ##1 z); 
    endsequence

    sequence s2(x, y, z);
        (x ##1 y[*0:2] ##1 z); 
    endsequence

    sequence s3(x, y, z);
        (x ##1 y ##1 z[*0:2]); 
    endsequence
	
    a1_design1:  assert property(@(posedge clk) start |=> s1(x1, y1, z1));  
    a1_design2:  assert property(@(posedge clk) start |=> s1(x2, y2, z2));  
    a1_design3:  assert property(@(posedge clk) start |=> s1(x3, y3, z3));  
    a1_design4:  assert property(@(posedge clk) start |=> s1(x4, y4, z4)); //fail 

    a2_design11: assert property(@(posedge clk) start |=> s2(x11, y11, z11)); 
    a2_design12: assert property(@(posedge clk) start |=> s2(x12, y12, z12));  //fail 
    a2_design13: assert property(@(posedge clk) start |=> s2(x13, y13, z13)); 
    a2_design14: assert property(@(posedge clk) start |=> s2(x14, y14, z14)); 
    a2_design15: assert property(@(posedge clk) start |=> s2(x15, y15, z15));  //fail

    a3_design21: assert property(@(posedge clk) start |=> s3(x21, y21, z21)); 
    a3_design22: assert property(@(posedge clk) start |=> s3(x22, y22, z22)); 
    a3_design23: assert property(@(posedge clk) start |=> s3(x23, y23, z23)); 
    a3_design24: assert property(@(posedge clk) start |=> s3(x24, y24, z24)); 
    a3_design25: assert property(@(posedge clk) start |=> s3(x25, y25, z25)); 
endmodule