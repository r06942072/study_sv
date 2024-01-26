/*
	lab08
	sv_lrm2017 ch27
*/
module top;
	bit clk;    //clock
	logic sig1; //signal 1
	
	always #5 clk = ~clk; //clock with period 10sec

	generate
        for (genvar i=0; i<2; i=i+1) begin: gen1
            sub inst_sub();
        end
    endgenerate
	
    for (genvar i=0; i<3; i=i+1) begin: gen2
        sub inst_sub();
    end

    for (genvar i=0; i<4; i=i+1) begin //unnamed, genblk3, sv_lrm27.6
        sub inst_sub();
    end	
	
	//sv_lrm27.5 Conditional generate constructs genif
	parameter p = 0;
	if( p == 1) begin
		sub2 inst_sub2();
	end else begin
		sub3 inst_sub3();
	end
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars(0, top);  //have bug, so workaround with following codes
		$dumpvars(0, top.genblk3[0].inst_sub.sig_in_sub);
		$dumpvars(0, top.genblk3[1].inst_sub.sig_in_sub);
		$dumpvars(0, top.genblk4.inst_sub3.sig_in_sub3);
		
		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule

module sub;
	bit sig_in_sub;
endmodule

module sub2;
	bit sig_in_sub2;
endmodule

module sub3;
	bit sig_in_sub3;
endmodule