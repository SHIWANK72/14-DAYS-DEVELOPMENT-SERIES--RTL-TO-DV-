module synchoronous_reset_d_flip_flop(
    input d, clk, rst,
    output reg q
); 

always @(posedge clk ) begin
    if (rst == 1'b1) begin
        q  <= 1'b0  ;
    end
    else begin // 
        q  <= d;
    end 
end

endmodule