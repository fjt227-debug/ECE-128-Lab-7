module MooreFSM_TB();
reg p1,clk, reset;
wire z;
MooreFSM uut (.p1(p1),.clk(clk), .reset(reset), .z(z));

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
    reset = 1; 
    p1 = 0;
    #10;
    reset = 0;
    #10 p1 = 1;   
    #10 p1 = 1;   
    #10 p1 = 0;   
    #10 p1 = 0;
    #10 reset = 1; 
    #10 reset = 0;  
    #10 p1 = 1;
    #10 p1 = 1;   
    #10 p1 = 0;   
    #10 p1 = 0; 
    
      

    #10;
    $finish;
    
end
endmodule

