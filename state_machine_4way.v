module state_machine(
    input reset,
    input clk_1Hz,
    input [2:0] count1,
    input [2:0] count2,
    input [2:0] count3,
    input [2:0] count4,
    output reg [2:0] st_A,
    output reg [2:0] st_B,
    output reg [2:0] st_C,
    output reg [2:0] st_D
);
    
    parameter AC_1_BD_3 = 2'b00;
    parameter AC_2_BD_3 = 2'b01;
    parameter AC_3_BD_1 = 2'b10;
    parameter AC_3_BD_2 = 2'b11;

    reg [1:0] state_reg;
    reg [7:0] light_counter = 0;
    reg [7:0] t1 = 5;
    reg [7:0] t2 = 5;

    reg [3:0] count12;
    reg [3:0] count34;

    always @(count1, count2, count3, count4) begin
        count12 = (count1 + count2 + 1) >> 1;
        count34 = (count3 + count4 + 1) >> 1;
        t1 = (count12*2 > 60) ? 60 : count12*2;
        t2 = (count34 *2> 60) ? 60 : count34*2;
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if (reset)
            state_reg <= AC_1_BD_3;
        else
            case (state_reg)
                AC_1_BD_3: if (light_counter == t1) state_reg <= AC_2_BD_3;
                AC_2_BD_3: if (light_counter == t1 + (t1 >> 1)) state_reg <= AC_3_BD_1;
                AC_3_BD_1: if (light_counter == t1 + (t1 >> 1) + t2) state_reg <= AC_3_BD_2;
                AC_3_BD_2: if (light_counter == t1 + (t1 >> 1) + t2 + (t2 >> 1)) state_reg <= AC_1_BD_3;
                default: state_reg <= AC_1_BD_3;
            endcase
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if (reset)
            light_counter <= 0;
        else if (light_counter == t1 + (t1 >> 1) + t2 + (t2 >> 1))
            light_counter <= 0;
        else
            light_counter <= light_counter + 1;
    end

    always @(posedge clk_1Hz) begin
        case (state_reg)
            AC_1_BD_3: begin
                st_A = 3'b001;
                st_B = 3'b100;
                st_C = 3'b001;
                st_D = 3'b100;
            end
            AC_2_BD_3: begin
                st_A = 3'b010;
                st_B = 3'b100;
                st_C = 3'b010;
                st_D = 3'b100;
            end
            AC_3_BD_1: begin
                st_A = 3'b100;
                st_B = 3'b001;
                st_C = 3'b100;
                st_D = 3'b001;
            end
            AC_3_BD_2: begin
                st_A = 3'b100;
                st_B = 3'b010;
                st_C = 3'b100;
                st_D = 3'b010;
            end
        endcase
    end

endmodule
