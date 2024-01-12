module design_fsm(
    input logic  clk,
    input logic  rst_n,   
    input logic  start_fsm,
    output logic [1:0] cs_fsm
);
    //localparam cannot be overrided in inst
    localparam IDLE   = 0;
    localparam FIRST  = 1;
    localparam SECOND = 2;
    localparam LAST   = 3;

    logic [1:0] cs; //current state
    logic [1:0] ns; //next state

    assign cs_fsm = cs;

    always @(posedge clk) begin
        if(!rst_n) begin
            cs <= IDLE;
        end else begin
            cs <= ns;
        end
    end

    always @(*) begin
        case(cs) 
            IDLE: 
                ns = (start_fsm) ? FIRST: IDLE;
            FIRST:
                ns = SECOND;
            SECOND:
                ns= LAST;
            LAST:
                ns = IDLE;
            default:
                ns = IDLE;
        endcase   
    end

endmodule
