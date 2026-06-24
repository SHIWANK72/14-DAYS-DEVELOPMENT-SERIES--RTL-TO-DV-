package risc_pkg;
    typedef enum logic [3:0] {
        ADD=4'b0000, SUB=4'b0001, AND=4'b0010, OR=4'b0011, 
        XOR=4'b0100, LOAD=4'b0101, STOR=4'b0110, JMP=4'b0111, 
        BEQ=4'b1000, LDI=4'b1001, HALT=4'b1111
    } opcode_t;
endpackage