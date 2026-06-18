`timescale 1ns / 1ps
module tb_siso_4bit;
    reg clk, rst, serial_in;
    wire serial_out;

    siso_4bit uut (
        .clk(clk), .rst(rst), .serial_in(serial_in), .serial_out(serial_out)
    );

    initial clk = 0;
    always #50 clk = ~clk; // 100ns period

    initial begin
        $display("🚀 SISO Simulation Started!");
        $monitor("Time=%0t | RST=%b | IN=%b | OUT=%b", $time, rst, serial_in, serial_out);
        
        // Reset sequence
        rst = 1; serial_in = 0; #100;
        rst = 0; 
        
        // Sending data: 1, 0, 1, 1 (Wait 100ns per bit for clock edge)
        serial_in = 1; #100;
        serial_in = 0; #100;
        serial_in = 1; #100;
        serial_in = 1; #100;
        serial_in = 0; #200; // Extra time to watch data shift out
        
        $finish;
    end
endmodule