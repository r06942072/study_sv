/*
	lab07, this cannot be sim by iverilog, but can sim with xcelium
*/
module top;
	bit clk;    //clock

	always #5 clk = ~clk; //clock with period 10sec
	
	intf tb_dut_if();
	
	testbench tb(
		.this_intf(tb_dut_if.tb_mp)
	); 
	adder dut(
		.this_intf(tb_dut_if.dut_mp)
	);
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

interface intf();
	logic operand1;
	logic operand2;
	logic [1:0] ans;
	
	modport dut_mp(
		input operand1, operand2,
		output ans
	);
	
	modport tb_mp(
		output operand1, operand2,
		input ans
	);
endinterface

module testbench(
	intf.tb_mp this_intf
);
	initial begin
		this_intf.operand1 = 0;
		this_intf.operand2 = 0;
		wait(this_intf.ans==2'd0);
		$display("at time = %0d", $time, ", test1 pass");
		
		#10;
		this_intf.operand1 = 0;
		this_intf.operand2 = 1;
		wait(this_intf.ans==2'd1);
		$display("at time = %0d", $time, ", test2 pass");
		
		#10;
		this_intf.operand1 = 1;
		this_intf.operand2 = 0;
		wait(this_intf.ans==2'd1);
		$display("at time = %0d", $time, ", test3 pass");
		
		#10;
		this_intf.operand1 = 1;
		this_intf.operand2 = 1;
		wait(this_intf.ans==2'd2);
		$display("at time = %0d", $time, ", test4 pass");
	end
endmodule

module adder(
	intf.dut_mp this_intf
);
	assign this_intf.ans = this_intf.operand1 + this_intf.operand2;
endmodule