`timescale 1ns / 1ps

module traffic_light_fsm (
    input clk,
    input rst,
    output reg [2:0] lights // [2]: Red, [1]: Yellow, [0]: Green
);

    // State Encoding
    parameter S_RED = 2'd0, S_GREEN = 2'd1, S_YELLOW = 2'd2;
    
    reg [1:0] state;
    reg [3:0] timer; // 4-bit timer (counts max up to 15)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_RED;
            timer <= 4'd10;     // Red starts with 10 clock cycles
            lights <= 3'b100;   // Red Light ON
        end else begin
            if (timer > 0) begin
                timer <= timer - 1; // Timer ko ghatao
            end else begin
                // Jab timer 0 ho jaye, toh State change karo
                case (state)
                    S_RED: begin
                        state <= S_GREEN;
                        timer <= 4'd8;      // Green lasts 8 clocks
                        lights <= 3'b001;   // Green Light ON
                    end
                    S_GREEN: begin
                        state <= S_YELLOW;
                        timer <= 4'd3;      // Yellow lasts 3 clocks
                        lights <= 3'b010;   // Yellow Light ON
                    end
                    S_YELLOW: begin
                        state <= S_RED;
                        timer <= 4'd10;     // Back to Red
                        lights <= 3'b100;   // Red Light ON
                    end
                    default: state <= S_RED;
                endcase
            end
        end
    end

endmodule