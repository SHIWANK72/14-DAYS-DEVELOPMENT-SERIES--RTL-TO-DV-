module mux_4to1(
    input [3:0] i,
    input [1:0] s,
    output reg o 
);

always @(*) begin
    case(s)
        2'b00: o = i[0];
        2'b01: o = i[1];
        2'b10: o = i[2];
        2'b11: o = i[3];
        default: o = 1'b0; // Assigning a single 1-bit 0 to a 1-bit output
    endcase
end

endmodule
