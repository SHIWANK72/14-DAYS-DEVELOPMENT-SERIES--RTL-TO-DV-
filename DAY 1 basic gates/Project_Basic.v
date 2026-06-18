module basic_gates(a,b,out_and,out_or,out_not1,out_not2,out_xor); 
input a,b;
 output out_and,out_or,out_not1,out_not2,out_xor;  
assign out_and = a & b ;
 assign out_or = a|b ;
 assign out_not1 = ~a;
 assign out_not2 = ~b ;
 assign out_xor = a^b ;
 endmodule
