module tb_demux_1to4; 
  reg i; 
  reg [1:0] s; 
  wire [3:0] o; 

  // Instantiation
  demux_1to4 uut ( 
    .i(i), 
    .s(s), 
    .o(o)
  ); 

  // Stimulus
  initial begin 
    i = 1; #50; 
    s = 2'b00; #100;
    s = 2'b01; #100;
    s = 2'b10; #100;
    s = 2'b11; #100; 
    $finish; 
  end 

endmodule // Fixed here!