//???DDP?????????????????????????????????????
//DDP??DST??????DU????????
module DDP#(
        parameter DW = 15,
        parameter H_LEN = 200,
        parameter V_LEN = 150,
        parameter H_LEN_player = 30,
        parameter V_LEN_player = 30,
        parameter H_LEN_enemy = 30,
        parameter V_LEN_enemy = 30,
        parameter H_LEN_bullet = 15,
        parameter V_LEN_bullet = 15
    )(
    input               hen,
    input               ven,
    input               rstn,
    input               pclk,
    input   [11:0]       rdata_background,
    input   [11:0]       rdata_player,
    input   [11:0]       rdata_enemy,
    input   [11:0]       rdata_bullet,
    input   [8:0]        start_player_x,
    input   [8:0]        start_player_y,
    input   [8:0]        start_enemy_x,
    input   [8:0]        start_enemy_y,
    input   [8:0]        start_bullet_x,
    input   [8:0]        start_bullet_y,
    input                exist_bullet,
    
    output reg [11:0]   rgb,
    output reg [DW-1:0] raddr_background,
    output reg [DW-1:0] raddr_player,
    output reg [DW-1:0] raddr_enemy,
    output reg [DW-1:0] raddr_bullet
    );

    reg [1:0] sx;       //??????
    reg [1:0] sy;
    reg [1:0] nsx;
    reg [1:0] nsy;

    always @(*) begin
        sx = nsx;
        sy = nsy;
    end

    wire p;
    reg out_player, out_enemy, out_bullet;
    // bullet > enemy > player > background
    
    PS #(1) ps(                     //?ven?????
        .s      (~(hen&ven)),
        .clk    (pclk),
        .p      (p)
    );

    always @(posedge pclk) begin
        if ((raddr_background / H_LEN) >= start_player_x && (raddr_background / H_LEN) < start_player_x + V_LEN_player && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_player_y && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_player_y + H_LEN_player) begin
            out_player <= 1;
            raddr_player <= ((raddr_background / H_LEN) - start_player_x) * H_LEN_player + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_player_y);
        end else begin
            out_player <= 0;
            raddr_player <= 0;
        end
        if ((raddr_background / H_LEN) >= start_enemy_x && (raddr_background / H_LEN) < start_enemy_x + V_LEN_enemy && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_enemy_y && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_enemy_y + H_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / H_LEN) - start_enemy_x) * H_LEN_enemy + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_enemy_y);
        end else begin
            out_enemy <= 0;
            raddr_enemy <= 0;
        end 
        if (exist_bullet && (raddr_background / H_LEN) >= start_bullet_x && (raddr_background / H_LEN) < start_bullet_x + V_LEN_bullet && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_bullet_y && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_bullet_y + H_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / H_LEN) - start_bullet_x) * H_LEN_bullet + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_bullet_y);
        end else begin
            out_bullet <= 0;
            raddr_bullet <= 0;
        end
    end
    always @(posedge pclk) begin           //????????????????hen,ven????
        if(!rstn) begin
            nsx <= 0; nsy <= 3;
            rgb <= 0;
            raddr_background <= 0;
        end
        else if(hen && ven) begin
            if (out_bullet && rdata_bullet != 12'h0F0) rgb <= rdata_bullet;
            else if (out_enemy && rdata_enemy != 12'h0F0) rgb <= rdata_enemy;
            else if (out_player && rdata_player != 12'h0F0) rgb <= rdata_player;
            else rgb <= rdata_background;
            if(sx == 2'b11) begin
                raddr_background <= raddr_background + 1;
            end
            nsx <= sx + 1;
        end                                      //??��????
        else if(p) begin                        //ven?????
            rgb <= 0;      
            if(sy != 2'b11) begin
                raddr_background <= raddr_background - H_LEN;
            end
            else if(raddr_background == H_LEN * V_LEN) begin
                raddr_background <= 0;
            end
            nsy <= sy + 1;
        end
        else rgb <= 0;
    end
endmodule