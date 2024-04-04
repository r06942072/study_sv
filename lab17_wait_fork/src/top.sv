/*
	lab17, sv_lrm2017 9.6.1 wait fork
*/
module top;
    string case1 = "case1";
    initial begin
        fork
            case1_a(); //0ns
            case1_b(); //1ns
        join_none
        fork
            #5;       //5ns
        join_none
        $display("--------", $time, " ns, ", case1, ", finish");
    end
    task case1_a();
        $display("--------", $time, " ns, ", case1, ", case1_a");
    endtask
    task case1_b();
        #1;
        $display("--------", $time, " ns, ", case1, ", case1_b");
    endtask
	///////////////////////////////////////////////////////////////////
    string case2 = "case2";
    initial begin
        fork
            case2_a(); //0ns
            case2_b(); //1ns
        join_none
        fork
            #5;         //5ns
        join_none
        wait fork;
        $display("%0d", $time, " ns, ", case2, ", finish");
    end
    task case2_a();
        $display("%0d", $time, " ns, ", case2, ", case2_a");
    endtask
    task case2_b();
        #1;
        $display("%0d", $time, " ns, ", case2, ", case2_b");
    endtask
	
endmodule
/*
    initial begin
        case2_a(); //0ns
        case2_b(); //1ns
        fork
            #5;         //5ns
        join_none
        $display("%0d", $time, " ns, ", case2, ", finish");
    end
	
	initial begin
        case2_a(); //0ns
        case2_b(); //1ns
        fork
            #5;         //5ns
        join_none
        wait fork;
        $display("%0d", $time, " ns, ", case2, ", finish");
    end
	
	1.
		fork
	    join_none
	2.
        wait fork;
		
		
	= fork join
	
	
module top;
	initial begin
		fork: f1
		join
		fork: f2
		join
		wait fork;
		$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	end
	
	initial begin
		fork: f3
		join
		fork: f4
		join
	end
endmodule
*/