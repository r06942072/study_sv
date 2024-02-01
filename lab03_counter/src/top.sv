/*
	lab03
*/
module top;
	bit clk;    //clock
	logic [1:0] cnt_2bits = 2'd0;  //counter packed
	logic [2:0] cnt_3bits  = 3'd0; //packed. cannot be unpacked
	int cnt_int = 0; //32-bits
	byte my_byte; //8-bits, concat by sig1 and sig2
	
	bit [1:0] sig1 = 2'b10;
	bit [5:0] sig2 = 6'b111111;
	
	//assign my_byte = {sig1, sig2};  conti-assignment
	
	always #5 clk = ~clk; //clock with period 10sec

	always @(edge clk) begin
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
		my_byte = {sig1, sig2}; //MSB LSB
		#10;
		my_byte = {sig2, sig1}; //MSB LSB
		#1000; 
		$display("at time = ", $time, " end of the sim");
		$finish;    
    end
endmodule

