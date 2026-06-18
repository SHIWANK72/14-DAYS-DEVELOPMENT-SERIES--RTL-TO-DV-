`timescale 1ns / 1ps
module tb_alu_8bit_smart;

reg [7:0] a, b;
reg [2:0] alu_sel;
wire [7:0] alu_out;
wire carry_out;

alu_8bit uut (.a(a), .b(b), .alu_sel(alu_sel), .carry_out(carry_out), .alu_out(alu_out));

// 🛠️ MACRO / TASK: Yeh ek choti factory hai jo sequence chalayegi
task run_alu_sequence;
    integer i;
    begin
        alu_sel = 3'bxxx; #50;
        for (i = 0; i < 8; i = i + 1) begin
            alu_sel = i; // 0 se 7 tak khud chalega
            #50;
        end
        alu_sel = 3'bzzz; #50;
    end
endtask

// 🚀 EXECUTION BLOCK: Ek hi timeline!
initial begin
    // Test 1
    a = 8'd9; b = 8'd3; 
    run_alu_sequence(); // Seedha task call karo!

    // Test 2
    a = 8'd255; b = 8'd1;
    run_alu_sequence();

    // Test 3
    a = 8'd200; b = 8'd2; // 689 ki jagah valid 8-bit value
    run_alu_sequence();

    #100 $finish;
end

endmodule