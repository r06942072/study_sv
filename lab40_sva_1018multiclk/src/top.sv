/*
	lab40, sva assertions
	sim on edaplayground.com. tool = Cadence Xcelium 20.09

*/
module top;
    diff_clk inst_diff_clk(.*);
	same_clk inst_same_clk(.*);
	initial begin
		$dumpfile("top.vcd"); $dumpvars;

		#100;
		$display("----", $time, " ns, finish");
	    $finish;

	end
endmodule

module diff_clk;
    bit clk_fast;
    bit clk_slow;
    always #10 clk_slow = ~clk_slow;
    always #5 clk_fast = ~clk_fast;

    bit start; 
    bit x1, y1;
    bit x2, y2;
    initial begin
        fork
            begin
                @(posedge clk_slow);
                start = 1;
                @(posedge clk_slow);
                start = 0;
            end
            begin
                @(posedge clk_slow);
                @(posedge clk_slow);
                x1 = 1;
                x2 = 1;
                @(posedge clk_slow);
                x1 = 0;
                x2 = 0;
            end
            begin
                repeat(5) begin
                    @(posedge clk_fast);
                end
                y1 = 1;
                @(posedge clk_fast);
                y1 = 0;
            end
            begin
                repeat(6) begin
                    @(posedge clk_fast);
                end
                y2 = 1;
                @(posedge clk_fast);
                y2 = 0;
            end
        join
    end

    //multiclock seq 
    sequence s1(x, y);
        @(posedge clk_slow) x ##0 @(posedge clk_fast) y
    endsequence

    sequence s2(x, y);
        @(posedge clk_slow) x ##1 @(posedge clk_fast) y
    endsequence

// note: *E, ##2 is not supported in multiclock 
//    sequence s3(x, y);
//        @(posedge clk_slow) x ##2 @(posedge clk_fast) y   
//    endsequence

// note: *E, intersect is not supported in multiclock 
//    sequence s4(x, y);
//       @(posedge clk_slow) x ##1 intersect @(posedge clk_fast) y   
//    endsequence

    a1_design1: assert property(@(posedge clk_slow) start |=> s1(x1, y1)); //pass 
	// decomposite
	//         @(posedge clk_slow) start |=> @(posedge clk_slow) x1 ##0 @(posedge clk_fast) y1
	
    a1_design2: assert property(@(posedge clk_slow) start |=> s1(x2, y2)); //fail  
    a2_design1: assert property(@(posedge clk_slow) start |=> s2(x1, y1)); //pass
	// decomposite
	//         @(posedge clk_slow) start |=> @(posedge clk_slow) x1 ##1 @(posedge clk_fast) y1
    a2_design2: assert property(@(posedge clk_slow) start |=> s2(x2, y2)); //fail  
endmodule

module same_clk;
    bit clk_fast;
    bit clk_slow;
    always #10 clk_slow = ~clk_slow;
    always #10 clk_fast = ~clk_fast;

    bit start; 
    bit x1, y1;
    bit x2, y2;
    initial begin
        fork
            begin
                @(posedge clk_slow);
                start = 1;
                @(posedge clk_slow);
                start = 0;
            end
            begin
                @(posedge clk_slow);
                @(posedge clk_slow);
                x1 = 1;
                x2 = 1;
                @(posedge clk_slow);
                x1 = 0;
                x2 = 0;
            end
            begin
                repeat(2) begin
                    @(posedge clk_fast);
                end
                y1 = 1;
                @(posedge clk_fast);
                y1 = 0;
            end
            begin
                repeat(3) begin
                    @(posedge clk_fast);
                end
                y2 = 1;
                @(posedge clk_fast);
                y2 = 0;
            end
        join
    end

    //multiclock seq 
    sequence s1(x, y);
        @(posedge clk_slow) x ##0 @(posedge clk_fast) y
        // because clk_slow is an identical to clk_fast, so can be simplified as below
        // @(posedge clk) x ##0 y
    endsequence

    sequence s2(x, y);
        @(posedge clk_slow) x ##1 @(posedge clk_fast) y
        // because clk_slow is an identical to clk_fast, so can be simplified as below
        // @(posedge clk) x ##1 y
    endsequence

    a1_design1: assert property(@(posedge clk_slow) start |=> s1(x1, y1)); //pass 
	// decomposite
	//         @(posedge clk) start |=> x1 ##0 y1
    a1_design2: assert property(@(posedge clk_slow) start |=> s1(x2, y2)); //fail  
	// decomposite
	//         @(posedge clk) start |=> x2 ##0 y2
    a2_design1: assert property(@(posedge clk_slow) start |=> s2(x1, y1)); //fail
	// decomposite
	//         @(posedge clk) start |=> x1 ##1 y1	
    a2_design2: assert property(@(posedge clk_slow) start |=> s2(x2, y2)); //pass
	// decomposite
	//         @(posedge clk) start |=> x2 ##1 y2		
endmodule

/*
sequence s1;
	a ##1 b; // unclocked sequence
endsequence

a1_design1: assert property(@(posedge clk2) start |=> @(posedge clk1) s1);

a2_design1: assert property(@(posedge clk2) start |=> a ##1 b);

assert top
	property
		sequence bottom
///////////////////////////////////////
module top;
	logic sig; //top.sig
	logic [1:0] output_c;
	logic input_a;
	adder aa1(
		.a(input_a),
		.c(output_c)
	);
endmodule

module top2;
	adder2 aa1(); //instance
endmodule

module m1;
	logic sig; //top.inst1.sig 
	bit b1;
	initial begin
		sig = 1;
		//top.inst1.sig = 1;
		top.sig = 1; //oomr, out of module reference
		
		b1 = top.sig;
	end
endmodule

module adder (
	input a,
	output [1:0] c
);
	assign c = a + top.sig;
endmodule

module adder2 (
	input a,
	output [1:0] c
);
	assign c = a + top2.sig;
endmodule
//////////////////////////////////////////
sequence s1(x, y);
	addr1 ##1 addr2
endsequence 

sequence s2(x, y);
	data1 ##2 data2
endsequence 

sequence s_multi; //12-clk-cycle
	s1 ##1 valid throught(s2) 
endsequence

property verify_axi;
	enable |=> s_multi;
endproperty
*/