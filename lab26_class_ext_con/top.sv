// https://verificationguide.com/systemverilog/systemverilog-casting/


class base_pkt;
    rand bit [3:0] count; //range 0~15
    constraint c1 {count < 5; }
endclass

class ext_pkt extends base_pkt;
    /*
        resolved both c1 and c2 in child
    */    
    constraint c2 {count >= 4; } 
endclass

module top();
    //both pkt and e_pkt are handle
    base_pkt pkt = new();
    ext_pkt e_pkt = new();
    initial begin
        repeat(5) begin
            pkt.randomize();
            $display("pkt=%p", pkt);
        end

        $display("*");
        repeat(5) begin
            e_pkt.randomize();
            $display("e_pkt=%p", e_pkt);
        end

        $cast(pkt, e_pkt); //pkt handle is cast to handle type e_pkt

        $display("*");
        repeat(5) begin
            pkt.randomize();  //take e_pkt behaviors
            $display("after casting, pkt=%p", pkt);
        end
    end
endmodule
