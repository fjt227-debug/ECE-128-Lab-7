`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2025 03:13:47 PM
// Design Name: 
// Module Name: UpCounter
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


module UpCounter(
input wire clk,
input wire rst,
input wire en,
output reg [11:0] q);

always @(posedge clk) begin
    if (rst) begin
        q <= 12'd0;
    end
    else if (en) 
    begin
            if (q == 12'd4095)
                q <= 12'd0;
            else
                q <= q + 12'd1;
        end 
    end
endmodule
