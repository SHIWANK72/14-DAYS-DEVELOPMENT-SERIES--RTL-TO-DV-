import risc_pkg::*;

module tb_risc;

    logic clk;
    logic rst_n;

    // Instantiate Top Module
    risc_top dut (.*);

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // 1. Initialize Assembly Program in Instruction Memory
        // Format: {Opcode, Rd, Rs1, Rs2/Imm}
        
        // R1 = 10
        dut.imem[0] = {LDI, 4'd1, 8'd10};  
        // R2 = 20
        dut.imem[1] = {LDI, 4'd2, 8'd20};  
        // R3 = R1 + R2 (10 + 20 = 30)
        dut.imem[2] = {ADD, 4'd3, 4'd1, 4'd2}; 
        // Store R3 to Data Mem at Address 5
        // First load address 5 to R4
        dut.imem[3] = {LDI, 4'd4, 8'd5};
        // STOR Mem[R4] = R3
        dut.imem[4] = {STOR, 4'd0, 4'd4, 4'd3}; // Rs1=R4(addr), Rs2=R3(data)
        // HALT Processor
        dut.imem[5] = {HALT, 12'h000};     

        // 2. Drive Reset
        clk = 0;
        rst_n = 0;
        #15 rst_n = 1;

        // 3. Monitor Execution
        $display("--- Starting 16-bit RISC Execution ---");
        
        wait(dut.opcode == HALT); // Wait until processor halts
#20; // 2 clock cycle ka buffer daalo (clock period 10ps hai)
        #10; // Give one extra cycle for final write-back
        
        // 4. Self-Checking Mechanism
        $display("\n--- Verification Results ---");
        
        // Check if R3 computed correctly (10 + 20 = 30 / 0x1E)
        if (dut.rf.registers[3] == 16'd30)
            $display("[PASS] ALU Addition: R3 = %0d", dut.rf.registers[3]);
        else
            $error("[FAIL] ALU Addition: Expected 30, Got %0d", dut.rf.registers[3]);

        // Check if Memory Store worked correctly
        if (dut.dmem[5] == 16'd30)
            $display("[PASS] Memory Store: dmem[5] = %0d", dut.dmem[5]);
        else
            $error("[FAIL] Memory Store: Expected 30, Got %0d", dut.dmem[5]);

        $display("--- Testbench Finished ---");
        $finish;
    end

    // Dump waveforms
    initial begin
        $dumpfile("risc_16bit.vcd");
        $dumpvars(0, tb_risc);
    end

endmodule