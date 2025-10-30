`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2025 05:27:47 PM
// Design Name: 
// Module Name: BCD12to16
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


module BCD12to16(
input wire [11:0] bin,
output reg [15:0] bcd);
integer i;
reg [27:0] shift;

always @* begin
    shift = {16'd0, bin};
    for (i=0; i<12; i=i+1) 
      begin
        if (shift[27:24]>=4'd5) 
            shift[27:24]=shift[27:24]+4'd3;
        if (shift[23:20]>=4'd5) 
            shift[23:20]=shift[23:20]+4'd3;
        if (shift[19:16]>=4'd5) 
            shift[19:16]=shift[19:16]+4'd3;
        if (shift[15:12]>=4'd5) 
            shift[15:12]=shift[15:12]+4'd3;
        shift = shift << 1;
      end
      bcd=shift[27:12];
end
endmodule
