/*
	lab19, sv_lrm2017 9.2.2.4 iff
	iverilog cannot parse iff
*/
module top;
	bit clk;    //clock
	always #5 clk = ~clk; //clock with period 10sec

	bit       reset;
    bit [7:0] cnt1; //bad design, more power consumption, because cnt1 still count up when reset == 1
    bit [7:0] cnt2; //good design

    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            cnt1 <= cnt1 + 8'd2;
        end else begin
            cnt1 <= cnt1 + 8'd1;
        end
    end
    //iff makes sure that block does not get triggered due to posedge of clk when reset == 1
    always_ff @(posedge clk iff reset==0 or posedge reset) begin  
        if(reset) begin
            cnt2 <= cnt2 + 8'd2;
        end else begin
            cnt2 <= cnt2 + 8'd1;
        end
    end
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;

		#100;
		reset = 1;  //posedge reset
		$display("----", $time, " ns, cnt1 = %0d, cnt2 = %0d", cnt1, cnt2);
		#100;
		reset = 0;
		#100;
        $display("----", $time, " ns, cnt1 = %0d, cnt2 = %0d", cnt1, cnt2);
		
		$display("at time = %0d", $time, ", end of the sim");
		$finish;    
    end
	
endmodule