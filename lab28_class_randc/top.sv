/*
description:
	implement a randc by rand
*/

class c1;
    rand bit [1:0] a; //0,1,...3
    static bit [1:0] qu[$:3];  //queue

    constraint c1 {
        !(a inside {qu});
    }
    function void post_randomize();
        qu.push_back(a);
        if (qu.size() == 4) begin
            qu.delete();
        end
    endfunction
endclass

module top;
    c1 inst1 = new();
    initial begin
        repeat(10) begin
            repeat(4) begin
                assert(inst1.randomize());
                $display("inst1 = %d", inst1.a);
            end 
            $display("*********************");
        end
    end
endmodule

