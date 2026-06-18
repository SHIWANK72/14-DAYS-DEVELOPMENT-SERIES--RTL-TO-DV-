`timescale 1ns / 1ps

module tb_ring_counter;
    reg clk, rst;
    wire [3:0] q;

    ring_counter uut (.clk(clk), .rst(rst), .q(q));

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #15 rst = 0; // Release reset
        
        // Bas clock chalne do, sequence apne aap ghoomega
        #100 $finish; 
    end
endmodule