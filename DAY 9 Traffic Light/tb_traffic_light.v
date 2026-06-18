`timescale 1ns / 1ps

module tb_traffic_light;
    reg clk, rst;
    wire [2:0] lights;

    traffic_light_fsm uut (.clk(clk), .rst(rst), .lights(lights));

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #15 rst = 0; // Release reset and let the traffic flow
        
        // Let it run for enough time to see 2-3 full Red-Green-Yellow cycles
        #400 $finish;
    end
endmodule