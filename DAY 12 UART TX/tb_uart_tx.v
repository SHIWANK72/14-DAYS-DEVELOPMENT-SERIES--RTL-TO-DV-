`timescale 1ns / 1ps

module tb_uart_tx;

    // Phase 1: Signals and DUT Instantiation
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] data_in;
    wire tx;
    wire tx_done;

    uart_tx uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .data_in(data_in),
        .tx(tx),
        .tx_done(tx_done)
    );

    // 50 MHz Clock Generation (20ns period)
    initial clk = 0;
    always #10 clk = ~clk;

    // Phase 2 & 3: Reset and Stimulus
    initial begin
        // Safe State
        rst = 1;
        tx_start = 0;
        data_in = 8'h00;
        #100;
        
        // Wake up module
        rst = 0;
        #100;

        $display("--- Starting UART TX Test ---");

        // Send Data 0xA5 (10100101)
        // LSB first means wire sequence will be: 1 -> 0 -> 1 -> 0 -> 0 -> 1 -> 0 -> 1
        @(posedge clk);
        data_in = 8'hA5; 
        tx_start = 1;
        
        @(posedge clk);
        tx_start = 0; // Turn off start signal, FSM will handle the rest

        // Phase 4: Wait for FSM to complete
        @(posedge tx_done);
        $display("--- Frame Transmitted Successfully! ---");
        
        #500;
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time = %0t | state = %0d | tx_start = %b | data_in = %h | tx (Wire) = %b | tx_done = %b", 
                 $time, uut.state, tx_start, data_in, tx, tx_done);
    end

endmodule