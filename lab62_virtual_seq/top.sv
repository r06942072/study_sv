// Code your design here





`begin_keywords "1800-2017"					// LRM 1800-2017

timeunit 1ns; timeprecision 1ns;

module adder(
		input	logic		aclk,arst,
		input	logic[3:0]	a,b,
		output	logic[4:0]	y

		);
		
		
		always_ff @(posedge aclk)  begin: B1		// syn rst	
			
			if(arst) 
				y <= 5'd0;
			else
				y <= a + b;
		end: B1
			
		
endmodule: adder

`end_keywords



// ------------------------------- RTL for sequential subtractor  -------------------------------


`begin_keywords "1800-2017"					// LRM 1800-2017

timeunit 1ns; timeprecision 1ns;

module subtractor(

		input	logic		sclk,srst,
		input	logic[3:0]	m,n,
		output	logic[4:0]	z

		);
		
		
		always_ff @(posedge sclk)  begin: B1		// syn rst	
			
			if(srst) 
				z <= 5'd0;
			else
				z <= m - n;
		end: B1
			
			
		
endmodule: subtractor

`end_keywords




`begin_keywords "1800-2017"					// LRM 1800-2017

timeunit 1ns; timeprecision 1ns;

module top(

		input  logic 		aclk, arst,sclk,srst,
		input  logic [3:0] 	a,b,m,n,
		output logic [4:0]	y,z

		);

	
		adder 		adder_dut(.aclk(aclk),.arst(arst),.a(a),.b(b),.y(y));
		subtractor	sub_dut  (.sclk(sclk),.srst(srst),.m(m),.n(n),.z(z));


endmodule: top


`end_keywords





interface adder_if;

	 logic 		aclk, arst;
  	 logic [3:0] 	a,b;
 
  	 logic [4:0] 	y;

endinterface:   adder_if
 
 
//////////////////////////////
 



interface sub_if;

	 logic 		sclk, srst;
  	 logic [3:0] 	m,n;
 
  	 logic [4:0] 	z;

endinterface:    sub_if


// and concepts of virtual sequence and virtual sequencer




`include "uvm_macros.svh"					// will give an access to uvm macros
 import uvm_pkg::*;						// will give an access to uvm pkg(to all uvm classes)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//---------------- transaction class -------------------

// keep track of all i/p's and o/p's of the RTL(DUT) except global signals i.e clk we r dealing with them in hvl_top.

// seq_itm1 is for adder transaction



class seq_itm1 extends uvm_sequence_item;

	rand bit[3:0] a,b;
	     bit arst;					// class properties 
	     bit[4:0] y;				// i/p port's qualified with rand bcz we want to take help of pesudo random number generation facility.
							// let's clk to be generate at top module
	   						// o/p port's keept as it is. 
							// no need to declare clk here bcz in top we are utilizing it.			

	`uvm_object_utils_begin(seq_itm1)			// factory registration and field macros
		`uvm_field_int(a,UVM_DEFAULT    +  UVM_DEC)	// UVM_DEFAULT or UVM_ALL_ON flag
		`uvm_field_int(b,UVM_DEFAULT    +  UVM_DEC)	// | or + UVM_DEC decimal format flag
		`uvm_field_int(arst,UVM_DEFAULT +  UVM_DEC)	// if re-ordering these then printing will happen in another way 
		`uvm_field_int(y,UVM_DEFAULT    +  UVM_DEC)
	`uvm_object_utils_end					// and impact on pack and unpack methods
	

	function new(input string name = "seq_itm1");		// object class in UBCH hence one argument
		super.new(name);
	endfunction: new

endclass: seq_itm1




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// ------------------- sequence class  ----------------------

// sequence class:- parameterize class, parameterize with type of transaction(data object in this case seq_itm)

// generator in SV:- generates random sequence and send to the driver

// start_item(trans); signifies that new transaction is there

// sequence:- object class in UBCH, where actual xtn is going to be generate, for verifying any design completly and get 100%  
// functional coverage we need to have multiple sequences bcz one sequence is capable of generating only one kind of xtn.

// generate stimulus based on given constrains
// can be generated on-the-fly or at time zero
// sequences can be nested i.e one sequence can be made as a part of other sequence
// override sequences using factory 

// to create a sequence
// extend from uvm_sequence
// user code in task methods i.e pre_body(), body() and post_body().


// Note:- sequence1 is for adder 


class sequence1 extends uvm_sequence #(seq_itm1);

	`uvm_object_utils(sequence1)				// factory registration

	function new(input string name = "sequence1");		// object class in UVM_BCH hence one argument
		super.new(name);				// object dynamic in nature which can be create and delete
	endfunction: new
								// so req(request)is built in xtn object and rsp(response)also
								// req = transaction::type_id::create("req");	
			
	virtual task body();					// virtual task without any arguments
								// as object class hence no phases hence executable 
		req = seq_itm1::type_id::create("req");		// logic need to be written in method i.e task
								// req is a inbuilt object of xtn type
		repeat(5) begin: B1				// repeat 5 to generate 5 random data

								// Waiting for request from driver i.e start_item(req);
			//start_item(req);			// to start communication i.e start_item blocking in nature
								// proper handshaking between drv and seqr
			//void'(req.randomize());			// generating xtn, pesudo random number
			//req.rst = '0;				// deassertion of rst
			//`uvm_info(get_type_name(),"Data send to driver",UVM_NONE)	//`uvm_info("GENERATOR","Data send to driver",UVM_NONE)
			//req.print();				// print in order to verify
								// start_item(req); and finish_item(req); are the tasks			
			//finish_item(req);			// Give the seq itm to drv and waiting for ack or responce 
								// both have arguments start and finish item
			`uvm_do(req);				// this one line is enough for work from start_item(req) to
			`uvm_info(get_type_name(),"Data send to driver",UVM_NONE)	//`uvm_info("GENERATOR","Data send to driver",UVM_NONE)
			 req.print();
								// finish_item(trans)	
			//`uvm_do_with(req,{req.constraint if any});	// for providing in line constrains see uart code for more clarifications																	
			// instead of void'(req.randomize() with {address == 10; data == 8'd20;});

		end: B1					

	endtask: body						// while in case of drv only first have argument while second will not i.e item_done();
	

endclass: sequence1



// ------------------- driver class ---------------------


// driver class is also parameterize class
// component class in uvm base class hierarchy hence default constructor expecting two arguments.
// driver responsibility is to drive the stimulus from sequence to the DUT based upon the DUT's protocol and this
// responsibility is completely protocol dependet but in some cases driver is present & not driveing anythig just an idle 
// driver hence UVM_DEVELOPERS comes with common logic for this and its non_virtual in nature hence just need to
// extend this from uvm_driver.
// Access interface with config_db

// driver:- pkt(Stream of transactions) to pin level conversion

// in order to have a consistent TB execution flow,the UVM has a concept of phases to order the major steps that take place 
// during the simulution. 

// to start UVM TB, the run_test("test") method(task) is called from within an initial begin block in the top level module 
// of the TB.

// calling run_test("test),constructs the UVM env root and then initiates the UVM phasing.



class adder_driver extends uvm_driver #(seq_itm1);


	virtual adder_if vif;					// interface static hence inside class need to declare as virtual
								// bcz class is dynamic and interface is static component.

	`uvm_component_utils(adder_driver)			// factory registration

	function new(input string name = "adder_driver", uvm_component parent = null);// component hence two arguments
		super.new(name,parent);				// components are static in nature need to be there though out the simlation
	endfunction: new 

	

// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		req = seq_itm1::type_id::create("req");					// req is an inbuild object of xtn type
		if(!uvm_config_db #(virtual adder_if)::get(this,"","virtual_adder_intf",vif))	// hence no need to declare it
		`uvm_fatal(get_type_name(),"Unable to get virtual_intf vif")
	endfunction: build_phase



	task drive();

		forever begin: B1						// receive multiple sequence(random data) and whenever we have a requirement to
										// receive multiple  sequences inside drv do not proceed with raise & drop objection 
			seq_item_port.get_next_item(req);			// instead proceed with forever begin end
										// get next data item from sequencer get_next_item blocking in nature, seq_item_port.try_next_item(trans); is a non blocking methods
				vif.arst <= 1'b0;				// deasset rst 
				vif.a <= req.a;					// apply stimulus to dut by vif, using non-blk assignments
				vif.b <= req.b;	
				repeat(3) @(posedge vif.aclk);			// waiting for 3 clk cycles
			
			       `uvm_info(get_type_name(),"adder_driver  Send data to DUT",UVM_NONE)
				req.print();				// just printing transctions
			
			seq_item_port.item_done();

		end: B1

	endtask: drive


// run_phase:- task bcz contain delay:- driver drive stimuls to DUT and monitor capture information from DUT based on DUT protocol.
//	       executes in parallel and all pre-post run phases.


// seq_item_port.get_next_item(req);	send a request to get the sequence item and waiting for the sequence item

// drive the sequence item to DUT	which is usr defined task

// seq_item_port.item_done();		//send the ack or request


	virtual task run_phase(uvm_phase phase);
								// receive multiple sequence(random data) and whenever we have a requirement to
		drive();					// calling the drive task

	endtask: run_phase


	
endclass: adder_driver



// ------------------- monitor class ---------------------


// monitor class is not parameterize class.
// component class in uvm base class hierarchy hence default constructor expect two arguments.
// monitor responsibility is to capture the information from the DUT through vif and broadcast it to SB and RM(Multiple components) hence it has
// analysis port. 


// monitor:- pin/signal level to pkt/stream of transactions level conversion.



class adder_monitor extends uvm_monitor;


	seq_itm1 trans;							// instance for adder transaction class

	virtual adder_if vif;						// interface inside class need to declare as virtual
									// bcz class is dynamic and interface is static component.
	uvm_analysis_port #(seq_itm1) aap;				// uvm_analysis_port, one to many kind of scenario			
									// dimond shape and parameterize with type of xtn 

	`uvm_component_utils(adder_monitor)				// factory registration

	function new(input string name = "adder_monitor", uvm_component parent = null);// component hence two arguments
		super.new(name,parent);					// components are static in nature need to be there though out the simlation
		aap = new("aap",this);					// memory allocation for ap, here or in build_phase anything is fine
	endfunction: new 

	
// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		trans = seq_itm1::type_id::create("trans");
		if(!uvm_config_db #(virtual adder_if)::get(this,"","virtual_adder_intf",vif))
		`uvm_fatal(get_type_name(),"Unable to get virtual_intf vif")	// default verbosity is UVM_MEDIUM
	endfunction: build_phase



// task capture

	task capture();

		forever begin: B1	
		
			@(posedge vif.aclk);				// wait for 1 clk cyle
			if(vif.arst) begin: B2				// rst == 1
				
				trans.arst = 1'b1;
				aap.write(trans);		// collecting data into aap	
			end: B2
			
			else begin: B3
								// wait 2 clk cycles same delay as mention in drv so at rst 1 + 2 here = 3
				@(posedge vif.aclk);		// define delay like this if we have clk block and modport defined inside interface defn
				@(posedge vif.aclk);

				trans.arst = 1'b0;		// capturing information from DUT through vif(virtual interface)
				trans.a   = vif.a;		// either blk or non-blk assignments
				trans.b   = vif.b;	
				trans.y	  = vif.y;	

				`uvm_info(get_type_name(),"adder_monitor Send data to SB",UVM_NONE)
				trans.print();			// just print transctions
				aap.write(trans);		// collecting data into ap		
								// ap has write method which is non-blocking in nature	

			end: B3		
				
		end: B1	


	endtask: capture  


// run_phase:- task bcz contain delay:- driver drive stimuls to DUT and monitor capture information from DUT based on DUT protocol.
//	       executes in parallel and all pre-post run phases.


	virtual task run_phase(uvm_phase phase);
		
		capture();					// calling the capture task
		
	endtask: run_phase


endclass: adder_monitor



// Driver and monitor often written by the different Verification Engineers.




// ------------------- agent_config class  ----------------------

// in order to configure the active or passive agent
// active agent will have all the three esential components like seqr,drv,mon classes.
// passive agent will have only monitor class.  
// as it's a object class in the base class hierarchy hence default constructor expecting only one argument.



class agent_config extends uvm_object;

	
	uvm_active_passive_enum  is_active = UVM_ACTIVE;	// UVM_ACTIVE or 1, why uvm_active_passive_enum why not normal
     // or uvm_active_passive_enum  agent_type = UVM_ACTIVE;	// enum bcz enum by defualt is of int type(2^32) and we want two
								// bits only like active or passive to avoid wastage of unneccery 
								// memory uvm developer made it as uvm_active_passive_enum	
	`uvm_object_utils(agent_config)				// factory registration
								// by default its an UVM_ACTIVE for passive agent UVM_PASSIVE
				
	//bit has_scoreboard = '1;
	//bit has_functional_coverage = '1;

	function new(input string name = "agent_config");	// default constructor expecting only one argument
		super.new(name);
	endfunction: new					// AUVM_ACTIVE/PASSIVE are enum type

endclass: agent_config




// ------------------- agent class  ----------------------

// agent is UVC(Universal Verification Component).
// configurable one can be active i.e will have all essential components seqr,drv,mon but if passive then will have only mon.
// agent class is one kind of container and it will contains the objects for sequencer, driver and monitor classes.
// component class in uvm base class hierarchy hence default constructor expecting two arguments.


// agent don't have the run_phase bcz run phase required for the components which are doing some physical jobs like driving
// xtns or collecting xtns, but agent is just a container for seqr, drv and mon hence a part from build and connect phase
// no other phases are required.  


class adder_agent extends uvm_agent;

	
	agent_config			a_cfg;				// instance/handler for agent config class
	adder_driver 			adrv_h;				// instance/handler for driver class
	uvm_sequencer #(seq_itm1) 	aseqr_h;
	adder_monitor 			amon_h;				// instance/handler for monitor class


	`uvm_component_utils(adder_agent)				// factory regestration

	function new(input string name = "adder_agent", uvm_component parent = null);// component class in UBCH hence two arguments
		super.new(name,parent);
	endfunction: new


// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);				// monitor is there by default bcz its common for both active or passive agent	
	
		amon_h = adder_monitor::type_id::create("amon_h",this);	// using factory's create method creating all lower level components
		a_cfg = agent_config::type_id::create("a_cfg");

		if(!uvm_config_db #(agent_config)::get(this,"","agent_configuration",a_cfg))
		`uvm_fatal(get_type_name(),"Can't get() a_cfg fom uvm_config_db, Have you set it?")

		if(a_cfg.is_active == UVM_ACTIVE) begin: B1		// by default its an UVM_ACTIVE
		//if(get_is_active() == UVM_ACTIVE) begin: B1		// first checking active or passive if active then only creating drv and seqr		
									// multiple statements hence begin end
			adrv_h  = adder_driver::type_id::create("adrv_h",this);	// get_is_active() is of bit type
			aseqr_h = uvm_sequencer #(seq_itm1)::type_id::create("aseqr_h",this);
		end: B1

	endfunction: build_phase


// connect_phase:- responsible for establishing connection between all created components by  port-export
//		   executes in buttom up manner.


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(a_cfg.is_active == UVM_ACTIVE) begin: B1			// one statement hence no begin end	
										// by default its an UVM_ACTIVE
			adrv_h.seq_item_port.connect(aseqr_h.seq_item_export);	// connection between drvr and seqr 
		end: B1

	endfunction: connect_phase					// connection start with drv bcz it's an initiator
									// driver class is initiator hence have a port(seq_item_port)
									// monitor class is consumer hence have a export(seq_item_export)
endclass: adder_agent							// driver has in built TLM port called seq_item_port
									// and sequencer has built TLM port called seq_item_export





/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//---------------- transaction class -------------------

// keep track of all i/p's and o/p's of the RTL(DUT) except global signals i.e clk we r dealing with them in hvl_top.

// seq_itm2 is for subtractor transaction



class seq_itm2 extends uvm_sequence_item;

	rand bit[3:0] m,n;
	     bit srst;					// class properties 
	     bit[4:0] z;				// i/p port's qualified with rand bcz we want to take help of pesudo random number generation facility.
							// let's clk to be generate at top module
	   						// o/p port's keept as it is. 
							// no need to declare clk here bcz in top we are utilizing it.			

	`uvm_object_utils_begin(seq_itm2)			// factory registration and field macros
		`uvm_field_int(m,UVM_DEFAULT    +  UVM_DEC)	// UVM_DEFAULT or UVM_ALL_ON flag
		`uvm_field_int(n,UVM_DEFAULT    +  UVM_DEC)	// | or + UVM_DEC decimal format flag
		`uvm_field_int(srst,UVM_DEFAULT +  UVM_DEC)	// if re-ordering these then printing will happen in another way 
		`uvm_field_int(z,UVM_DEFAULT    +  UVM_DEC)
	`uvm_object_utils_end					// and impact on pack and unpack methods
	

	function new(input string name = "seq_itm2");		// object class in UBCH hence one argument
		super.new(name);
	endfunction: new

endclass: seq_itm2




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// ------------------- sequence class  ----------------------

// sequence class:- parameterize class, parameterize with type of transaction(data object in this case seq_itm)

// generator in SV:- generates random sequence and send to the driver

// start_item(trans); signifies that new transaction is there

// sequence:- object class in UBCH, where actual xtn is going to be generate, for verifying any design completly and get 100%  
// functional coverage we need to have multiple sequences bcz one sequence is capable of generating only one kind of xtn.

// generate stimulus based on given constrains
// can be generated on-the-fly or at time zero
// sequences can be nested i.e one sequence can be made as a part of other sequence
// override sequences using factory 

// to create a sequence
// extend from uvm_sequence
// user code in task methods i.e pre_body(), body() and post_body().


// Note:- sequence2 is for subtractor 


class sequence2 extends uvm_sequence #(seq_itm2);

	`uvm_object_utils(sequence2)				// factory registration

	function new(input string name = "sequence2");		// object class in UVM_BCH hence one argument
		super.new(name);				// object dynamic in nature which can be create and delete
	endfunction: new
								// so req(request)is built in xtn object and rsp(response)also
								// req = transaction::type_id::create("req");	
			
	virtual task body();					// virtual task without any arguments
								// as object class hence no phases hence executable 
		req = seq_itm2::type_id::create("req");		// logic need to be written in method i.e task
								// req is a inbuilt object of xtn type
		repeat(5) begin: B1				// repeat 5 to generate 5 random data

								// Waiting for request from driver i.e start_item(req);
			//start_item(req);			// to start communication i.e start_item blocking in nature
								// proper handshaking between drv and seqr
			//void'(req.randomize());			// generating xtn, pesudo random number
			//req.rst = '0;				// deassertion of rst
			//`uvm_info(get_type_name(),"Data send to driver",UVM_NONE)	//`uvm_info("GENERATOR","Data send to driver",UVM_NONE)
			//req.print();				// print in order to verify
								// start_item(req); and finish_item(req); are the tasks			
			//finish_item(req);			// Give the seq itm to drv and waiting for ack or responce 
								// both have arguments start and finish item
			`uvm_do(req);				// this one line is enough for work from start_item(req) to
			`uvm_info(get_type_name(),"Data send to driver",UVM_NONE)	//`uvm_info("GENERATOR","Data send to driver",UVM_NONE)
			 req.print();
								// finish_item(trans)	
			//`uvm_do_with(req,{req.constraint if any});	// for providing in line constrains see uart code for more clarifications																	
			// instead of void'(req.randomize() with {address == 10; data == 8'd20;});

		end: B1					

	endtask: body						// while in case of drv only first have argument while second will not i.e item_done();
	

endclass: sequence2



// ------------------- driver class ---------------------


// driver class is also parameterize class
// component class in uvm base class hierarchy hence default constructor expecting two arguments.
// driver responsibility is to drive the stimulus from sequence to the DUT based upon the DUT's protocol and this
// responsibility is completely protocol dependet but in some cases driver is present & not driveing anythig just an idle 
// driver hence UVM_DEVELOPERS comes with common logic for this and its non_virtual in nature hence just need to
// extend this from uvm_driver.
// Access interface with config_db

// driver:- pkt(Stream of transactions) to pin level conversion

// in order to have a consistent TB execution flow,the UVM has a concept of phases to order the major steps that take place 
// during the simulution. 

// to start UVM TB, the run_test("test") method(task) is called from within an initial begin block in the top level module 
// of the TB.

// calling run_test("test),constructs the UVM env root and then initiates the UVM phasing.



class sub_driver extends uvm_driver #(seq_itm2);


	virtual sub_if vif;						// interface static hence inside class need to declare as virtual
									// bcz class is dynamic and interface is static component.

	`uvm_component_utils(sub_driver)				// factory registration

	function new(input string name = "sub_driver", uvm_component parent = null);// component hence two arguments
		super.new(name,parent);					// components are static in nature need to be there though out the simlation
	endfunction: new 

	

// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		req = seq_itm2::type_id::create("req");					// req is an inbuild object of xtn type
		if(!uvm_config_db #(virtual sub_if)::get(this,"","virtual_subtractor_intf",vif))	// hence no need to declare it
		`uvm_fatal(get_type_name(),"Unable to get virtual_intf vif")
	endfunction: build_phase


	task sub_drive();

		forever begin: B1						// receive multiple sequence(random data) and whenever we have a requirement to
										// receive multiple  sequences inside drv do not proceed with raise & drop objection 
			seq_item_port.get_next_item(req);			// instead proceed with forever begin end
										// get next data item from sequencer get_next_item blocking in nature, seq_item_port.try_next_item(trans); is a non blocking methods
				vif.srst <= 1'b0;				// deasset rst 
				vif.m <= req.m;					// apply stimulus to dut by vif, using non-blk assignments
				vif.n <= req.n;	
				repeat(3) @(posedge vif.sclk);			// waiting for 3 clk cycles
			
			       `uvm_info(get_type_name(),"sub_driver  Send data to DUT",UVM_NONE)
				req.print();				// just printing transctions
			seq_item_port.item_done();

		end: B1

	endtask: sub_drive


// run_phase:- task bcz contain delay:- driver drive stimuls to DUT and monitor capture information from DUT based on DUT protocol.
//	       executes in parallel and all pre-post run phases.


// seq_item_port.get_next_item(req);	send a request to get the sequence item and waiting for the sequence item

// drive the sequence item to DUT	which is usr defined task

// seq_item_port.item_done();		//send the ack or request


	virtual task run_phase(uvm_phase phase);
								// receive multiple sequence(random data) and whenever we have a requirement to
		sub_drive();					// calling the drive task

	endtask: run_phase
	
endclass: sub_driver







// ------------------- monitor class ---------------------


// monitor class is not parameterize class.
// component class in uvm base class hierarchy hence default constructor expect two arguments.
// monitor responsibility is to capture the information from the DUT through vif and broadcast it to SB and RM(Multiple components) hence it has
// analysis port. 


// monitor:- pin/signal level to pkt/stream of transactions level conversion.



class sub_monitor extends uvm_monitor;


	seq_itm2 trans;							// instance for adder transaction class

	virtual sub_if vif;						// interface inside class need to declare as virtual
									// bcz class is dynamic and interface is static component.
	uvm_analysis_port #(seq_itm2) sap;				// uvm_analysis_port, one to many kind of scenario			
									// dimond shape and parameterize with type of xtn 

	`uvm_component_utils(sub_monitor)				// factory registration

	function new(input string name = "sub_monitor", uvm_component parent = null);// component hence two arguments
		super.new(name,parent);					// components are static in nature need to be there though out the simlation
		sap = new("sap",this);					// memory allocation for ap, here or in build_phase anything is fine
	endfunction: new 

	
// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		trans = seq_itm2::type_id::create("trans");
		if(!uvm_config_db #(virtual sub_if)::get(this,"","virtual_subtractor_intf",vif))
		`uvm_fatal(get_type_name(),"Unable to get virtual_intf vif")	// default verbosity is UVM_MEDIUM
	endfunction: build_phase



// task capture

	task mon_capture();

		forever begin: B1	
		
			@(posedge vif.sclk);				// wait for 1 clk cyle
			if(vif.srst) begin: B2				// rst == 1
				
				trans.srst = 1'b1;
				sap.write(trans);			// collecting data into ap	
			end: B2
			
			else begin: B3
								// wait 2 clk cycles same delay as mention in drv so at rst 1 + 2 here = 3
				@(posedge vif.sclk);		// define delay like this if we have clk block and modport defined inside interface defn
				@(posedge vif.sclk);

				trans.srst = 1'b0;		// capturing information from DUT through vif(virtual interface)
				trans.m   = vif.m;		// either blk or non-blk assignments
				trans.n   = vif.n;	
				trans.z	  = vif.z;	

				`uvm_info(get_type_name(),"sub_monitor data send to SB",UVM_NONE)
				trans.print();			// just print transctions
				sap.write(trans);		// collecting data into ap		
								// ap has write method which is non-blocking in nature	

			end: B3		
				
		end: B1	


	endtask: mon_capture  


// run_phase:- task bcz contain delay:- driver drive stimuls to DUT and monitor capture information from DUT based on DUT protocol.
//	       executes in parallel and all pre-post run phases.


	virtual task run_phase(uvm_phase phase);

		mon_capture();					// calling the mon_capture task
		
	endtask: run_phase


endclass: sub_monitor



// Driver and monitor often written by the different Verification Engineers.





// ------------------- agent class  ----------------------

// agent is UVC(Universal Verification Component).
// configurable one can be active i.e will have all essential components seqr,drv,mon but if passive then will have only mon.
// agent class is one kind of container and it will contains the objects for sequencer, driver and monitor classes.
// component class in uvm base class hierarchy hence default constructor expecting two arguments.


// agent don't have the run_phase bcz run phase required for the components which are doing some physical jobs like driving
// xtns or collecting xtns, but agent is just a container for seqr, drv and mon hence a part from build and connect phase
// no other phases are required.  


class sub_agent extends uvm_agent;

	
	agent_config			a_cfg;				// instance/handler for agent config class
	sub_driver 			sdrv_h;				// instance/handler for driver class
	uvm_sequencer #(seq_itm2) 	sseqr_h;
	sub_monitor 			smon_h;				// instance/handler for monitor class


	`uvm_component_utils(sub_agent)					// factory regestration

	function new(input string name = "sub_agent", uvm_component parent = null);// component class in UBCH hence two arguments
		super.new(name,parent);
	endfunction: new


// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);				// monitor is there by default bcz its common for both active or passive agent	
	
		smon_h = sub_monitor::type_id::create("smon_h",this);	// using factory's create method creating all lower level components
		a_cfg = agent_config::type_id::create("a_cfg");

		if(!uvm_config_db #(agent_config)::get(this,"","agent_configuration",a_cfg))
		`uvm_fatal(get_type_name(),"Can't get() a_cfg fom uvm_config_db, Have you set it?")

		if(a_cfg.is_active == UVM_ACTIVE) begin: B1		// by default its an UVM_ACTIVE
		//if(get_is_active() == UVM_ACTIVE) begin: B1		// first checking active or passive if active then only creating drv and seqr		
									// multiple statements hence begin end
			sdrv_h  = sub_driver ::type_id::create("sdrv_h",this);	// get_is_active() is of bit type
			sseqr_h = uvm_sequencer #(seq_itm2)::type_id::create("sseqr_h",this);
		end: B1

	endfunction: build_phase


// connect_phase:- responsible for establishing connection between all created components by  port-export
//		   executes in buttom up manner.


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(a_cfg.is_active == UVM_ACTIVE) begin: B1			// one statement hence no begin end	
										// by default its an UVM_ACTIVE
			sdrv_h.seq_item_port.connect(sseqr_h.seq_item_export);	// connection between drvr and seqr 
		end: B1

	endfunction: connect_phase					// connection start with drv bcz it's an initiator
									// driver class is initiator hence have a port(seq_item_port)
									// monitor class is consumer hence have a export(seq_item_export)
endclass: sub_agent							// driver has in built TLM port called seq_item_port
									// and sequencer has built TLM port called seq_item_export



// ------------------- virtual sequencer class ---------------------

// just a container for all the physical sequencers

									
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);		// parmaterize with uvm_sequence_item
										// bcz it's a commen for multiple sequencer(multiple agents will have multiple sequencers) if there depends upon the tb infrasrtucture
	 uvm_sequencer #(seq_itm1) addr_vir_seqr;				// handle of physical sequencers
	 uvm_sequencer #(seq_itm2) sub_vir_seqr;

	`uvm_component_utils(virtual_sequencer)					// FR macrow

	 function new(input string name = "virtual_sequencer", uvm_component parent = null);// default constructor component class in 
		super.new(name,parent);						 // UBCH hence 2 arguments
	 endfunction: new

endclass: virtual_sequencer



// ------------------- scoreboard class ---------------------


// receive transactions from monitor and perform comparasion with golden data.
// implementation details i.e write method(function) of analysis port.
// component class in uvm base class hierarchy hence default constructor expect two arguments
// no need to declare vif here


// ----------------------------------------
// as we have defined two write methods one is in addr_moitor and another is in sub_mon
// so to distinguish those inside of SB class(bcz single SB) we have to make use of macrow `uvm_analysis_imp_dec1  // declared1 and 2
// 
// ----------------------------------------


// as we have two write method in mon classes


  `uvm_analysis_imp_decl(_add)			// declared for adder & for subtractor
  `uvm_analysis_imp_decl(_sub)			

class scoreboard extends uvm_scoreboard;
 
	seq_itm1 data1;						// instance/handler for adder and subtractor transactions class
	seq_itm2 data2;
								// uvm_analysis_imp or tlm_analysis_fifo 
	uvm_analysis_imp_add #(seq_itm1, scoreboard) add_aip;	// uvm_analysis_imp i.e circule and two arguments trans & class where implimentaion
	uvm_analysis_imp_sub #(seq_itm2, scoreboard) sub_aip;	// details r defining here is scoreboard only
								
	

	`uvm_component_utils(scoreboard)			// factory regstration

	function new(input string name = "scoreboard", uvm_component parent = null);	// component in UBCH hence two arguments	
		super.new(name,parent);
		add_aip = new("add_aip",this);			// object for aips
		sub_aip = new("sub_aip",this);
	endfunction: new

				
// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		data1 = seq_itm1::type_id::create("data1");	// object for transaction classs
		data2 = seq_itm2::type_id::create("data2");	
	endfunction: build_phase


// ap has write method which is non-blocking in nature i.e function 
// so unique write method for adder i.e write_add and for subtractor is write_sub



	virtual function void write_add(input seq_itm1 t);	// implementation details for adder

		//data1 = t;					// storing t into data1

		`uvm_info(get_type_name(),"data rcvd from addr_monitor ap",UVM_NONE)
		t.print();					// just print transctions


		if(t.a >=0 && t.b >= 0) begin: B1 		// if >= 0 means valid xtn				
		
			if(t.y == t.a + t.b) begin: B2

				`uvm_info(get_type_name(),"TEST IS PASSED",UVM_NONE)
				 t.print();
			end: B2
			
			else begin: B3
				
				`uvm_info(get_type_name(),"TEST IS FAILED",UVM_NONE)
				t.print();			
			end: B3

		end: B1	
		
		else return;					// if x or z retun out of this method(i.e write_add)

	endfunction: write_add



	virtual function void write_sub(input seq_itm2 t);	// implementation details for adder

		//data2 = t;					// storing t into data2

		`uvm_info(get_type_name(),"data rcvd from sub_monitor ap",UVM_NONE)
		t.print();					// just print transctions


		if(t.m >=0 && t.n >= 0) begin: B1 		// if >= 0 means valid xtn				
		
			if(t.z == t.m - t.n) begin: B2

				`uvm_info(get_type_name(),"TEST IS PASSED",UVM_NONE)
				 t.print();
			end: B2
			
			else begin: B3
				
				`uvm_info(get_type_name(),"TEST IS FAILED",UVM_NONE)
				t.print();			
			end: B3

		end: B1	
		
		else return;					// if x or z retun out of this method(i.e write_sub)

	endfunction: write_sub


endclass: scoreboard



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// ----------------------  env class  ----------------------

// instances of sb, agent and coverage collector if any
// connect analysis port(ap) of monitor and analysis implimentation(aip) port of SB
// monitor is an initiator and SB is a target.




class env extends uvm_env;

	scoreboard 		sb;					// instances for all i.e SB,agent and virtual_sequencer
	adder_agent		add_agth;
	sub_agent		sub_agth;
	virtual_sequencer	v_seqr;					// now env has new component called virtual sequencer
	
		

	`uvm_component_utils(env)					// factory registration

	function new(input string name = "env", uvm_component parent = null);	// component hence two arguments	
		super.new(name,parent);
	endfunction: new 

			
									
// build_phase:- responsible for building all lower level components
//		 executes in top down manner.

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb = scoreboard::type_id::create("sb",this);			// creating all lower level components i.e sb, agent & virtual sequencer
		add_agth = adder_agent::type_id::create("add_agth",this);	// using factory's create method
		sub_agth = sub_agent::type_id::create("sub_agth",this);
		v_seqr = virtual_sequencer::type_id::create("v_seqr",this);
	endfunction: build_phase


// connect_phase:- responsible for establishing connection between all created component by TLM port-export
//		   executes in buttom up manner.

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		add_agth.amon_h.aap.connect(sb.add_aip);		// connection ap of mon and aip of sb, start with mon bcz it's an initiator
		sub_agth.smon_h.sap.connect(sb.sub_aip);

									// sequencer handle which is there is a virtual sequencer
		v_seqr.addr_vir_seqr = add_agth.aseqr_h;		// is pointing towards physical sequencer handle
		v_seqr.sub_vir_seqr  = sub_agth.sseqr_h;		// i.e object assignment statement
									
	endfunction: connect_phase					
	
	
									
endclass: env


// in this complete eg, virtual sequence is here along with virtual sequencer 
// virtual sequence can be used as stand alone i.e single tone class also but need to privide a complete heairachical path in the test class 
// while starting sequence on the sequencer hence its better to use virtual sequence along with virtual sequencer over 
// stand alone object.


// ------------------- base_test class ----------------------


// creating an env and setting a configuration parameter



class base_test extends uvm_test;
	
	env 	  	env_h;							// instances/handler for env 
	agent_config	a_cfg;							// instances/handler for config class

	`uvm_component_utils(base_test)						// factory registration

	function new(input string name = "base_test",uvm_component parent = null);	// component hence two arguments	
		super.new(name,parent);
	endfunction: new

		

// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_h = env::type_id::create("env",this);				// creating an objects for env and generator(sequence)
		a_cfg = agent_config::type_id::create("a_cfg");
		uvm_config_db #(agent_config)::set(this,"*","agent_configuration",a_cfg); // this,"visibility * i.e all component","key",variable
	endfunction: build_phase


// end_of_elaboration_phase:- print_topology executes in buttom up manner.
//	       			

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();	
	endfunction: end_of_elaboration_phase


// report_phase:- display result of the simulation.
//		  executes in buttom up manner.


	virtual function void report_phase(uvm_phase phase);
		
		uvm_report_server svr;

		super.report_phase(phase);

		svr = uvm_report_server::get_server();

		if(svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) > 0) begin: B1

			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)
			`uvm_info(get_type_name(), "-------------- TEST FAIL -------------", UVM_NONE)
			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)

		end: B1
	
		else begin: B2

			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)
			`uvm_info(get_type_name(), "-------------- TEST PASS -------------", UVM_NONE)
			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)

		end: B2

	endfunction: report_phase


endclass: base_test




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// ------------------- virtual sequence class  ----------------------


// in this complete eg, virtual sequence is here along with virtual sequencer 
// virtual sequence can be used as stand alone i.e single tone class also but for testcase writter need to privide a complete heairachical path in  
// the test class while starting sequence on the sequencer hence its better to use virtual sequence along with virtual sequencer over 
// stand alone object.




class virtual_sequence extends uvm_sequence #(uvm_sequence_item);		// parmaterize with uvm_sequence_item bcz it a
										// commen parent for multiple xtns(here is only one i.e seq_itm) depends upon the tb infrasrtucture	

	virtual_sequencer 	  v_seqr;					// handle/instance for virtual sequencer

	uvm_sequencer #(seq_itm1) aseqr_h;					// handles/instances for physical sequencers
	uvm_sequencer #(seq_itm2) sseqr_h;


	sequence1		seq1;						// handle/instance for all sequences
	sequence2		seq2;						// declaring all manually except m_sequencer
										// which is comming through inheritence concept	

			
	`uvm_object_utils(virtual_sequence)					// FR macrow object 

	function new(input string name = "virtual_sequence");			// class in UBCH hence one argument
		super.new(name);
	endfunction: new

	virtual task body();

		//v_seqr = virtual_sequencer::type_id::create("v_seqr");	// creating all
		//seqr_h = sequencer::type_id::create("seqr_h");

		seq1 = sequence1::type_id::create("seq1");			
		seq2 = sequence2::type_id::create("seq2");
		

		if( !$cast(v_seqr, m_sequencer)) begin: B1				// casting betw m_sequencer and v_seqr which is there in v_seq 		 
		 `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")	// m_sequencer which derived from inhereritence concept
		end: B1									// and its of uvm_sequencer type
			
		aseqr_h = v_seqr.addr_vir_seqr;			// object assignment statement so the seqr which is there in the virtual sequence
		sseqr_h = v_seqr.sub_vir_seqr;			// (equivalent to physical seqr i.e LHS)will be point to the seqr which is there in v_seqr of v_seq

		seq1.start(aseqr_h);				// starting seq which is there in v_seq to the seqr which is there in v_seq
		#10;						// will be pointing to the sequencer which is there in the virtual sequencer
		seq2.start(sseqr_h);						 						

	endtask: body							
										

endclass: virtual_sequence


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// ------------------- test class ----------------------


// choose which specific sequence is to be send to driver through sequencer
// i.e starting particular sequence on the sequencer


class test_one extends base_test;

	 

	virtual_sequence  vseq_h;


	`uvm_component_utils(test_one)						// factory registration

	function new(input string name = "test_one", uvm_component parent = null);// component hence two arguments	
		super.new(name,parent);
	endfunction: new

	
// build_phase:- responsible for building all lower level components
//		 executes in top down manner.	


	virtual function void build_phase(uvm_phase phase);		// simply calling super.build_phase bcz parent 
		super.build_phase(phase);				// build_phase constaining a logic corresponding
	endfunction: build_phase					// to config_db and creating the env


// IMP NOTE:- We only call super.build_phase(phase); on components extended from usr defined components, never call 
//	      super.build_phase(phase); on components which are directly extended from uvm_component, uvm_env, or uvm_test 

// run_phase:- task bcz contain delay:- driver drive stimuls to DUT and monitor capture information from DUT based on DUT protocol.
//	       executes in parallel and all pre-post run phases.

//	now test dont have access of sequence it has access of virtual sequence hence we'r starting v_seq on v_seqr which is
//	there in env

	virtual task run_phase(uvm_phase phase);			
		

		vseq_h = virtual_sequence::type_id::create("vseq_h");

		phase.raise_objection(this,"virtual sequence started");	 	
			vseq_h.start(env_h.v_seqr);			// starting virtual sequence on to the cirtual sequener
		phase.drop_objection(this,"virtual sequence ended");	// set a drain time for the env if desired
		
									// so here no need to provied complete heararchical path
									// hence depandency betw test case writter and tb developer
	endtask: run_phase						// can be reduce

									// raise and drop objection mening saying to the UVM
									// that there is some stuff that is to going to be 
									// happen i.e staring v_seq on v_seqr
endclass: test_one




// ------------------- top module ----------------------


module top_tb();


	adder_if avif();					// () is mandatory
	sub_if   svif();

	top DUT(

			.aclk(avif.aclk),			// ADDER DUT instantiation
			.arst(avif.arst),
			.a(avif.a),
			.b(avif.b),
			.y(avif.y),
			

			.sclk(svif.sclk),			// SUB DUT instantiation
			.srst(svif.srst),
			.m(svif.m),
			.n(svif.n),
			.z(svif.z)

			);

								// design(DUT) instantiation	
	initial begin: B1					// :: bcz static method , set and get have 4 arguments
		
		avif.aclk = '0;
		uvm_config_db #(virtual adder_if)::set(null,"*","virtual_adder_intf",avif);// null bcz now its not belong to any class hence null but if inside class(component) then use this
		uvm_config_db #(virtual sub_if)::set(null,"*","virtual_subtractor_intf",svif);	// setting the vif instance from module top to all of the components with the key "vif"
		run_test("test_one");				// run_test is a method(taks) to run specific test with paranethesis we can pass the argument which test name to run like "base_test" in case of SV we need to use $test$plusargs
	end: B1							// so that this run_test method(task) initiates to executes the phases starting for build_phase to final_phase
								// * :- allow all the component to access(visibility)
								// "vif" is a unique id
	always #10 avif.aclk = ~ avif.aclk;			// generating clk of time period is 20ns
	assign svif.sclk = avif.aclk;


endmodule: top_tb


// ------------------------------- RTL for sequential adder  -------------------------------
