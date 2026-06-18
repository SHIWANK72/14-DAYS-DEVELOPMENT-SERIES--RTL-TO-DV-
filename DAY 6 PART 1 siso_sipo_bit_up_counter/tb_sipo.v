`timescale 1ns / 1ps
module tb_sipo_4bit;
    reg clk, rst, serial_in;
    wire [3:0] parallel_out;

    sipo_4bit uut (
        .clk(clk), .rst(rst), .serial_in(serial_in), .parallel_out(parallel_out)
    );

    initial clk = 0;
    always #50 clk = ~clk;

    initial begin
        $display("🚀 SIPO Simulation Started!");
        $monitor("Time=%0t | RST=%b | IN=%b | PARALLEL_OUT=%b", $time, rst, serial_in, parallel_out);
        
        rst = 1; serial_in = 0; #100;
        rst = 0; 
        
        serial_in = 1; #100;
        serial_in = 1; #100;
        serial_in = 0; #100;
        serial_in = 1; #100;
        
        #100 $finish;
    end
endmodule