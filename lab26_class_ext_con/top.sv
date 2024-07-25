// https://verificationguide.com/systemverilog/systemverilog-casting/

class base_pkt;
    rand bit [3:0] count; //range 0~15
    constraint c1 {count < 5; }
endclass

class ext_pkt extends base_pkt;
    /*
        resolved both c1 and c2 in child
    */    
	// count is resolved by both c1 and c2
    constraint c2 {count >= 4; } 
	//constraint_mode default 1, if you want to turn off than 0
	//pkt.c1.constraint_mode(0); <-- not appear inside class def
endclass

module top();
    //both pkt and e_pkt are handle
    base_pkt pkt = new();
    ext_pkt e_pkt = new();
    initial begin
		$display("*");
        repeat(5) begin
            pkt.randomize();  // pkt is a handle of class base_pkt
            $display("pkt=%p", pkt);
        end

        $display("*");
        repeat(5) begin
            e_pkt.randomize();
            $display("e_pkt=%p", e_pkt);
        end

        $cast(pkt, e_pkt); //pkt handle is cast to handle type e_pkt
		
		pkt = 'e_pkt(pkt)
		
        $display("*");
        repeat(5) begin
            pkt.randomize();  //take e_pkt behaviors, pkt is a handle of class ext_pkt
            $display("after casting, pkt=%p", pkt);
        end
		
    end
endmodule

/*
	static cast example in below
		real r = 3.14
		int i
		i = 'int(r)
*/

