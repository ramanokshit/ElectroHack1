`timescale 1ns / 1ps



//new code for openCV counter 

//2 way street



module traffic_controller(
    input reset,            // button
    input clk_50MHz,
	 input [3:0]count1,
	 input [3:0] count2,
    output [2:0] main_st,   // LEDs
    output [2:0] cross_st // LEDs
    );
    
    wire w_1Hz, w_reset;
    
    state_machine sm(.reset(w_reset), .clk_1Hz(w_1Hz), 
                     .main_st(main_st), .cross_st(cross_st),
							.count1(count1), .count2(count2)
							);
    oneHz_gen uno(.clk_50MHz(clk_50MHz), .reset(w_reset), .clk_1Hz(w_1Hz),);
    sw_debounce db(.clk(clk_50MHz), .btn_in(reset), .btn_out(w_reset) );
    
endmodule