/*
	lab07.
		driver --> load
		(testbench is responsible to give testcases. op1 + op2)
			task1 
				top.tb.operand1 --> top.signal1 --> top.dut.operand1
				top.tb.operand2 --> top.signal2 --> top.dut.operand2
			task2
				top.dut.ans     --> top.ans     --> top.tb.ans   
		(testbench verifiy the answer by wait statement)
*/
module top;
	bit clk;    //clock
	logic       signal1;
	logic       signal2;
	logic [1:0] ans;
	always #5 clk = ~clk; //clock with period 10sec
	
	//verification
	//syntax: module instance_name
	testbench tb(
		.operand1(signal1),
		.operand2(signal2),
		.ans(ans)
	); 
	
	//design under test
	//syntax: module instance_name
	adder dut(    
		.operand1(signal1),   //.port_name (signal_name)
		.operand2(signal2),
		.ans(ans)
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