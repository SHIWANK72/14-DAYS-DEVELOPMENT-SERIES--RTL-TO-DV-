`timescale 1ns / 1ps

module tb_t_ff_async;
    // Lab switches (reg)
    reg clk;
    reg rst;
    reg t;
    
    // Observation wire (wire)
    wire q;

    // Chip Instantiation
    t_ff_async uut (
        .clk(clk),
        .rst(rst),
        .t(t),
        .q(q)
    );

    // Clock Generator (10ns period)
    always #5 clk = ~clk;

    initial begin
        // 1. Initial State Setup
        clk = 0; rst = 1; t = 0;
        
        // 2. Release Reset and start testing
        #15 rst = 0; t = 1; // T=1, Clock aayegi toh q toggle karega (0 -> 1)
        #20 t = 0;          // T=0, q hold karega (1 hi rahega)
        #20 t = 1;          // T=1, q wapas toggle karega (1 -> 0 -> 1)
        
        // 3. THE ASYNC TEST (Crucial Step)
        #12;      // Clock ke beech mein (jab edge nahi hai) reset daba diya!
        rst = 1;  // Dhyan dena waveform mein, q turant 0 ho jayega!
        #10 rst = 0;

        #30 $finish;
    end
endmodule