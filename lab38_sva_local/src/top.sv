/*
	lab38, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
	Serial-in parallel-out (SIPO)
*/
module top;
  	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec	
	//////////////////////////////////////////////////////
    bit start; 
    bit serial_in;  //actual value, design 串列傳輸
    localparam [3:0] exp_val1 = 4'b1010;  //expect value
    localparam [3:0] exp_val2 = 4'b1011;  //expect value

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
                serial_in = 1;
                @(posedge clk);
                serial_in = 0;
                @(posedge clk);
                serial_in = 1;
                @(posedge clk);
                serial_in = 0;
            end
        join
		#30;
       $display("----", $time, " ns, finish");
	   $finish;
    end
	
	property p1;
        int index;
        logic [3:0] val;   //val[3], val[2], val[1], val[0]
        (start, index=3) |=> (1'b1, val[index]=serial_in, $display("in p1, index=%0d", index, " val[3:0]=", val[3], val[2], val[1], val[0]), index--) [*4] 
        ##1 val==exp_val1;
    endproperty
	
    property p2;
        int index;
        logic [3:0] val;
        (start, index=3) |=> (1'b1, val[index]=serial_in, index--) [*4]
        ##1 val==exp_val2;
    endproperty

    a1: assert property(@(posedge clk) p1); //pass, 1010 =  1010
    a2: assert property(@(posedge clk) p2); //fail, 1010 != 1011
endmodule

//         seq1 |=> seq2
// 		   start |=> 1'b1 ##1 1'b1 ##1 1'b1 ##1 1'b1 ##1 1'b1 ##1 val==exp_val1;
//
//        (start, index=3) |=> (1'b1, val[index]=serial_in, $display("in p1, index=%0d", index, " val[3:0]=", val[3], val[2], val[1], val[0]), index--) [*4] 
//        ##1 val==exp_val1;

////// sim result
//
//    in p1, index=3 val[3:0]=1xxx
//    in p1, index=2 val[3:0]=10xx
//    in p1, index=1 val[3:0]=101x
//    in p1, index=0 val[3:0]=1010