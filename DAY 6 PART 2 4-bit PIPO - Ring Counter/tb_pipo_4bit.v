`timescale 1ns / 1ps

module tb_pipo_4bit;
    reg clk, rst;
    reg [3:0] d;
    wire [3:0] q;

    pipo_4bit uut (.clk(clk), .rst(rst), .d(d), .q(q));

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0; rst = 1; d = 4'b0000;
        #15 rst = 0; // Release reset
        
        // Random Data Tests
        d = 4'b1010; #10;
        d = 4'b1100; #10;
        d = 4'b0111; #10;
        d = 4'b1111; #10;
        
        // Apply reset in between
        rst = 1; #10;
        rst = 0; d = 4'b0001; #10;
        
        #20 $finish;
    end
endmodule