module dut ();
    reg [3:0] c = 4'b1001;
    initial $monitor (" @%0t DUT c == %0b ",$time,c);
endmodule

module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    logic [3:0] temp;

    function new(string name,uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
	  uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("TEST"," -- RUNNING MY_TEST -- ",UVM_LOW)
      void '(uvm_hdl_read ("top.dut.c",temp));
      `uvm_info("HDL_READ",$sformatf(" -- reading top.dut.c == %0b",temp),UVM_LOW)
      #10;
      temp = 4'b1111;
      void '(uvm_hdl_force ("top.dut.c",temp));
      `uvm_info("HDL_FORCE",$sformatf(" -- forcing top.dut.c == %0b",temp),UVM_LOW)
	  #10;
	  void '(uvm_hdl_release ("top.dut.c"));
      `uvm_info("HDL_release",$sformatf(" -- releasing top.dut.c == %0b",temp),UVM_LOW)
	  #10;
	  temp[1:0] = 2'b00;
	  void '(uvm_hdl_deposit ("top.dut.c[1:0]",temp));
      `uvm_info("HDL_deposit",$sformatf(" -- depositing top.dut.c == %0b",temp),UVM_LOW)
	  #10 
	  void '(uvm_hdl_release_and_read ("top.dut.c",temp));
      `uvm_info("HDL_release_and_read",$sformatf(" -- releasing top.dut.c == %0b",temp),UVM_LOW)
	  #10;
      temp = 4'bz11x;
	  uvm_hdl_force_time ("top.dut.c",temp,100);
      `uvm_info("HDL_force_time",$sformatf(" -- forceing top.dut.c == %0b",temp),UVM_LOW)

      phase.drop_objection(this);
    endtask
  endclass

  dut dut ();

  initial begin
    run_test("my_test");
	$finish;
	end
endmodule
