/*
	lab30,
	sim on edaplayground.com. tool = Cadence Xcelium 20.09
*/
module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec
	bit sig1;
	bit sig2;
  assert #0 (sig1 == sig2);
	//todo
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    #20;
	sig2 = 1;
	#20;
    $finish;
  end
endmodule