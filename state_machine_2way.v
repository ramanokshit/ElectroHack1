`timescale 1ns / 1ps

module state_machine(
    input reset,  
    input clk_1Hz,
	 input [3:0]count1,
	 input [3:0] count2,
    output reg [2:0] main_st, 
    output reg [2:0] cross_st 
    );
    
    
    parameter main_green_cross_red  = 2'b00;
    parameter main_yellow_cross_red = 2'b01;
    parameter main_red_cross_green  = 2'b10;
    parameter main_red_cross_yellow = 2'b11;
    
    
    reg [1:0] state_reg; 
    reg [2:0] t1=5;
	 reg[2:0] t2=5;
	 
	 always @(count1,count2)begin
	 t1=count1;
	 t2=count2;
	 end
    
    reg [4:0] light_counter = 0;    // main green = 15 seconds
                                    // main yellow = 3 seconds
                                    // cross green = 10 seconds
                                    // cross yellow = 3 seconds
                                    // total seconds = 31 = 5 bits
    
    // state logic
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset)
            state_reg <= main_green_cross_red;  // reset 
        else
            case(state_reg)
                main_green_cross_red  : if(light_counter == t1)     state_reg <= main_yellow_cross_red;
                main_yellow_cross_red : if(light_counter == t1+(t1>>1))     state_reg <= main_red_cross_green;
                main_red_cross_green  : if(light_counter == t2+t1+(t1>>1))     state_reg <= main_red_cross_yellow;
                main_red_cross_yellow : if(light_counter == t2+(t2>>1)+t1+(t1>>1))     state_reg <= main_green_cross_red;
                default : state_reg <= main_green_cross_red; 
            endcase
    end
	 
    
	
    // Light Counter
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset)
            light_counter <= 0;
				//count1<=0;
				//count2<=0;
        else
            if(light_counter == t2+(t2>>1)+t1+(t1>>1)) //update this
                light_counter <= 0;
            else
                light_counter <= light_counter + 1;
    end
    
    always @(posedge clk_1Hz) begin
        case(state_reg) 
            main_green_cross_red  : begin
                                        main_st  = 3'b001;  // green
                                        cross_st = 3'b100;  // red
                                    end
            main_yellow_cross_red : begin
                                        main_st  = 3'b010;  // yellow
                                        cross_st = 3'b100;  // red
                                    end
            main_red_cross_green  : begin
                                        main_st  = 3'b100;  // red
                                        cross_st = 3'b001;  // green
                                    end
            main_red_cross_yellow : begin
                                        main_st  = 3'b100;  // red
                                        cross_st = 3'b010;  // yellow
                                    end
        endcase
    end
    
endmodule
