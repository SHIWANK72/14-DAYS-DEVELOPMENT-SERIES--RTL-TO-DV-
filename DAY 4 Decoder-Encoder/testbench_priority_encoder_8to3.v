module tb_priority_encoder_8to3; 
reg en;
reg [7:0] d;
wire [2:0] o;
priority_encoder_8to3 uut(
.en(en), .d(d), .o(o) 
);
initial 
      begin  
           en=1'b0 ; d= 8'b10000000 ;
#100;
           en=1'b1 ; d = 8'b00010010 ; 
#100;
          en=1'b1 ; d = 8'b00000000 ;
#100;
          en=1'b1 ; d= 8'b10000000;
#100;
          en=1'b1 ; d= 8'b10001010; 
#100;
$finish;
end
endmodule

