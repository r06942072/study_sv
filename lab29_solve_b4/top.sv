
//
class ABC;
    rand bit a;
    rand bit [1:0] b; //range 0~3

    constraint c1 { a -> b == 2'd3; }  
endclass

class DEF;
    rand bit a;
    rand bit [1:0] b; //range 0~3

    constraint c1 { a -> b == 2'd3; solve a before b;}
    // a has to be solved first, before attempting b
endclass

module top;
    ABC inst1 = new();
    DEF inst2 = new();

    int cnt_a0_b0 = 0;
    int cnt_a0_b1 = 0;
    int cnt_a0_b2 = 0;
    int cnt_a0_b3 = 0;
    int cnt_a1_b3 = 0;

    initial begin
        $display("inst1");
        repeat(1000) begin
            assert(inst1.randomize());
            //$display("a = %d, b = %d", inst1.a, inst1.b);
            case({inst1.a, inst1.b})
                3'b0_00: cnt_a0_b0 = cnt_a0_b0 + 1;
                3'b0_01: cnt_a0_b1 = cnt_a0_b1 + 1;
                3'b0_10: cnt_a0_b2 = cnt_a0_b2 + 1;
                3'b0_11: cnt_a0_b3 = cnt_a0_b3 + 1;
                3'b1_11: cnt_a1_b3 = cnt_a1_b3 + 1;
            endcase
        end
        $display("probablity of inst1 (without solve before)");
        $display("a0_b0, a0_b1, a0_b2, a0_b3, a1_b3=%0d, %0d, %0d, %0d, %0d", cnt_a0_b0, cnt_a0_b1, cnt_a0_b2, cnt_a0_b3, cnt_a1_b3); //1/5 each element
        $display("*********************");
        $display("*********************");
        $display("*********************");


        cnt_a0_b0 = 0;
        cnt_a0_b1 = 0;
        cnt_a0_b2 = 0;
        cnt_a0_b3 = 0;
        cnt_a1_b3 = 0;
        $display("inst2");
        repeat(1000) begin
            assert(inst2.randomize());
            case({inst2.a, inst2.b})
                3'b0_00: cnt_a0_b0 = cnt_a0_b0 + 1;
                3'b0_01: cnt_a0_b1 = cnt_a0_b1 + 1;
                3'b0_10: cnt_a0_b2 = cnt_a0_b2 + 1;
                3'b0_11: cnt_a0_b3 = cnt_a0_b3 + 1;
                3'b1_11: cnt_a1_b3 = cnt_a1_b3 + 1;
            endcase
        end
        $display("probablity of inst2 (with solve before)");
        $display("a0_b0, a0_b1, a0_b2, a0_b3, a1_b3=%0d, %0d, %0d, %0d, %0d", cnt_a0_b0, cnt_a0_b1, cnt_a0_b2, cnt_a0_b3, cnt_a1_b3); // 1/8, 1/8, 1/8, 1/8, 4/8
    end
endmodule
