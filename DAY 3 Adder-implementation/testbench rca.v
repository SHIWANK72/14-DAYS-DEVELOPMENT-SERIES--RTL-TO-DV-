module tb_ripple_carry_adder; 
    reg [3:0] a; 
    reg [3:0] b; 
    reg cin; 
    wire [3:0] sum; 
    wire cout;  

    // Instantiating the top module name correctly
    ripple_carry_adder_4bit uut(  
        .A(a), .B(b), .Cin(cin), .Sum(sum), .Cout(cout) 
    );  

    initial begin  
        a=4'd5; b=4'd3; cin=1'b0 ; #50; 
        a=4'd8; b=4'd6; cin=1'b0 ; #50; 
        a=4'd4; b=4'd8; cin=1'b0 ; #50; 
        a=4'd5; b=4'd2; cin=1'b0 ; #50; 
        a=4'd6; b=4'd5; cin=1'b0 ; #50; 
        a=4'd3; b=4'd4; cin=1'b0 ; #50; 
        a=4'd7; b=4'd7; cin=1'b0 ; #50; 
        a=4'd2; b=4'd1; cin=1'b0 ; #50; 
        $finish; 
    end 

endmodule