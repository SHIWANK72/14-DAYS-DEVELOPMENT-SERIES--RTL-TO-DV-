module demux_1to4(
    input i,
    input [1:0] s,
    output reg [3:0] o
); 

always @(*) begin
    o = 4'b0000; // Complete vector initialization to fix that accumulation bug!
    case(s)
        2'b00 : o[0] = i;
        2'b01 : o[1] = i;
        2'b10 : o[2] = i;
        2'b11 : o[3] = i;
        default : o = 4'b0000; // Added explicit colon here
    endcase
end

endmodule
