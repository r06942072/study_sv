module a2();
    logic a2_logic;
    bit a2_bit;

    logic a2_clk;

    property p1;
        a2_bit |=> a2_bit;
    endproperty

    function bit func_a2();
        bit a2_func_bit;
        return a2_func_bit;
    endfunction    

    task task_a2();
        bit a2_task_bit;
    endtask

    a2_ass: assert property( @(posedge a2_clk) p1);
endmodule

// test auto-update dsn below /////////////////////////////////////////
typedef struct {
    bit          bit_st0;
    logic        logic_st0;
    logic [15:0] logic_packed_arr_st0;
    logic [15:0] logic_unpacked_arr_st0 [3];
} st0;   

typedef struct packed {
    bit    st1_bit;
    logic  st1_logic;
    logic [15:0] st1_logic_arr;
} st1;   

class my_class;
    logic logic_my_class;
    rand bit [1:0] num_2b_my_class;
endclass

bit bit_outside;                       //comp unit
logic [15:0] logic_packed_arr_outside; //comp unit

module d();
    bit bit_d;
endmodule

interface intf;
    bit  bit_intf;
    byte byte_intf;

    modport mp_oneside(
        input bit_intf
    );
    modport mp_otherside(
        output bit_intf
    );
endinterface

program tb;
    bit bit_tb;
endprogram

package pkg_sv;
    const int pkg_sv_const_int;
    bit pkg_sv_bit1 = 1;

    function void func_pkg();
        bit pkg_sv_func_bit;
        $display("%0d", $time, " ns, hello, I am func_pkg");
    endfunction

    task task_pkg();
        bit pkg_sv_task_bit;
    endtask
endpackage

module c2();
    import pkg_sv::*;

    logic c2_clk;
    initial  c2_clk=0;
    always begin
        #10 c2_clk = ~c2_clk;
    end

    const int c2_const_int;

    bit c2_bit0;
    bit c2_bit1 = pkg_sv_bit1;

    st0   inst_st0;
    st1   inst_st1;

    struct {
        bit   st2_bit;
        logic st2_logic;
    } st2;

    struct {
        string st3_string;
        bit    st3_bit;
        logic  st3_logic;
    } st3;

    generate
        for (genvar i=0; i<2; i=i+1) begin: gen
            d inst_d();
        end
    endgenerate
    intf inst_intf();
    tb   inst_tb();

    function bit func_c();
        bit c2_func_bit;
        return c2_func_bit;
    endfunction    

    task task_c();
        bit c2_task_bit;
    endtask

    my_class obj_c;
    initial begin
        obj_c = new;
        $display("%0d", $time, " ns, in c");
        func_pkg;        
    end

    property p1;
        ~c2_bit0 |=> ~c2_bit0;
    endproperty
    c2_ass: assert property( @(posedge c2_clk) p1);
endmodule

