module test_program(
    input logic clk,
    output logic rst_n,
    output logic start_fsm,
    input logic [1:0] cs_fsm
);

    initial begin
        $display("%0d", $time, " ns, start");
        rst_n = 0;
        start_fsm = 0; 
        #100;
        rst_n = 1;
        #100;
        start_fsm = 1;
        wait(cs_fsm == 2'd3); //LAST
        $display("%0d", $time, " ns, cs = LAST");
        start_fsm = 0;
        #100; 
        $display("%0d", $time, " ns, finish");
        $finish;
    end
endmodule
