module priority_encoder_8to3( 
    input [7:0] d, 
    input en, 
    output reg [2:0] o 
); 
    always @(*) begin  
        if (en == 1'b1) begin 
            if (d[7] == 1'b1)      o = 3'b111; 
            else if (d[6] == 1'b1) o = 3'b110; 
            else if (d[5] == 1'b1) o = 3'b101; // Yahan se extra 'if' hata diya
            else if (d[4] == 1'b1) o = 3'b100; 
            else if (d[3] == 1'b1) o = 3'b011; 
            else if (d[2] == 1'b1) o = 3'b010;
            else if (d[1] == 1'b1) o = 3'b001; 
            else if (d[0] == 1'b1) o = 3'b000; 
            else                   o = 3'b000; 
        end 
        else begin
            o = 3'b000; 
        end
    end 
endmodule