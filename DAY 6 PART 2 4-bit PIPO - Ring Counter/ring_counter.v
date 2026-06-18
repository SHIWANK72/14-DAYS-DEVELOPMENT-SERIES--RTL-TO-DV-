`timescale 1ns / 1ps

module ring_counter (
    input clk,
    input rst,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 4'b0001; // Ek bit ko hamesha '1' rakhna zaroori hai
        end else begin
            // Left shift karo, aur MSB (q[3]) ko wapas LSB ki jagah daal do
            q <= {q[2:0], q[3]}; 
        end
    end

endmodule