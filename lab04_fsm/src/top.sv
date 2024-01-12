module top;
    logic clk;
    logic rst_n;     //reset flip-flop
    logic start_fsm; //to trigger fsm
    logic [1:0] cs_fsm;    //current state of fsm

    logic bit_sel  = cs_fsm[1];   //index
    logic part_sel = cs_fsm[1:0]; //slice

    clkgen #(.HALF_PERIOD(5)) inst_clkgen(
        .clk(clk)
    );

    // design
    design_fsm inst_design_fsm (
        .*
    );

    // test program
    test_program inst_test_program (
        .*
    );
	
	initial begin
		$dumpfile("top.vcd");
		$dumpvars;
    end
endmodule

