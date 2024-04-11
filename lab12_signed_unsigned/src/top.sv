/*
	lab12
	sv_lrm2017 11.7 signed addition or unsigned addition
	to test 2 = -1 + 3, pass or fail

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
	assign sig3 = sig1 + sig2;   //'d2
	
	//case2, unsigned addition
	logic  [2:0] sig4 = -1;  //default unsigned, so resolved as 'd7 not 'd-1
	//logic  [2:0] sig4 = 7;
	logic  [2:0] sig5 = 3;
	logic  [3:0] sig6; //'d10
	assign sig6 = sig4 + sig5;   //'d10
	
	//case3, recommended when doing DSP operations
	logic  [2:0] sig7 = -1; 
	logic  [2:0] sig8 = 3;
	logic  [3:0] sig9;
	assign sig9 = $signed(sig7) + $signed(sig8);	//'d2

	//case4, zero extension on sig11, because "+" at line37 is unsigned addition
	logic  [2:0] sig10 = -1;  //default unsigned, so resolved as 'd7 not 'd-1
	logic  [1:0] sig11 = 3;   //zero extension
	logic  [3:0] sig12;
	assign sig12 = sig10 + sig11;  //'d10
	
	//case5, signed extension on sig14
	logic  [2:0] sig13 = -1;  //'b111
	logic  [1:0] sig14 = -1;  //'b11  -> 'b111
	logic  [3:0] sig15;        
	assign sig15 = $signed(sig13) + $signed(sig14); //'b1110
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

//////
