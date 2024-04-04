/*
	lab18, sv_lrm2017 9.6.3 disable fork
*/
module top;
    string case1 = "case1";
	initial begin
        fork
            case1_1(); //1ns
            case1_2(); //2ns
        join_none
        fork
            case1_1(); //1ns
            case1_3(); //3ns
        join_none
        #10;
        $display("--------", $time, " ns, ", case1, ", finish");
    end
    task case1_1();
        #1;
        $display("--------", $time, " ns, ", case1, ", case1_1");
    endtask
    task case1_2();
        #2;
        $display("--------", $time, " ns, ", case1, ", case1_2");
    endtask
    task case1_3();
        #3;
        $display("--------", $time, " ns, ", case1, ", case1_3");
    endtask
	///////////////////////////////////////////////////////////////////
    string case2 = "case2";
    initial begin
        fork
            case2_1(); //1ns
            case2_2(); //2ns
        join_none
        fork
            case2_1(); //1ns
            case2_3(); //3ns
        join_none
        disable fork;
        #10;
        $display("%0d", $time, " ns, ", case2, ", finish");
    end
    task case2_1();
        #1;
        $display("%0d", $time, " ns, ", case2, ", case2_1");
    endtask
    task case2_2();
        #2;
        $display("%0d", $time, " ns, ", case2, ", case2_2");
    endtask
    task case2_3();
        #3;
        $display("%0d", $time, " ns, ", case2, ", case2_3");
    endtask
	
endmodule

////////////////////////////////
//module top;
//	bit signal = 0;
	//initial begin
//		#10;
//		wait(signal);
//		$display("hello now");
	//end
	//initial begin
//		#20;
		//signal = 1;
	//end
//endmodule