/*
description:
	implement a randc by rand
*/

class c1;
    rand bit [1:0] a;  //0,1,...3
    static bit [1:0] qu[$:3];

    constraint c1 {
        !(a inside {qu});  
    }
	
    function void post_randomize(); //callback function
        qu.push_back(a);  			
		//qu.push_front(a);  		//alternative way 
        if (qu.size() == 4) begin
            qu.delete();
        end
    endfunction
	
	//function display();
	//	$display("hello 2024");
	//endfunction
endclass

module top;
    c1 inst1 = new();
    initial begin
        repeat(10) begin
            repeat(4) begin  //0,1,2,3
                assert(inst1.randomize());
                $display("inst1 = %d", inst1.a);
            end 
            $display("*********************");
        end
		//inst1.display(); //possible
		//inst1.post_randomize(); //not resonable
    end
endmodule

