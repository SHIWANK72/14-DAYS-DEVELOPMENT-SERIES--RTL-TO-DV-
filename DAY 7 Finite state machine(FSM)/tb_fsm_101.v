`timescale 1ns / 1ps

module tb_fsm_101;
    reg clk, rst, in_bit;
    wire out_moore, out_mealy;

    // Dono modules ko ek sath instantiate kiya
    moore_101_det u_moore (.clk(clk), .rst(rst), .in_bit(in_bit), .out_bit(out_moore));
    mealy_101_det u_mealy (.clk(clk), .rst(rst), .in_bit(in_bit), .out_bit(out_mealy));

    // Clock Generation
    initial clk = 0;
    always #50 clk = ~clk;

    // Stimulus (Input signals bhejna)
    initial begin
        $display("🚀 Day 7: FSM Verification Started!");
        $monitor("Time=%0t | RST=%b | IN=%b || MOORE_OUT=%b | MEALY_OUT=%b", $time, rst, in_bit, out_moore, out_mealy);
        
        // Reset state
        rst = 1; in_bit = 0; #100;
        rst = 0;
        
        // Sequence bhejna shuru: 1, 0, 1 (Detect hona chahiye), 0, 1 (Overlapping detect hona chahiye)
        in_bit = 1; #100;
        in_bit = 0; #100;
        in_bit = 1; #100;  // Yahan 101 poora hua!
        in_bit = 0; #100;
        in_bit = 1; #100;  // Yahan overlapping 101 poora hua!
        in_bit = 0; #200;
        
        $finish;
    end
endmodule