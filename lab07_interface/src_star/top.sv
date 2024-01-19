/*
	lab07
*/
module top;
	bit clk;    //clock
	logic       operand1;
	logic       operand2;
	logic [1:0] ans;
	always #5 clk = ~clk; //clock with period 10sec
	
	testbench tb(
		.*
	); 
	adder dut(
		.*
	);
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

module testbench(
	output logic operand1,
	output logic operand2,
	input logic [1:0] ans
);
	initial begin
		operand1 = 0;
		operand2 = 0;
		wait(ans==2'd0);
		$display("at time = %0d", $time, ", test1 pass");
		
		#10;
		operand1 = 0;
		operand2 = 1;
		wait(ans==2'd1);
		$display("at time = %0d", $time, ", test2 pass");
		
		#10;
		operand1 = 1;
		operand2 = 0;
		wait(ans==2'd1);
		$display("at time = %0d", $time, ", test3 pass");
		
		#10;
		operand1 = 1;
		operand2 = 1;
		wait(ans==2'd2);
		$display("at time = %0d", $time, ", test4 pass");
	end
endmodule

module adder(
	input logic operand1,
	input logic operand2,
	output logic [1:0] ans
);
	assign ans = operand1 + operand2;
endmodule