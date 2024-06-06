/*
	lab32, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
	
	sv_lrm2017 16.9.2
		Compare a2_design4 and a3_design4, to clarify between [*] and [->]
		Compare a3_design5 and a4_design5, to clarify between [->] and [=]
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start = 0; 
    bit x1, y1; //design1, x   ##1 x    ##1 y
    bit x2, y2; //design2, x   ##1 x    ##1 x    ##1 y
    bit x3, y3; //design3, x&y ##1 x&y  ##1 y
    bit x4, y4; //design4, x   ##1 null ##1 x    ##1 y
    bit x5, y5; //design5, x   ##1 null ##1 null ##1 x ##1 null ##1 y
    bit x6, y6; //design6, x   ##1 null ##1 null ##1 x ##1 null

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
            begin
                @(posedge clk);
                @(posedge clk);
                x2 = 1;
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                x2 = 0;
                y2 = 1;
                @(posedge clk);
                y2 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x3 = 1;
                y3 = 1;
                @(posedge clk);
                @(posedge clk);
                x3 = 0;
                @(posedge clk);
                y3 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x4 = 1;
                @(posedge clk);
                x4 = 0;
                @(posedge clk);
                x4 = 1;
                @(posedge clk);
                y4 = 1;
                x4 = 0;
                @(posedge clk);
                y4 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x5 = 1;
                @(posedge clk);
                x5 = 0;
                @(posedge clk);
                @(posedge clk);
                x5 = 1;
                @(posedge clk);
                x5 = 0;
                @(posedge clk);
                y5 = 1;
                @(posedge clk);
                y5 = 0;
            end
            begin
                @(posedge clk);
                @(posedge clk);
                x6 = 1;
                @(posedge clk);
                x6 = 0;
                @(posedge clk);
                @(posedge clk);
                x6 = 1;
                @(posedge clk);
                x6 = 0;
                @(posedge clk);
            end
       join
	   #100;
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
    sequence s1(x, y);
        (x ##1 x ##1 y); 
    endsequence

    sequence s2(x, y);
        (x[*2] ##1 y);  // x[*2] is equal to (x ##1 x) sv_lrm 2017 16.9.2 consecutive
    endsequence

    sequence s3(x, y);
        (x[->2] ##1 y);  // sv_lrm2017 16.9.2 goto_repetition
    endsequence

    sequence s4(x, y);
        (x[=2] ##1 y);  // sv_lrm2017 16.9.2 non-consecutive_repetition
    endsequence

    a1_design1: assert property(@(posedge clk) start |=> s1(x1, y1));  //pass
    a1_design2: assert property(@(posedge clk) start |=> s1(x2, y2));  //fail
    a1_design3: assert property(@(posedge clk) start |=> s1(x3, y3));  //pass

    a2_design1: assert property(@(posedge clk) start |=> s2(x1, y1));  //pass
    a2_design2: assert property(@(posedge clk) start |=> s2(x2, y2));  //fail
    a2_design3: assert property(@(posedge clk) start |=> s2(x3, y3));  //pass
    a2_design4: assert property(@(posedge clk) start |=> s2(x4, y4));  //fail

    a3_design1: assert property(@(posedge clk) start |=> strong( s3(x1, y1) ));  //pass
    a3_design4: assert property(@(posedge clk) start |=> strong( s3(x4, y4) ));  //pass
    a3_design5: assert property(@(posedge clk) start |=> strong( s3(x5, y5) ));  //fail

    a4_design5: assert property(@(posedge clk) start |=> strong( s4(x5, y5) ));  //pass
    a4_design6: assert property(@(posedge clk) start |=> strong( s4(x6, y6) ));  //fail
endmodule
/*
//
module VTOP;
	//module_name instance_name
	fr_cnt U1(); //16
	fr_cnt #(.CNT_WIDTH(12)) U2();
	//bind <module_dut> <module_sva> <inst_name>
	bind fr_cnt fr_cnt_chkr SV_CHKR1(.*);
endmodule

//SOFT IP
module fr_cnt(
	output sig3
);
	parameter CNT_WIDTH = 16;
	
	//design 
	logic [CNT_WIDTH-1: 0] sig1;
	logic sig2;
	
	assign sig3 = (|sig1) && sig2;
	fr_cnt_chkr SV_CHKR1(.*);
endmodule

checker fr_cnt_chkr;
	//verification
	a1: assert(sig1 == sig2);
endchecker

///////////////////////////////////
hier tree
test
	my_dut
		my_assert
	my_dut2
		my_assert
test2
	my_dut
		my_assert

module test
	dut my_dut;
module test2;
	dut my_dut;
*/

//5ns, 15ns, 25ns, 35ns ....
//x1: 0, 0, 1, 1, 0  x1 ##1 x1
//y1: 0, 0, 0, 0