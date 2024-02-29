/*
	lab05
*/
module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec

	logic [1:0] a = 2'd1; 
	logic [1:0] b = 2'd2;
	logic [1:0] c = 2'd3;

	logic [1:0] d = 2'd1; 
	logic [1:0] e = 2'd2;
	logic [1:0] f = 2'd3;
	
	//non-blocking, syntheizable code common
	always @(posedge clk) begin
		b <= a;  //b is 1
		c <= b;  //c is 2
    end
	
	//blocking, non-common
	always @(posedge clk) begin
		e = d; //e is 1
		f = e; //f is 1
    end
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;

		#20;
		$display("at time = ", $time, " end of the sim");
		$finish;    
    end
endmodule
//---------------------------------------------------------