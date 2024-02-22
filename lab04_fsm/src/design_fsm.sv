module design_fsm( 
    input logic  clk,   //port
    input logic  rst_n, //port
    input logic  start_fsm,
    output logic [1:0] cs_fsm
);
    //In fsm, localparam cannot be overrided in inst
	//parameter IDLE = 0; <-- this is also possible
    localparam IDLE   = 0;
    localparam FIRST  = 1;
    localparam SECOND = 2;
    localparam LAST   = 3;

    logic [1:0] cs; //current state, unknown 
    logic [1:0] ns; //next state

    assign cs_fsm = cs;
	
	//seq logic
    always @(posedge clk) begin
        if(!rst_n) begin
            cs <= IDLE; 
        end else begin
            cs <= ns;
        end
    end
	
	//comb logic
    always @(*) begin
        case(cs) 
            IDLE: 
                ns = (start_fsm) ? FIRST: IDLE;  // (condition)? cond==1: cond==0
            FIRST:
                ns = SECOND;
				//ns = FIRST, <---bug
            SECOND:
                ns= LAST;
            LAST:
                ns = IDLE;
            default:
                ns = IDLE;
        endcase   
    end
/*
	logic [254:0] abc; 
    always @(posedge clk) begin
        if(!rst_n) begin
            abc <= 0;  
        end else begin (start_fsm)
            abc <= abc + 1;
        end
    end
*/
endmodule
