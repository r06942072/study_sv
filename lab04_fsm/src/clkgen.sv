module clkgen #(parameter HALF_PERIOD=50) (output logic clk); //clock generator
    initial  clk=0;
    always begin
        #HALF_PERIOD clk = ~clk;
    end
endmodule
