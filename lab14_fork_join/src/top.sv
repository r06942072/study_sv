/*
	lab14, sv_lrm2017, 9.3.2 parallel block
	fork join
*/
module top;
    initial begin
		fork //parallel
			begin: block1
				$display("at time = %5d, ", $time, " start block1");
				#1;
				$display("at time = %5d, ", $time, " end block1");
			end
			begin: block2
				$display("at time = %5d, ", $time, " start block2");
				#2;
				$display("at time = %5d, ", $time, " end block2");
			end
			begin: block3
				$display("at time = %5d, ", $time, " start block3");
				#3;
				$display("at time = %5d, ", $time, " end block3");
			end			
		join
		$display("at time = %5d, ", $time, " out-of-fork-join");
    end
	
	initial begin //sequentially
		#10;
		$display("-------at time = %5d, ", $time, " at time 10");
		#10;
		$display("-------at time = %5d, ", $time, " at time 20");
	end
endmodule

/////////////
//// a , 10, change from 0 to 1
//// b , 20, change from 0 to 1
//	bit a;
//	bit b;
//method1
//	initial begin 
//		#10;
//		a = 1;
//		#10;
//		b = 1;
//	end
	
//method2
//	initial begin 
//		#10;
//		a = 1;
//	end
//	initial begin 
//		#20;
//		b = 1;
//	end
	