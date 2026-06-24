import risc_pkg::*;
module alu(input opcode_t alu_ctrl, input [15:0] a, b, output reg [15:0] result, output zero_flag);
    assign zero_flag = (result == 16'h0000);
    always_comb begin
        case(alu_ctrl)
            ADD: result = a + b;
            SUB: result = a - b;
            AND: result = a & b;
            OR:  result = a | b;
            XOR: result = a ^ b;
            LDI: result = b;
            default: result = 0;
        endcase
    end
endmodule