module uart_tx (
    input clk,           // 50 MHz System Clock
    input rst,           // Active High Reset
    input tx_start,      // CPU se signal ki "Data bhejna shuru karo"
    input [7:0] data_in, // 8-bit Data jo CPU bhejna chahta hai
    output reg tx,       // Serial Output Wire (Yahan se bit nikalegi)
    output reg tx_done   // Pulse jab ek poora frame bhej diya jaye
);

    // FSM States
    parameter IDLE  = 2'b00;
    parameter START = 2'b01;
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;

    reg [1:0] state;
    reg [12:0] baud_cnt; // 13-bit counter to count up to 5207
    reg [2:0] bit_cnt;   // To count 8 data bits (0 to 7)
    reg [7:0] tx_data;   // Internal shift register

    always @(posedge clk) begin
        if (rst) begin
            state    <= IDLE;
            tx       <= 1'b1; // UART idle state is always HIGH
            tx_done  <= 1'b0;
            baud_cnt <= 13'b0;
            bit_cnt  <= 3'b0;
            tx_data  <= 8'b0;
        end else begin
            // Default condition
            tx_done <= 1'b0;

            case (state)
                // --- STATE 1: Waiting for command ---
                IDLE: begin
                    tx <= 1'b1;
                    baud_cnt <= 13'b0;
                    if (tx_start) begin
                        tx_data <= data_in; // Data latch karo
                        state <= START;
                    end
                end

                // --- STATE 2: The Start Bit ---
                START: begin
                    tx <= 1'b0; // Start bit is ALWAYS 0
                    if (baud_cnt == 13'd5207) begin
                        baud_cnt <= 13'b0;
                        state <= DATA;
                        bit_cnt <= 3'b0;
                    end else begin
                        baud_cnt <= baud_cnt + 1;
                    end
                end

                // --- STATE 3: Send 8 Data Bits (LSB First) ---
                DATA: begin
                    tx <= tx_data[0]; // Sabse right wali bit line par daalo
                    if (baud_cnt == 13'd5207) begin
                        baud_cnt <= 13'b0;
                        tx_data <= tx_data >> 1; // Data ko right shift karo
                        
                        if (bit_cnt == 3'd7) begin
                            state <= STOP; // 8 bits puri ho gayi
                        end else begin
                            bit_cnt <= bit_cnt + 1;
                        end
                    end else begin
                        baud_cnt <= baud_cnt + 1;
                    end
                end

                // --- STATE 4: The Stop Bit ---
                STOP: begin
                    tx <= 1'b1; // Stop bit is ALWAYS 1
                    if (baud_cnt == 13'd5207) begin
                        baud_cnt <= 13'b0;
                        tx_done <= 1'b1; // CPU ko batao ki kaam ho gaya
                        state <= IDLE;
                    end else begin
                        baud_cnt <= baud_cnt + 1;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule