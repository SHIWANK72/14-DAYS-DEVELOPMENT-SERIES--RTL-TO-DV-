module alu_8bit (
    input [7:0] a, b,        // 8-bit thick input wires
    input [2:0] alu_sel,     // 3-bit selector switch
    output reg [7:0] alu_out,// 8-bit output result (reg because inside always block)
    output reg carry_out     // 1-bit output flag for overflow
);

    always @(*) begin
        // Default values to prevent unwanted memory (Latches)
        carry_out = 1'b0; 
        
        case(alu_sel)
            // Addition with Carry extraction (9-bit bundle)
            3'b000: {carry_out, alu_out} = a + b; 
            
            3'b001: alu_out = a - b;
            3'b010: alu_out = a & b;
            3'b011: alu_out = a | b;
            3'b100: alu_out = a ^ b;
            3'b101: alu_out = a << 1; // Standard ALU shifts by 1 bit
            3'b110: alu_out = a >> 1;
            3'b111: alu_out = a;      // Just pass 'a' through
            
            // Safety net
            default: alu_out = 8'h00; 
        endcase
    end

endmodule

