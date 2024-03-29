/*
	lab13
*/

module top;
	bit [3:0] arr4;

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
		
		

		#100;
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
endmodule