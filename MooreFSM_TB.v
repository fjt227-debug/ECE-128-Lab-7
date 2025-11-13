
module MooreFSM_TB();
reg p1,clk, reset;
wire z;
MooreFSM uut (.p1(p1),.clk(clk), .reset(reset), .z(z));

initial begin
clk = 0;
forever #10 clk = ~clk;
end

initial begin
    reset = 1; 
    p1 = 0;
    #25;
     reset = 0;
    #20 p1 = 1;   
    #20 p1 = 1;   
    #20 p1 = 0;   
    #20 p1 = 1;   
    #20 p1 = 0;   
    #20 p1 = 1;   
    #20 p1 = 0;   

     
    $finish;
    
end
endmodule
