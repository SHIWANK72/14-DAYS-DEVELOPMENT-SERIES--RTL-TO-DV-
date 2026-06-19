module vending_machine (
    input clk,
    input rst,
    input [1:0] coin,      // 00: No coin, 01: ₹5, 10: ₹10
    output reg dispense,   // 1 jab product bahar aayega
    output reg [2:0] change // Change amount (0 ya 5)
);

    // State Encoding (Represents accumulated money)
    parameter S_0  = 3'd0,
              S_5  = 3'd1,
              S_10 = 3'd2,
              S_15 = 3'd3, // Target reached
              S_20 = 3'd4; // Target crossed (Needs change)
              
    reg [2:0] current_state, next_state;

    // 1. Sequential Logic (Memory block updating the state)
    always @(posedge clk or posedge rst) begin
        if (rst) 
            current_state <= S_0;
        else 
            current_state <= next_state;
    end

    // 2. Combinational Logic (Next State Math/Routing)
    always @(*) begin
        next_state = current_state; // Default (Hold state agar coin na aaye)
        case (current_state)
            S_0: begin
                if (coin == 2'b01) next_state = S_5;
                else if (coin == 2'b10) next_state = S_10;
            end
            S_5: begin
                if (coin == 2'b01) next_state = S_10;
                else if (coin == 2'b10) next_state = S_15;
            end
            S_10: begin
                if (coin == 2'b01) next_state = S_15;
                else if (coin == 2'b10) next_state = S_20;
            end
            S_15: next_state = S_0; // Product dene ke baad wapas zero
            S_20: next_state = S_0; // Product aur change dene ke baad wapas zero
            default: next_state = S_0;
        endcase
    end

    // 3. Output Logic (Moore Machine - Outputs depend ONLY on state)
    always @(*) begin
        // Default Outputs (Taaki latch na bane)
        dispense = 1'b0;
        change   = 3'd0;
        
        case (current_state)
            S_15: begin
                dispense = 1'b1;  // Product Nikalo
                change   = 3'd0;  // Koi khulle paise wapas nahi karne
            end
            S_20: begin
                dispense = 1'b1;  // Product Nikalo
                change   = 3'd5;  // ₹5 wapas karo
            end
        endcase
    end

endmodule