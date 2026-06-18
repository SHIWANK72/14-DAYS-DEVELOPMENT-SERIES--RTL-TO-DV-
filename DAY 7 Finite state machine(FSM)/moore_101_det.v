module moore_101_det (
    input clk, 
    input rst, 
    input in_bit,
    output reg out_bit
);
    // 4 States (Binary encoding)
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    
    reg [1:0] current_state, next_state;

    // Block 1: State Memory (D-Flip Flops)
    always @(posedge clk or posedge rst) begin
        if (rst) 
            current_state <= S0;
        else 
            current_state <= next_state;
    end

    // Block 2: Next State Logic (Combinational)
    always @(*) begin
        case(current_state)
            S0: next_state = in_bit ? S1 : S0;
            S1: next_state = in_bit ? S1 : S2;
            S2: next_state = in_bit ? S3 : S0;
            S3: next_state = in_bit ? S1 : S2; // Overlapping allow kar raha hai
            default: next_state = S0;
        endcase
    end

    // Block 3: Output Logic (Depends ONLY on current_state)
    always @(*) begin
        if (current_state == S3)
            out_bit = 1'b1;
        else
            out_bit = 1'b0;
    end
endmodule