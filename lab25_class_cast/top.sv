// https://verificationguide.com/systemverilog/systemverilog-casting/

class base_pkt;
    rand bit [3:0] count; //range 0~15
    constraint c1 {count < 5; }
endclass

class ext_pkt extends base_pkt;
/*
	invisable line from its parent class
		rand bit [3:0] count; //range 0~15
*/
    constraint c1 {count == 6; } //overriding the constraint
endclass

module top();
    //both pkt and e_pkt are handle
    base_pkt pkt = new();  // pkt is a parent class handle (pointer)
    ext_pkt e_pkt = new(); // e_pkt is a child class handle (pointer)
	
    initial begin
	    $display("*");
        repeat(5) begin
            pkt.randomize();
            $display("pkt=%p", pkt);
        end

        $display("*");
        repeat(5) begin
            e_pkt.randomize();
            $display("e_pkt=%p", e_pkt);
        end

		//change from pkt to e_pkt
        $cast(pkt, e_pkt); //pkt handle is cast to handle type e_pkt

        $display("*");
        repeat(5) begin
            pkt.randomize();  //take e_pkt behaviors
            $display("after casting, pkt=%p", pkt);
        end
    end
endmodule


//int status = pkt.randomize()
//void'(pkt.randomize())

/*
	pkt.c1.constraint_mode(0);
*/

/*
// verification sv code 

	base_pkt pkt;
	ext_pkt e_pkt;
	
	initial begin
		pkt.randomize();
		<send pkt (the packets) to DUT>
		#100;
		$cast(pkt, e_pkt); //for randomize function, use the definition in class ext_pkt 
		pkt.randomize();
	end
*/
