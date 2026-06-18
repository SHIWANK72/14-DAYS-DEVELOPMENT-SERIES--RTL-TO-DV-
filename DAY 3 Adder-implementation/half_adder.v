module half_adder(
    input a,       // 1-bit input
    input b,       // 1-bit input
    output sum,    // 1-bit output (wire by default)
    output carry   // 1-bit output (wire by default)
);

    // Continuous assignments - always outside initial/always blocks
    assign sum = a ^ b;    
    assign carry = a & b;  

endmodule