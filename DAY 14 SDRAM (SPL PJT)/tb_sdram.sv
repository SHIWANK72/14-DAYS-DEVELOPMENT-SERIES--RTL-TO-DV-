`include "sdram_controller.sv"

module tb_sdram;
    logic clk, rst_n, cmd_valid;
    logic [1:0] cmd;
    logic ras_n, cas_n, we_n, data_valid;

    sdram_controller dut (.*);

    initial begin
        clk = 0; forever #5 clk = ~clk;
    end

    // SVA: Assert that data is valid only after CAS Latency
    property p_latency;
        @(posedge clk) (dut.state == READ) |=> ##2 (data_valid);
    endproperty
    assert_latency: assert property (p_latency) 
        $display("PASS: Latency verified");
    else 
        $error("FAIL: Latency timing violation!"); // Added fail condition for better DV

    initial begin
        rst_n = 0; cmd_valid = 0; #15 rst_n = 1;
        
        // Stimulus
        repeat(5) @(posedge clk);
        cmd_valid = 1; cmd = 2'b10; // Read Command
        @(posedge clk);
        cmd_valid = 0;
        
        #100 $finish;
    end
endmodule