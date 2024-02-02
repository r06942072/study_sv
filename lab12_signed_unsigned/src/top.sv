/*
	lab12
	sv_lrm2017 11.7 signed addition
	to test -1 + 3 = 2, pass or fail
	
	MSB
		zero extension
		signed extension
*/
module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec

	//case1, not often, because user need to specify "signed" in var declare
	logic signed [2:0] sig1 = -1; //signal 1
	logic signed [2:0] sig2 = 3;
	logic signed [3:0] sig3;
	assign sig3 = sig1 + sig2; 
	
	//case2
	logic  [2:0] sig4 = -1;  //default unsigned, so resolved as 'd7 not 'd-1
	logic  [2:0] sig5 = 3;
	logic  [3:0] sig6; //'d10
	assign sig6 = sig4 + sig5;
	
	//case3
	logic  [2:0] sig7 = -1; 
	logic  [2:0] sig8 = 3;
	logic  [3:0] sig9;
	assign sig9 = $signed(sig7) + $signed(sig8);	

	//case4, zero extension
	logic  [2:0] sig10 = -1;  //default unsigned, so resolved as 'd7 not 'd-1
	logic  [1:0] sig11 = 3;
	logic  [3:0] sig12;
	assign sig12 = sig10 + sig11;
	
	//case5, signed extension
	logic  [2:0] sig13 = -1; 
	logic  [1:0] sig14 = -1;
	logic  [3:0] sig15;
	assign sig15 = $signed(sig13) + $signed(sig14);
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule