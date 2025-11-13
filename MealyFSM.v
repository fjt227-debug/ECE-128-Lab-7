module MealyFSM(p1,clk, reset, z);
input p1,clk, reset;
output reg z;

parameter s0 = 0, s1 = 1, s2=2, s3=3;
reg[1:0] ps, ns;

always@(posedge clk or posedge reset)
    begin
    if(reset)
        ps <= s0;
    else
        ps<=ns;
    end
always@(ps or p1)
    begin
    case(ps)
        s0: begin
            if(p1)
                ns = s1;
            else
                ns = s0;
        end
        s1: begin
            if(p1)
                ns = s2;
            else
                ns = s0;
        end
        s2: begin
            if(!p1)
                ns = s3;
            else
                ns = s1;
        end
        s3: begin
            if(p1)
                ns = s1;
            else
                ns = s0;
        end
    endcase
    end
always@(ps or p1)
begin
    z=0;
    case(ps)
        s0:z=0;
        s1:z=0;
        s2:z=0;
        s3:begin
            if(p1)
            z=1;
          
        end
    endcase
end
endmodule
