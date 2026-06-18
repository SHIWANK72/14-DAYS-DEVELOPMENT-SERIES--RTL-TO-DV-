module tb_decoder_3to8;
 reg en ;
 reg [2:0] in ;
 wire [7:0]out;
 decoder_3to8 uut (
 .en(en), 
.in(in),
 .out(out)
);
 initial
 begin
 en=1'b0;in=3'b111;
#100; 
en=1'b1;in=3'b000;
#100;
 en=1'b1;in=3'b100;
#100; 
en=1'b1;in=3'b110;
#100;
en=1'b1;in=3'b111;
#100;
 $finish;
 end
 endmodule