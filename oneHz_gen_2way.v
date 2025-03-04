`timescale 1ns/1ps
module oneHz_gen(
	input clk_50MHz,
    input reset,      
    output clk_1Hz
    );
	 

	 
    reg clk_1Hz_reg = 0;
    reg [25:0] counter_reg = 0;
    
    always @(posedge clk_50MHz or posedge reset) begin
        if(reset)
            counter_reg <= 0;
        else
            if(counter_reg == 24_999_999) begin
                counter_reg <= 0;
                clk_1Hz_reg <= ~clk_1Hz_reg;
            end    
            else
                counter_reg <= counter_reg + 1;
    end
    
	 assign clk_1Hz = clk_1Hz_reg;
    
    
endmodule