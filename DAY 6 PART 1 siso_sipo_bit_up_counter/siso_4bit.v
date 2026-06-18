module siso_4bit (
    input clk,
    input rst,          // Asynchronous Reset
    input serial_in,
    output serial_out
);
    reg [3:0] shift_reg;
    
    assign serial_out = shift_reg[3]; // Aakhri dabbe ka data bahar

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            shift_reg <= 4'b0000;
        end
        else begin
            shift_reg <= {shift_reg[2:0], serial_in}; // Left shift and insert
        end
    end
endmodule