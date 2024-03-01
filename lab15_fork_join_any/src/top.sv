/*
	lab15, sv_lrm2017, 9.3.2 parallel block
	fork join_any
*/
module top;
    initial begin
		fork
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
		join_any
		$display("at time = %5d, ", $time, " out-of-fork-join-any");
    end
	initial begin
		#100;
		$display("at time = %5d, ", $time, " end of the sim");
	end
endmodule

