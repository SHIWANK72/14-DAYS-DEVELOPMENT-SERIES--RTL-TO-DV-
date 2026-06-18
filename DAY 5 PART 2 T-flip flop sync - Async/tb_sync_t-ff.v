`timescale 1ns / 1ps

module tb_t_ff_sync;
    // Lab switches
    reg clk;
    reg rst;
    reg t;
    
    // Observation wire
    wire q;

    // Chip Instantiation
    t_ff_sync uut (
        .clk(clk),
        .rst(rst),
        .t(t),
        .q(q)
    );

    // Clock Generator
    always #5 clk = ~clk;

    initial begin
        // 1. Initial State Setup
        clk = 0; rst = 1; t = 0;
        
        // 2. Release Reset
        #15 rst = 0; t = 1; // Toggle on
        #20 t = 0;          // Hold state
        #20 t = 1;          // Toggle again
        
        // 3. THE SYNC TEST (Crucial Step)
        #12;      // Clock ke beech mein reset daba diya!
        rst = 1;  // Dhyan dena, q turant 0 NAHI hoga! Wo wait karega agli posedge clk ka!
        #10 rst = 0;

        #30 $finish;
    end
endmodule