import risc_pkg::*;

module control_unit (
    input  opcode_t opcode,
    output logic reg_we,
    output logic mem_we,
    output logic mem_re,
    output logic alu_src_imm,
    output logic wb_sel_mem, // 1: write-back from mem, 0: from ALU
    output logic is_jmp,
    output logic is_beq
);

    always_comb begin
        // Default assignments
        reg_we      = 1'b0;
        mem_we      = 1'b0;
        mem_re      = 1'b0;
        alu_src_imm = 1'b0;
        wb_sel_mem  = 1'b0;
        is_jmp      = 1'b0;
        is_beq      = 1'b0;

        case (opcode)
            ADD, SUB, AND, OR, XOR: begin
                reg_we = 1'b1;
            end
            LDI: begin
                reg_we = 1'b1;
                alu_src_imm = 1'b1;
            end
            LOAD: begin
                reg_we = 1'b1;
                mem_re = 1'b1;
                wb_sel_mem = 1'b1;
            end
            STOR: begin
                mem_we = 1'b1;
            end
            JMP: begin
                is_jmp = 1'b1;
            end
            BEQ: begin
                is_beq = 1'b1;
            end
            HALT: ; // Do nothing
            default: ;
        endcase
    end
endmodule