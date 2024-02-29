module top;
    logic clk;
    logic rst_n;     //reset flip-flop
    logic start_fsm; //to trigger fsm
    logic [1:0] cs_fsm;    //current state of fsm, driver -> gate -> load

    clkgen #(.HALF_PERIOD(5)) inst_clkgen(   //instance
        .clk(clk)
    );
	
    // design
    design_fsm inst_design_fsm (
        .*
    );
    /* 
	//the following is the complete port connnection
	
	design_fsm inst_design_fsm (
        .port_name(signal_name),
    );
	
	design_fsm inst_design_fsm (
        .clk(clk),
		.rst_n(rst_n),
		.start_fsm(start_fsm),
		.cs_fsm(cs_fsm)
    );
	*/
	
    // test program
    test_program inst_test_program (
        .*
    );
	
	logic [3:0] total = 4'b0011; //total[3], total[2], total[1], total[0]
	logic bit_sel = total[1]; //1
	logic [1:0] part_sel = total[2:1]; //01
	logic [1:0] part_sel2 = total[5:4]; //xx, error case
	
	initial begin
		$dumpfile("top.vcd");
		$dumpvars;
    end
endmodule

