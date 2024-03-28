/*
	lab11, parameter
*/
module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec

	sub1 inst1_1(.clk(clk));
	sub1 inst1_2(.*);
	
	sub1 #(.pa(5)) inst1_3(.*);
	sub1 #(.pa(3)) inst1_4(.*);
	sub1 #(6) inst1_5(.*);
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

module sub1
#(parameter pa = 3)(
	input logic clk
);
	parameter p1 = 1;
	bit [pa-1:0] arr1; //array
	
	initial begin
		#10;
		arr1[0] = 1;
	end
endmodule
