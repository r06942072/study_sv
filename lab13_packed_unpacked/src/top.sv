/*
	lab13
	https://verificationguide.com/systemverilog/systemverilog-packed-and-unpacked-array
*/

module top;
	bit [7:0] p_arr1; // packed array
	
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
		st_packed = 8'h5a; //same as two lines below
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