
module TopModule5_TB();

    // Inputs
    reg mclk;

    // Outputs
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate the top module
    TopModule5 uut (
        .mclk(mclk),
        .seg(seg),
        .an(an)
    );

    
    initial begin
        mclk = 0;
        forever #10 mclk = ~mclk;
    end
    
    initial begin
        #2000000;
        $finish;
    end
  
endmodule
