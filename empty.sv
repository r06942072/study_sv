-------------------------------------------------
module wheel;
	logic [1:0] radius; //unknown, 2'bxx binary
	string color;
	initial begin
		wheel.color = "black"; 
		color = "black";
	end
endmodule

module motorcycle;  
	parameter num = 2;
	wheel u1; //wheel = module name, u1 = inst name
	wheel u2; //instance, 
endmodule

module car; 
	//generate: to generate instance in a given scope
	parameter num = 4;
	for (i=0; i<p; i=i+1) begin:a
		wheel inst_i();
	end

	wheel inst1;
	wheel inst2;
	wheel inst3;
	wheel inst4;
	initial begin
		c1.inst1.radius = 2'd3; ????
		inst1.radius = 2'd3;
		inst2.radius = 2'd3;
		inst3.radius = 2'd3;
		inst4.radius = 2'd3;
	end
endmodule

module garage; //top
	//two motorcycles, one car
	car c1;
	motorcycle m1;
	motorcycle m2;
	turck #(8) t1;
	initial begin
		c1.inst1.radius = 2'd3;
		c1.inst2.radius = 2'd3;
		c1.inst3.radius = 2'd3;
		c1.inst4.radius = 2'd3;
		m1.u1.radius = 2'd1;
		m1.u2.radius = 2'd1;
		m2.u1.radius = 2'd1;
		m2.u2.radius = 2'd1;
	end
endmodule
