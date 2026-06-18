module sipo_4bit (
    input clk,
    input rst,
    input serial_in,
    output [3:0] parallel_out // 4-bit mota taar (bus)
);
    reg [3:0] shift_reg;
    
    assign parallel_out = shift_reg; // Poora dabba ek sath bahar connect kar diya

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            shift_reg <= 4'b0000;
        end
        else begin
            shift_reg <= {shift_reg[2:0], serial_in};
        end
    end
endmodule