/*
	lab01
*/
module top;
	logic clk=0;   //clock
	logic sig1;  //signal 1
	
	always #10 clk = ~clk; //clock with period 20sec
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		//$dumpvars(0, top);
		
		$monitor("at time = ", $time, ", sig1 value is: ", sig1); // vc, value change
		sig1 = 0;
		#2; //delay 2 time unit
		sig1 = 1;
		
		$display("Hello world");
		#50;  //delay 50 time unit
		#1;
		#2;
		$display("at time = ", $time, " end of the file"); //2+50+1+2=55
		
		$finish;    
    end
endmodule
