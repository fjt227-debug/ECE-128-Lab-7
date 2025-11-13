
module Bin12to16BCD_TB();
reg clk, en;
reg [11:0] bin_d_in;
wire [15:0] bcd_d_out; 
wire rdy;

Bin12to16BCD uut (.clk(clk), .en(en), .bin_d_in(bin_d_in), .bcd_d_out(bcd_d_out), .rdy(rdy));
initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
    en = 0;
    bin_d_in = 12'b0000_0000_0000;
    #10;
    
   
    bin_d_in = 12'b000_0001_0001;
    en = 1;
    @(posedge clk);
    en = 0;
    @(posedge rdy);
    #10;
    
 
    bin_d_in = 12'b0011_1001_1101;
    en = 1;
    @(posedge clk);
    en = 0;
    @(posedge rdy);
    #10;
    
  
    bin_d_in = 12'b1111_1111_1111;
    en = 1;
    @(posedge clk);
    en = 0;
    @(posedge rdy);
    #10;
    $finish;
    
end
endmodule
