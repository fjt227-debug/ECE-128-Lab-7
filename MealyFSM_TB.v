
module MealyFSM_TB();
reg p1,clk, reset;
wire z;

MealyFSM uut(.p1(p1), .clk(clk), .reset(reset), .z(z));

initial begin
clk = 0;
forever #10 clk = ~clk;
end

initial begin
    
    reset = 1; p1 = 0;
    #10 reset = 0;
    #10 p1 = 1;   
    #10 p1 = 1;  
    #10 p1 = 0;   
    #10 p1 = 1;   
    #10 p1 = 0;   
    #20 p1 = 1;   

    #50 $finish;
end
endmodule
