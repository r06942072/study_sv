/*
	lab03
*/
module top;
	bit clk;    //clock
	logic [1:0] cnt_2bits = 2'd0; 
	logic [2:0] cnt_3bits = 3'd0; 
	int cnt_int = 0;
	
	always #5 clk = ~clk; //clock with period 10sec

	always @(posedge clk) begin
		cnt_2bits <= cnt_2bits + 1;
    end
	
	always @(posedge clk) begin
		cnt_3bits <= cnt_3bits + 1;
    end
	
	always @(posedge clk) begin
		cnt_int <= cnt_int + 1;
    end
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;

		#1000;
		$display("at time = ", $time, " end of the sim");
		$finish;    
    end
endmodule