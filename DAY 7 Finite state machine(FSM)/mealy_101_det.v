module mealy_101_det (
    input clk, 
    input rst, 
    input in_bit,
    output reg out_bit
);
    // Sirf 3 States chahiye
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    
    reg [1:0] current_state, next_state;

    // Block 1: State Memory
    always @(posedge clk or posedge rst) begin
        if (rst) 
            current_state <= S0;
        else 
            current_state <= next_state;
    end

    // Block 2: Next State Logic
    always @(*) begin
        case(current_state)
            S0: next_state = in_bit ? S1 : S0;
            S1: next_state = in_bit ? S1 : S2;
            S2: next_state = in_bit ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // Block 3: Output Logic (Depends on current_state AND in_bit)
    always @(*) begin
        case(current_state)
            S0: out_bit = 1'b0;
            S1: out_bit = 1'b0;
            // Agar S2 mein hai (pehle 10 aa chuka hai) aur naya input 1 hai, toh output 1 kar do!
            S2: out_bit = in_bit ? 1'b1 : 1'b0; 
            default: out_bit = 1'b0;
        endcase
    end
endmodule