/*
	lab30
*/
module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec
	
	//todo
endmodule