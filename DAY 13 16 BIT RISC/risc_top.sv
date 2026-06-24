import risc_pkg::*;
module risc_top (
    input logic clk,
    input logic rst_n,
    output logic [15:0] alu_out
);

    logic [15:0] pc;
    logic [15:0] imem [0:63];
    logic [15:0] dmem [0:63];

    // Declaration ek hi baar hoga!
    logic [15:0] instr;
    opcode_t     opcode;
    logic [3:0]  rd, rs1, rs2;
    logic [15:0] imm;

    // Control signals
    logic reg_we, mem_we, mem_re, alu_src, wb_sel, is_jmp, is_beq;
    logic [15:0] r1, r2, alu_in_b, alu_res, wb_data;
    logic zero;

    // Combinational Decoding
    always_comb begin
        instr  = imem[pc[5:0]];
        opcode = opcode_t'(instr[15:12]);
        rd     = instr[11:8];
        rs1    = instr[7:4];
        rs2    = instr[3:0];
        imm    = {8'h00, instr[7:0]};
    end

    // Control Unit Logic
    always_comb begin
        {reg_we, mem_we, mem_re, alu_src, wb_sel, is_jmp, is_beq} = 7'b0;
        case(opcode)
            ADD, SUB, AND: reg_we = 1;
            LDI: {reg_we, alu_src} = 2'b11;
            LOAD: {reg_we, mem_re, wb_sel} = 3'b111;
            STOR: mem_we = 1;
            JMP: is_jmp = 1;
            BEQ: is_beq = 1;
        endcase
    end

    // Instances (Mapping)
    // Explicit Port Mapping (Safe & Industry Standard)
    reg_file rf (
        .clk(clk), 
        .rst_n(rst_n), 
        .we(reg_we), 
        .rs1(rs1), 
        .rs2(rs2), 
        .rd(rd), 
        .wdata(wb_data), 
        .rdata1(r1), 
        .rdata2(r2)
    );
    alu alu_inst(.alu_ctrl(opcode), .a(r1), .b(alu_src ? imm : r2), .result(alu_res), .zero_flag(zero));

    assign alu_out = alu_res;
    assign wb_data = wb_sel ? dmem[alu_res[5:0]] : alu_res;

    always_ff @(posedge clk) if(mem_we) dmem[alu_res[5:0]] <= r2;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) pc <= 0;
        else if(is_jmp) pc <= imm;
        else if(is_beq && zero) pc <= pc + imm;
        else if(opcode != HALT) pc <= pc + 1;
    end
endmodule