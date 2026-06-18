`timescale 1ns / 1ps
module tb_d_flip_flop;
reg d,clk,rst ;
wire q_sync , q_async;
synchoronous_reset_d_flip_flop uut(
.d(d),.clk(clk),.rst(rst),.q(q_sync));
asynchoronous_reset_d_flip_flop dut(
.d(d),.clk(clk),.rst(rst),.q(q_async));

initial clk=0;

always #50 clk = ~clk ;
initial
begin
$display("Simulation Started for D-Flip Flops!");
$display("Current Time is %0t, Data is %b", $time, d);
$monitor("Time=%0t | RST=%b | D=%b | Async_Q=%b | Sync_Q=%b", $time, rst, d, q_async, q_sync);
d=1'b0 ; rst=1'b0;
#100;
d=1'b0 ; rst=1'b1;
#175;
d=1'b1 ; rst=1'b0;
#225;
d=1'b1 ; rst=1'b1;
#250;


#150$finish;

end
endmodule
