module t_ff_sync (
    input clk,
    input rst,
    input t,
    output reg q
);

    // Synchronous Reset: Sirf posedge clk par check karega
    always @(posedge clk) begin 
        if (rst == 1'b1) begin
            q <= 1'b0;
        end 
        else if (t == 1'b1) begin
            q <= ~q;
        end
    end

endmodule