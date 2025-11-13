

module UpCounter(clk,reset,count);
input clk, reset;
output reg [11:0] count;

reg [11:0] next_count = 12'd1;
always@(posedge clk)begin
    if(reset)begin
        count<=12'd0;
    end
    else begin
      count<=next_count;  
    end
end

always@(*)begin
    if(count == 12'd4095)
        next_count=12'd0;
    else
        next_count = count + 1;
end
endmodule

