`timescale 1ns / 1ps
module tb_up_counter_4bit;
    reg clk, rst;
    wire [3:0] count;

    up_counter_4bit uut (
        .clk(clk), .rst(rst), .count(count)
    );

    initial clk = 0;
    always #50 clk = ~clk;

    initial begin
        $display("🚀 4-Bit Counter Simulation Started!");
        // %0d use kiya hai taaki binary ke sath decimal (0-15) bhi print ho
        $monitor("Time=%0t | RST=%b | COUNT(Binary)=%b | COUNT(Dec)=%0d", $time, rst, count, count);
        
        // Reset ON
        rst = 1; #125; 
        
        // Start counting
        rst = 0; #1000; // 10 clock cycles tak ginte raho (1000ns)
        
        // Beech mein achanak reset maaro (Synchronous check karne ke liye)
        rst = 1; #100; 
        
        // Fir se count start karo
        rst = 0; #300; 
        
        $finish;
    end
endmodule