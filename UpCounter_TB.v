`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2025 05:06:45 PM
// Design Name: 
// Module Name: UpCounter_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UpCounter_TB();
    reg clk;
    reg rst;
    reg en;
    wire [11:0] q;
    
    UpCounter DUT(.clk(clk),.rst(rst),.en(en),.q(q));
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        en =0;
        
        @(posedge clk);
        rst = 0;
        
        @(posedge clk); en = 1;
        @(posedge clk); en = 0;
        
        @(posedge clk); en = 1;
        @(posedge clk); en = 0;
        
        @(posedge clk); en = 1;
        @(posedge clk); en = 0;
        
        @(posedge clk);
        @(posedge clk);
        
        @(negedge clk); rst=1;
        @(posedge clk);
        @(negedge clk); rst=0;
        
        @(posedge clk); en = 1;
        @(posedge clk); en = 0;
        
        @(posedge clk); en = 1;
        @(posedge clk); en = 0;
        
        #50;
        $finish;
     end    
endmodule
