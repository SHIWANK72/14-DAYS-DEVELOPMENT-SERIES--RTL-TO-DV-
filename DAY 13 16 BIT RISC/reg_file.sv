module reg_file(input clk, rst_n, we, input [3:0] rs1, rs2, rd, input [15:0] wdata, output [15:0] rdata1, rdata2);
    reg [15:0] regs [0:15];
    assign rdata1 = (rs1 == 0) ? 0 : regs[rs1];
    assign rdata2 = (rs2 == 0) ? 0 : regs[rs2];
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) for(int i=0; i<16; i++) regs[i] <= 0;
        else if (we && rd != 0) regs[rd] <= wdata;
    end
endmodule