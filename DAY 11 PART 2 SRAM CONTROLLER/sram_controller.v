module sram_controller (
    input clk,
    input we,                 // Write Enable: 1 = Write, 0 = Hold
    input re,                 // Read Enable: 1 = Read, 0 = Hold
    input [3:0] addr,         // 4-bit Address bus (to access 0 to 15 locations)
    input [7:0] data_in,      // 8-bit Data Input
    output reg [7:0] data_out // 8-bit Data Output
);

    // The Memory Array: 16 locations, each 8-bits wide
    reg [7:0] memory [0:15];

    // Synchronous Read/Write Operation
    always @(posedge clk) begin
        // Write Operation (Priority to Write)
        if (we == 1'b1) begin
            memory[addr] <= data_in;
        end
        // Read Operation
        else if (re == 1'b1) begin
            data_out <= memory[addr];
        end
    end

endmodule