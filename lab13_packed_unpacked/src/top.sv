/*
	lab13
	https://verificationguide.com/systemverilog/systemverilog-packed-and-unpacked-array
*/

module top;
	//byte c2;
	//bit signed [7:0] c2
	
	bit [7:0] p_arr1; // packed array
	//bit [8] p_arr1; //illegal
	
	bit unp_arr1 [7:0]; // unpacked array 
	bit unp_arr2 [8]; // unpacked array 

	struct packed {  
		logic [3:0] addr1;
		logic [3:0] addr2;
	} st_packed; 
	/*
	struct { //default unpacked
		logic [3:0] addr1;
		logic [3:0] addr2;
	} st_unpacked; 
	*/

    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		// same as dumpvars (0, top);
		
		//
		st_packed = 8'h5a;  //same as two lines below
		#10;
        st_packed.addr1 = 4'h5; 
        st_packed.addr2 = 4'ha; 
		
		#10;
		p_arr1 = 8'h1;
		//unp_arr1 = 8'h1; //error, Assignment to an entire array or to an array slice is not yet supported
		unp_arr1[0] = 1;
		unp_arr2[0] = 1;
		$display(unp_arr1[0]);
		$display(unp_arr2[0]);

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule


/// typedef
// design unit
// compilation unit CU
/*
	typedef struct  {  
		logic [3:0] addr1;
		logic [3:0] addr2;
	} s1; 

module m1;

	s1 inst1;
	logic sig_1;
	
	initial begin
		inst1.addr1 = 4'b1111;
	end
	
endmodule

module m2;
	s1 inst2;
	initial begin
		inst2.addr1 = 4'b1111;  //cannot
	end
	
endmodule

module m3;
	
endmodule
*/