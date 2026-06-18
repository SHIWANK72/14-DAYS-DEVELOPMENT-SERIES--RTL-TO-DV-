module tb_mux_4to1;
reg [3:0] i;
reg [1:0] s ; 
wire o ; 


mux_4to1 uut(
.i(i),.s(s),
.o(o));
initial
begin
i=4'b1010;#0;
s=2'b00;#100;
 s=2'b01;#100;
 s=2'b10;#100;
 s=2'b11;#100;
$finish;
end
endmodule
