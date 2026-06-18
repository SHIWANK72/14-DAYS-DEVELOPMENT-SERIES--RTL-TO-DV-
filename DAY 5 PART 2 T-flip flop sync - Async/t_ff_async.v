module t_ff_async (
    input clk,
    input rst,
    input t,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            q <= 1'b0;
        end 
        else begin
            if (t == 1'b1) begin
                q <= ~q; // Toggle
            end
            // Agar t == 0 hai, toh wo automatically purani state (q) hold karega
        end
    end

endmodule
