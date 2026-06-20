module sync_fifo #(
    parameter DEPTH = 8,
    parameter DATA_WIDTH = 8
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

    // Memory Array
    reg [DATA_WIDTH-1:0] fifo_mem [0:DEPTH-1];
    
    // 4-bit Pointers (3 bits for address + 1 bit for wrap-around condition)
    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr;

    // Status Flags Combinational Logic
    assign empty = (wr_ptr == rd_ptr);
    assign full  = (wr_ptr[3] != rd_ptr[3]) && (wr_ptr[2:0] == rd_ptr[2:0]);

    // Write Logic (Sequential)
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 4'b0000;
        end else if (wr_en && !full) begin
            fifo_mem[wr_ptr[2:0]] <= data_in; // Use lower 3 bits for address
            wr_ptr <= wr_ptr + 1;
        end
    end

    // Read Logic (Sequential)
    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= 4'b0000;
            data_out <= 8'b00000000;
        end else if (rd_en && !empty) begin
            data_out <= fifo_mem[rd_ptr[2:0]];
            rd_ptr <= rd_ptr + 1;
        end
    end

endmodule