
module UpCounter_TB();
reg clk, reset;
wire [11:0]count;

UpCounter uut(.clk(clk), .reset(reset), .count(count));
initial begin
clk = 0;
forever #10 clk = ~clk;
end

initial begin
        reset = 1;
        
        @(posedge clk);
        reset = 0;
        @(posedge clk); reset=1;
        @(posedge clk);
        reset = 0;

        
  
        
        #50;
        $finish;
     end    

endmodule
  
