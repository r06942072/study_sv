/*
description:
    the constrain for an array of 10 elements
    - first 5 elements are in increment
    - next 5 elements are decrement
    - all element in range 50 to 100
    - all element should be multiple of 5
*/

class c1;
    rand int arr1[9:0];

    constraint c1 {
        foreach(arr1[i]) {
            arr1[i] inside {[50:100]};
            arr1[i] %5 == 0;
            if (i>=1 && i<=4) //0,1,2,3,4
                arr1[i] > arr1[i-1];
            if (i>=5 && i<=9)
                arr1[i] < arr1[i-1];
        }
    }
endclass

module top;
    c1 inst1 = new();
    initial begin
        assert(inst1.randomize());
        $display("inst1 = %p", inst1.arr1);
        assert(inst1.randomize());
        $display("inst1 = %p", inst1.arr1);
    end
endmodule
