typedef enum logic [2:0] {IDLE, ACT, READ, WRITE, REFRESH} state_t;

module sdram_controller (
    input  logic clk, rst_n, cmd_valid,
    input  logic [1:0] cmd,
    output logic ras_n, cas_n, we_n, data_valid
);
    state_t state;
    logic [3:0] lat_cnt;
    logic [7:0] ref_cnt;

    // Block 1: FSM State and Refresh Counter
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= IDLE;
            ref_cnt <= 8'd0;
        end else begin
            // Auto-Refresh Logic
            if (ref_cnt >= 8'd100) begin
                state   <= REFRESH;
                ref_cnt <= 8'd0;
            end else begin
                ref_cnt <= ref_cnt + 8'd1; // Fixed 32-bit truncation warning
                // Command Handling
                if (cmd_valid) begin
                    case(cmd)
                        2'b01: state <= ACT;
                        2'b10: state <= READ;
                        2'b11: state <= WRITE;
                        default: state <= IDLE;
                    endcase
                end
            end
        end
    end

    // Block 2: Latency Counter (Isolated in its own block)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lat_cnt <= 4'd0;
        end else begin
            if (state == READ) 
                lat_cnt <= lat_cnt + 4'd1; // Fixed 32-bit truncation warning
            else 
                lat_cnt <= 4'd0;
        end
    end

    // Output Assignments
    assign ras_n = (state == ACT || state == REFRESH) ? 1'b0 : 1'b1;
    assign cas_n = (state == READ || state == WRITE) ? 1'b0 : 1'b1;
    assign we_n  = (state == WRITE) ? 1'b0 : 1'b1;
    
    // Data is valid exactly when latency counter reaches 2
    assign data_valid = (state == READ && lat_cnt == 4'd2);

endmodule