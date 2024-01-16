
//sv_lrm2017, ch6.18 typedef
typedef struct packed{ 
	logic my_logic;
	bit my_bit;
} def_struct2;

module top;
	logic clk=0; //4-states
	always #5 clk = ~clk;

	bit my_bit; //2-states, default 0
	int my_int; //2-states, default 0
	integer my_integer; //4-states, default x
	string my_str;
	
	struct packed{
		logic my_logic;
		bit my_bit;
	} my_struct1;
	
	def_struct2 my_struct2;
	
	function my_func();
		bit sig_in_func;
		//#1; //error, functions cannot have delay statements
	endfunction
	
	task my_task();
		bit sig_in_task;
		$display("start task, and will force clk to 0 after #1");
		#1;
		force clk = 0;
		$display("end task");				
	endtask
	
    initial begin
        $dumpfile("top.vcd");
		$dumpvars;
		//$dumpvars(0, top);
		
		$display("at time = %0d:", $time, "start sim");
		#40;
		my_bit = 1;
		my_int = 30;
		my_integer = 40;
		my_struct1.my_bit = 1;
		my_struct1.my_logic = 0;
		
		my_struct2.my_bit = 1;
		my_str = "this is a sentence."; 
		
		my_task();
		
		#50;
		$display("at time = %0d:", $time, "end sim");
		$finish;    
    end
    
endmodule
