module asynchoronous_reset_d_flip_flop(
    input d, clk, rst,
    output reg q
); 

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin // Forcefully output 0 as soon as reset is HIGH
        q <= 1'b0;
    end
    else begin // Otherwise, pass data on clock edge
        q <= d;
    end 
end

endmodule