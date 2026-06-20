`timescale 1ns / 1ps

module sync_fifo_tb;

    // Inputs
    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] data_in;

    // Outputs
    wire [7:0] data_out;
    wire full;
    wire empty;

    // Instantiate the RTL module
    sync_fifo uut (
        .clk(clk), 
        .rst(rst), 
        .wr_en(wr_en), 
        .rd_en(rd_en), 
        .data_in(data_in), 
        .data_out(data_out), 
        .full(full), 
        .empty(empty)
    );

    // Clock Generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // 1. Initialize Inputs & Reset
        clk = 0; rst = 1; wr_en = 0; rd_en = 0; data_in = 0;
        
        // Hold reset for 15ns
        #15 rst = 0;

        // 2. Write Data until FIFO is FULL (Push 8 values)
        $display("--- Starting Write Operation ---");
        repeat(8) begin
            @(posedge clk);
            wr_en = 1; 
            data_in = $random % 256; // Generate random 8-bit data
        end
        
        // Try to write one more when full (to check Bug/Overrun protection)
        @(posedge clk);
        data_in = 8'hFF; 
        
        // Stop writing
        @(posedge clk);
        wr_en = 0;

        #20; // Small delay before reading

        // 3. Read Data until FIFO is EMPTY (Pop 8 values)
        $display("--- Starting Read Operation ---");
        repeat(8) begin
            @(posedge clk);
            rd_en = 1;
        end
        
        // Try to read one more when empty (to check Bug/Underrun protection)
        @(posedge clk);
        
        // Stop reading
        @(posedge clk);
        rd_en = 0;

        // 4. Simultaneous Write and Read (Elastic Buffer test)
        #20;
        $display("--- Simultaneous Read/Write ---");
        @(posedge clk);
        wr_en = 1; rd_en = 1; data_in = 8'hAA;
        
        @(posedge clk);
        wr_en = 0; rd_en = 0;

        #30 $finish;
    end

    // Monitor for debugging Console
    initial begin
        $monitor("Time=%0t | rst=%b | wr_en=%b | rd_en=%b | data_in=%h | data_out=%h | wr_ptr=%d | rd_ptr=%d | full=%b | empty=%b", 
                  $time, rst, wr_en, rd_en, data_in, data_out, uut.wr_ptr, uut.rd_ptr, full, empty);
    end

endmodule