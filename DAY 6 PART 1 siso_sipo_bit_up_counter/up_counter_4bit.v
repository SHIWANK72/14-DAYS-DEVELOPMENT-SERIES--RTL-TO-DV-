module up_counter_4bit (
    input clk,
    input rst,          // Synchronous Reset
    output reg [3:0] count
);
    // Dhyan do: Sensitivity list mein rst NAHI hai
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            count <= 4'b0000;
        end
        else begin
            count <= count + 1'b1; // Ek-ek karke badhao
        end
    end
endmodule