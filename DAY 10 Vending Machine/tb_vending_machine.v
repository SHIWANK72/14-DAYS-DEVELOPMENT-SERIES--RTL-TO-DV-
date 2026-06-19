`timescale 1ns / 1ps

module tb_vending_machine;
    // Lab Signals
    reg clk;
    reg rst;
    reg [1:0] coin;
    wire dispense;
    wire [2:0] change;

    // Instantiate the Vending Machine Chip
    vending_machine uut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense),
        .change(change)
    );

    // Clock Generator (10ns Time Period)
    always #5 clk = ~clk;

    initial begin
        // 1. Boot up the machine
        clk = 0; rst = 1; coin = 2'b00;
        #15 rst = 0;
        
        // ----------------------------------------
        // TEST CASE 1: 5 + 5 + 5 = 15 (Exact)
        // ----------------------------------------
        $display("Testing Case 1: Inserting 5, 5, 5...");
        #10 coin = 2'b01; // Insert 5  (Total = 5)
        #10 coin = 2'b01; // Insert 5  (Total = 10)
        #10 coin = 2'b01; // Insert 5  (Total = 15) -> Dispense!
        #10 coin = 2'b00; // Standby
        #20;

        // ----------------------------------------
        // TEST CASE 2: 10 + 5 = 15 (Exact)
        // ----------------------------------------
        $display("Testing Case 2: Inserting 10, 5...");
        #10 coin = 2'b10; // Insert 10 (Total = 10)
        #10 coin = 2'b01; // Insert 5  (Total = 15) -> Dispense!
        #10 coin = 2'b00; // Standby
        #20;

        // ----------------------------------------
        // TEST CASE 3: 10 + 10 = 20 (Needs Change)
        // ----------------------------------------
        $display("Testing Case 3: Inserting 10, 10 (Overflow test)...");
        #10 coin = 2'b10; // Insert 10 (Total = 10)
        #10 coin = 2'b10; // Insert 10 (Total = 20) -> Dispense + Change 5!
        #10 coin = 2'b00; // Standby
        #30;

        $finish;
    end
    
    // Console Monitor
    initial begin
        $monitor("Time=%0t | Coin_In=%b | FSM_State=%d | Dispense=%b | Return_Change=%d", 
                 $time, coin, uut.current_state, dispense, change);
    end

endmodule