//实现DDP功能，将画布与显示屏适配，从而产生色彩信息。
//DDP和DST共同称为DU即显示单元
module DDP#(
        parameter DW = 15,
        parameter H_LEN_background = 200,
        parameter V_LEN_background = 150,
        parameter H_LEN_player = ,
        parameter V_LEN_player = ,
        parameter H_LEN_enmey = ,
        parameter V_LEN_enem = ,
        parameter H_LEN_bullet = ,
        parameter V_LEN_bullet = 
    )(
    input               hen,
    input               ven,
    input               rstn,
    input               pclk,
    input  [11:0]       rdata_background,
    input  [11:0]       rdata_player,
    input  [11:0]       rdata_enemy,
    input  [11:0]       rdata_bullet,
    input  [8:0]        start_player_x,
    input  [8:0]        start_player_y,
    input  [8:0]        start_enemy_x,
    input  [8:0]        start_enemy_y,
    input  [8:0]        start_bullet_x,
    input  [8:0]        start_bullet_y,
    
    output reg [11:0]   rgb,
    output reg [DW-1:0] raddr_background
    output reg [DW-1:0] raddr_player
    output reg [DW-1:0] raddr_enemy
    output reg [DW-1:0] raddr_bullet
    );

    reg [1:0] sx;       //放大四倍
    reg [1:0] sy;
    reg [1:0] nsx;
    reg [1:0] nsy;

    always @(*) begin
        sx = nsx;
        sy = nsy;
    end

    wire p;
    wire out_player, out_enemy, out_bullet;
    // bullet > enemy > player > background
    
    PS #(1) ps(                     //取ven下降沿
        .s      (~(hen&ven)),
        .clk    (pclk),
        .p      (p)
    );

    always @(posedge pclk) begin
        if ((raddr_background / V_LEN_background) >= start_player_x && (raddr_background / V_LEN_background) <= start_player_x + H_LEN_player && (raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) >= start_player_y && (raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) <= start_player_y + V_LEN_player) begin
            out_player <= 1;
            raddr_player <= ((raddr_background / V_LEN_background) - start_player_x) * V_LEN_player + ((raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) - start_player_y);
        end else begin
            out_player <= 0;
            raddr_player <= 0;
        end
        if ((raddr_background / V_LEN_background) >= start_enemy_x && (raddr_background / V_LEN_background) <= start_enemy_x + H_LEN_enemy && (raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) >= start_enemy_y && (raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) <= start_enemy_y + V_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / V_LEN_background) - start_enemy_x) * V_LEN_enemy + ((raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) - start_enemy_y);
        end else begin
            out_enemy <= 0;
            raddr_enemy <= 0;
        end 
        if ((raddr_background / V_LEN_background) >= start_bullet_x && (raddr_background / V_LEN_background) <= start_bullet_x + H_LEN_bullet && (raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) >= start_bullet_y && (raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) <= start_bullet_y + V_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / V_LEN_background) - start_bullet_x) * V_LEN_bullet + ((raddr_background - (raddr_background / V_LEN_background) * V_LEN_background) - start_bullet_y);
        end else begin
            out_bullet <= 0;
            raddr_bullet <= 0;
        end
    end
    
    always @(posedge pclk) begin           //可能慢一个周期，改hen,ven即可
        if(!rstn) begin
            nsx <= 0; nsy <= 3;
            rgb <= 0;
            raddr <= 0;
        end
        else if(hen && ven) begin
            if (out_bullet) rgb <= rdata_bullet;
            else if (out_enemy) rgb <= rdata_enemy;
            else if (out_player) rgb <= rdata_player;
            else rgb <= rdata_background;
            if(sx == 2'b11) begin
                raddr <= raddr + 1;
            end
            nsx <= sx + 1;
        end                                      //无效区域
        else if(p) begin                        //ven下降沿
            rgb <= 0;
            if(sy != 2'b11) begin
                raddr <= raddr - H_LEN;
            end
            else if(raddr == H_LEN * V_LEN) begin
                raddr <= 0;
            end
            nsy <= sy + 1;
        end
        else rgb <= 0;
    end
endmodule