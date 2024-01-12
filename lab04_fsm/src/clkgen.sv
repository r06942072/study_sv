module clkgen #(parameter HALF_PERIOD=50) (output logic clk);
    initial  clk=0;
    always begin
        #HALF_PERIOD clk = ~clk;
    end
endmodule
