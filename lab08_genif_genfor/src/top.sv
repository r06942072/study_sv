/*
	lab08
	sv_lrm2017 ch27
*/
module top;
	bit clk;    //clock
	logic sig1; //signal 1
	
	always #5 clk = ~clk; //clock with period 10sec
	
    for (genvar i=0; i<4; i=i+1) begin  //unnamed, genblk1, sv_lrm27.6
        sub inst_sub();
    end	
	
	generate
        for (genvar i=0; i<2; i=i+1) begin: gen1
            sub inst_sub();
        end
    endgenerate
	
    for (genvar i=0; i<3; i=i+1) begin: gen2
        sub inst_sub();
    end

	//sv_lrm27.5 Conditional generate constructs genif
	parameter p = 0;
	
	if( p == 1) begin    //unnamed, genblk4
		sub2 inst_sub2();
	end else begin
		sub3 inst_sub3();
	end
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars(0, top);  //only dump the sigs with vc
		//$dumpvars(0, top.genblk3[0].inst_sub.sig_in_sub); //can dump by this way if no vc
		//$dumpvars(0, top.genblk3[1].inst_sub.sig_in_sub);
		//$dumpvars(0, top.genblk4.inst_sub3.sig_in_sub3);
		
		#10;
		top.gen1[0].inst_sub.sig_in_sub = 1; //to make signal visable by gtkwave, we purposely add a vc

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