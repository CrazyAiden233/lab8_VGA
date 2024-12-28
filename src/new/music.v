module music  (
input              clk  ,
input              rst_n,
input [3:0]	   music_data,

output reg     [9:0]      cnt2,
output             beep
);
reg     [16:0]     cnt0    ;
wire               add_cnt0;
wire               end_cnt0;
reg     [16:0]     pre_set ;
reg     [31:0]	   counter = 32'b0;

localparam  M1=95602,          
	        M2=85178,          
	        M3=75872,          
	        M4=71633,          
	        M5=63775,          
	        M6=56818,          
	        M7=50607;        
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0<=0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0<=0;
        else
            cnt0<=cnt0+1;  
    end
end
assign add_cnt0=1'b1;
assign end_cnt0=add_cnt0 && cnt0==pre_set-1;
assign beep=(cnt0>=(pre_set/2))?1:0;
always @(posedge clk)begin
    if(!rst_n)begin
        pre_set<=0; 
		cnt2 <= 0; 
    end
    else begin
       case(music_data)
                1:pre_set<=M1;
				2:pre_set<=M2;
				3:pre_set<=M3;
				4:pre_set<=M4;
				5:pre_set<=M5;
				6:pre_set<=M6;
				7:pre_set<=M7;
				default:pre_set<=0;
        endcase
		
	if (counter >= 32'd15000000) begin
            counter <= 32'd0;
			if (cnt2 <= 223)
            cnt2 <= cnt2 + 1;
			else
			cnt2 <= 0;
    end else begin
            counter <= counter + 32'd1;
    end
    end
end
endmodule
