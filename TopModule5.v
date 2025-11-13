
module TopModule5(mclk, seg, an);
input mclk;
output wire [6:0] seg;
output wire [3:0] an;

reg [15:0] stat_bcd = 16'd0;

wire en;
wire [11:0] bin_d_in;
wire [15:0] bcd_d_out;
wire rdy;
wire clock_out;


clockDivider5 uut1(.clock_in(mclk), .clock_out(clock_out));
UpCounter5 uut2(.clk(clock_out),.done(en), .bin_cnt(bin_d_in));
Bin12to16BCD uut3(.clk(clock_out), .en(en), .bin_d_in(bin_d_in), .bcd_d_out(bcd_d_out), .rdy(rdy)) ;
multisegDriver uut4(.clk(clock_out), .bcd_in(stat_bcd), .seg_anode(an),.seg_cathode(seg));


always @(posedge mclk)
    begin
        if(rdy)
            begin 
                stat_bcd <= bcd_d_out;
            end
    end
    


endmodule
