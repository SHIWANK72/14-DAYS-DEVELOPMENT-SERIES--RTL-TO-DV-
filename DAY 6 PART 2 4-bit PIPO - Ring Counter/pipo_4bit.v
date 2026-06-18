
module pipo_4bit (
    input clk,
    input rst,
    input [3:0] d,    // 4-bit parallel input
    output reg [3:0] q // 4-bit parallel output
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 4'b0000; // Reset par sab zero
        end else begin
            q <= d;       // Clock aate hi data copy
        end
    end

endmodule