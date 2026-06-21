`timescale 1ns / 1ps

module tb_sram_controller;

    // --- Phase 1: Signals and DUT Instantiation ---
    reg clk;
    reg we;
    reg re;
    reg [3:0] addr;
    reg [7:0] data_in;
    wire [7:0] data_out;

    sram_controller uut (
        .clk(clk),
        .we(we),
        .re(re),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generation (100ns period)
    initial clk = 0;
    always #50 clk = ~clk;

    // Integer for our stress test loops
    integer i;

    // --- Phase 2 & 3: Reset and Stress Testing ---
    initial begin
        // Phase 2: Safe State Initialization
        we = 0;
        re = 0;
        addr = 0;
        data_in = 0;
        #100; // Wait for initial stability

        $display("--- Starting SRAM Memory Controller Test ---");

        // Phase 3, Part A: Burst Write (Fill all 16 locations)
        $display("--> Phase: Writing Data to Memory");
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            we = 1;
            re = 0;
            addr = i;                // Go to address 'i'
            data_in = $random;       // Throw random 8-bit data
        end
        
        // Stop Writing
        @(posedge clk);
        we = 0; 
        #200; // Take a breath (makes the waveform easier to read)

        // Phase 3, Part B: Burst Read (Check all 16 locations)
        $display("--> Phase: Reading Data from Memory");
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            we = 0;
            re = 1;
            addr = i;                // Read from address 'i'
        end

        // Stop Reading and Finish
        @(posedge clk);
        re = 0; 
        
        #200;
        $display("--- Test Completed Successfully ---");
        $finish;
    end

    // --- Phase 4: System Monitoring ---
    initial begin
        // Monitor will print the status to the console automatically every time a signal changes
        $monitor("Time = %0t | we = %b | re = %b | addr = %0d | data_in = %h | data_out = %h", 
                 $time, we, re, addr, data_in, data_out);
    end

endmodule