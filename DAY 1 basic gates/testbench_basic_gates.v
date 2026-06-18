module tb_basic_gates;
reg a,b;
wire out_and,out_or,out_not1,out_not2,out_xor;
basic_gates uut(
.a(a), .b(b),
.out_and(out_and), .out_or(out_or), .out_not1(out_not1), .out_not2(out_not2), .out_xor(out_xor)
);
initial
begin
a=0;b=0;#100;
a=1;b=0;#100;
a=1;b=1;#100;
a=0;b=1;#100;

$finish;
end
endmodule
