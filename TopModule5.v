//NOTICE
//this file includes all the submodules used specific to step 5
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



module clockDivider5(clock_in, clock_out);
input clock_in;
output reg clock_out = 0;

reg[1:0] counter = 2'd0;

always @(posedge clock_in)
    begin
    counter <= counter + 1;
    if(counter == 2'b01) //toggles every two clock cycles ie divided by 4
        begin
            clock_out <= ~clock_out;
            counter <=0;
        end
    
    end
endmodule



module UpCounter5(clk, done, bin_cnt);
input clk;
output done;
output [11:0] bin_cnt;

parameter c_reg_size = 34;

reg [c_reg_size - 1:0] count = 0;
reg fin = 0;
reg old_b = 0;

always @(posedge clk)
    begin
        count <= count + 1;
        if((old_b && !count[c_reg_size-12]) || (!old_b && count[c_reg_size-12]))
            begin
                fin <=1;
            end
        else
            begin
                fin <= 0;
            end
        old_b <= count[c_reg_size - 12];
            
    end
assign bin_cnt = count[(c_reg_size - 1):(c_reg_size - 12)];
assign done = fin; 
endmodule


module Bin12to16BCD(clk, en, bin_d_in, bcd_d_out, rdy);
input clk;
input en;
input [11:0] bin_d_in;
output [15:0] bcd_d_out;
output rdy;

//state variables
parameter IDLE = 3'b000;
parameter SETUP = 3'b001;
parameter ADD = 3'b010;
parameter SHIFT = 3'b011;
parameter DONE = 3'b100;

reg [27:0] bcd_data = 0;
reg[2:0] state = 0;
//reg busy = 0;
reg [3:0] sh_counter = 0;
reg [1:0] add_counter = 0;
reg result_rdy = 0;


always @(posedge clk)
    begin
    case(state)
    IDLE:
        begin
            result_rdy <= 0;
            //busy <= 0;
            if(en)
            begin
                state<= SETUP;
            end
        end
    SETUP:
        begin
            //busy <= 1;
            sh_counter <= 0;
            add_counter <= 0;
            bcd_data <= {16'b0, bin_d_in};
            state <= ADD;
        end
    ADD:
        begin
            case(add_counter)
                0:
                    begin
                    if(bcd_data[15:12] >4 )
                    bcd_data[27:12] <= bcd_data[27:12] +3;
                    add_counter <= add_counter +1;
                    end
                1:
                    begin
                    if(bcd_data[19:16] >4 )
                    bcd_data[27:16] <= bcd_data[27:16] +3;
                    add_counter <= add_counter +1;
                    end
                2:
                    begin
                    if(bcd_data[23:20] >4 )
                    bcd_data[27:20] <= bcd_data[27:20] +3;
                    add_counter <= add_counter +1;
                    end
                3:
                    begin
                    if(bcd_data[27:24] >4 )
                    bcd_data[27:24] <= bcd_data[27:24] +3;
                    add_counter <= 0;
                    state <= SHIFT;
                    end
            endcase
        end
    SHIFT:
        begin
            sh_counter <= sh_counter + 1;
            bcd_data <= bcd_data << 1;
            if(sh_counter == 11)
                begin
                    state<=DONE;
                end
            else
                begin
                    state<= ADD;
                end
        end
    DONE:
        begin
            result_rdy <= 1;
            state <= IDLE;
        end
    default:
        begin
            state<= IDLE;
        end
    endcase
    end
    
assign bcd_d_out = bcd_data[27:12];
assign rdy = result_rdy;
endmodule


module multisegDriver(
input clk,
input [15:0] bcd_in,
output [3:0] seg_anode,
output [6:0] seg_cathode);

wire [3:0] bcd_val;

anodeGenerator u1 (.clk(clk),.bcd_in(bcd_in), .seg_anode(seg_anode), .bcd_out(bcd_val));
BCDtoSevenSegmentDisplay u2 (.data_in(bcd_val),.seg(seg_cathode) ); 

endmodule


