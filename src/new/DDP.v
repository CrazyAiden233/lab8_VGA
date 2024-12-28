//???DDP?????????????????????????????????????
//DDP??DST??????DU????????
module DDP#(
        parameter DW = 15,
        parameter H_LEN = 200,
        parameter V_LEN = 150,
        parameter H_LEN_player = 30,
        parameter V_LEN_player = 30,
        parameter H_LEN_enemy = 27,
        parameter V_LEN_enemy = 30,
        parameter H_LEN_bullet = 15,
        parameter V_LEN_bullet = 15
    )(
    input               hen,
    input               ven,
    input               rstn,
    input               pclk,
    input               game,
    input   [11:0]       rdata_background,
    input   [11:0]       rdata_player,
    input   [11:0]       rdata_enemy,
    input   [11:0]       rdata_bullet,
    input   [11:0]       rdata_score,
    input   [11:0]       rdata_bg,
    input   [11:0]       rdata_words,
    input   [11:0]       rdata_died,
    input   [8:0]        start_player_x,
    input   [8:0]        start_player_y,
    
    input   [8:0]        start_enemy_x_one,
    input   [8:0]        start_enemy_y_one,
    input   [8:0]        start_enemy_x_two,
    input   [8:0]        start_enemy_y_two,
    input   [8:0]        start_enemy_x_three,
    input   [8:0]        start_enemy_y_three,
    input   [8:0]        start_enemy_x_four,
    input   [8:0]        start_enemy_y_four,
    input   [8:0]        start_enemy_x_five,
    input   [8:0]        start_enemy_y_five,
    
    input   [8:0]        start_bullet_x_one,
    input   [8:0]        start_bullet_y_one,
    input   [8:0]        start_bullet_x_two,
    input   [8:0]        start_bullet_y_two,
    input   [8:0]        start_bullet_x_three,
    input   [8:0]        start_bullet_y_three,
    input   [8:0]        start_bullet_x_four,
    input   [8:0]        start_bullet_y_four,
    input   [8:0]        start_bullet_x_five,
    input   [8:0]        start_bullet_y_five,
    input   [9:0]        score,
    input   [8:0]        start_words_x,
    
    input				 exist_player,
    
    input                exist_bullet_one,
    input                exist_bullet_two,
    input                exist_bullet_three,
    input                exist_bullet_four,
    input                exist_bullet_five,
    
    input                exist_enemy_one,
    input                exist_enemy_two,
    input                exist_enemy_three,
    input                exist_enemy_four,
    input                exist_enemy_five,
    
    output reg [11:0]   rgb,
    output reg [DW-1:0] raddr_background,
    output reg [DW-1:0] raddr_player,
    output reg [DW-1:0] raddr_enemy,
    output reg [DW-1:0] raddr_bullet,
    output reg [DW-1:0] raddr_score,
    output reg [DW-1:0] raddr_bg,
    output reg [DW-1:0] raddr_words,
    output reg [DW-1:0] raddr_died
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
    reg out_player, out_enemy, out_bullet, out_score, out_bg, out_words, out_died;
        // bullet > enemy > player > background
    
    PS #(1) ps(                     //?ven?????
        .s      (~(hen&ven)),
        .clk    (pclk),
        .p      (p)
    );

    always @(posedge pclk) begin
        if (exist_player && (raddr_background / H_LEN) >= start_player_x && (raddr_background / H_LEN) < start_player_x + V_LEN_player && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_player_y && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_player_y + H_LEN_player) begin
            out_player <= 1;
            raddr_player <= ((raddr_background / H_LEN) - start_player_x) * H_LEN_player + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_player_y);
        end else begin
            out_player <= 0;
            raddr_player <= 0;
        end
        
        if (exist_enemy_one && (raddr_background / H_LEN) >= start_enemy_x_one && (raddr_background / H_LEN) < start_enemy_x_one + V_LEN_enemy && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_enemy_y_one && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_enemy_y_one + H_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / H_LEN) - start_enemy_x_one) * H_LEN_enemy + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_enemy_y_one);
        end else if (exist_enemy_two && (raddr_background / H_LEN) >= start_enemy_x_two && (raddr_background / H_LEN) < start_enemy_x_two + V_LEN_enemy && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_enemy_y_two && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_enemy_y_two + H_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / H_LEN) - start_enemy_x_two) * H_LEN_enemy + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_enemy_y_two);
        end else if (exist_enemy_three && (raddr_background / H_LEN) >= start_enemy_x_three && (raddr_background / H_LEN) < start_enemy_x_three + V_LEN_enemy && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_enemy_y_three && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_enemy_y_three + H_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / H_LEN) - start_enemy_x_three) * H_LEN_enemy + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_enemy_y_three);
        end else if (exist_enemy_four && (raddr_background / H_LEN) >= start_enemy_x_four && (raddr_background / H_LEN) < start_enemy_x_four + V_LEN_enemy && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_enemy_y_four && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_enemy_y_four + H_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / H_LEN) - start_enemy_x_four) * H_LEN_enemy + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_enemy_y_four);
        end else if (exist_enemy_five && (raddr_background / H_LEN) >= start_enemy_x_five && (raddr_background / H_LEN) < start_enemy_x_five + V_LEN_enemy && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_enemy_y_five && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_enemy_y_five + H_LEN_enemy) begin
            out_enemy <= 1;
            raddr_enemy <= ((raddr_background / H_LEN) - start_enemy_x_five) * H_LEN_enemy + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_enemy_y_five);
        end else begin
            out_enemy <= 0;
            raddr_enemy <= 0;
        end 
        
        if (exist_bullet_one && (raddr_background / H_LEN) >= start_bullet_x_one && (raddr_background / H_LEN) < start_bullet_x_one + V_LEN_bullet && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_bullet_y_one && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_bullet_y_one + H_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / H_LEN) - start_bullet_x_one) * H_LEN_bullet + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_bullet_y_one);
        end else if (exist_bullet_two && (raddr_background / H_LEN) >= start_bullet_x_two && (raddr_background / H_LEN) < start_bullet_x_two + V_LEN_bullet && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_bullet_y_two && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_bullet_y_two + H_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / H_LEN) - start_bullet_x_two) * H_LEN_bullet + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_bullet_y_two);
        end else if (exist_bullet_three && (raddr_background / H_LEN) >= start_bullet_x_three && (raddr_background / H_LEN) < start_bullet_x_three + V_LEN_bullet && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_bullet_y_three && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_bullet_y_three + H_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / H_LEN) - start_bullet_x_three) * H_LEN_bullet + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_bullet_y_three);
        end else if (exist_bullet_four && (raddr_background / H_LEN) >= start_bullet_x_four && (raddr_background / H_LEN) < start_bullet_x_four + V_LEN_bullet && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_bullet_y_four && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_bullet_y_four + H_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / H_LEN) - start_bullet_x_four) * H_LEN_bullet + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_bullet_y_four);
        end else if (exist_bullet_five && (raddr_background / H_LEN) >= start_bullet_x_five && (raddr_background / H_LEN) < start_bullet_x_five + V_LEN_bullet && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= start_bullet_y_five && (raddr_background - (raddr_background / H_LEN) * H_LEN) < start_bullet_y_five + H_LEN_bullet) begin
            out_bullet <= 1;
            raddr_bullet <= ((raddr_background / H_LEN) - start_bullet_x_five) * H_LEN_bullet + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - start_bullet_y_five);
        end else begin
            out_bullet <= 0;
            raddr_bullet <= 0;
        end
        if ((raddr_background / H_LEN) >= 140 && (raddr_background / H_LEN) < 150 && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= 190 && (raddr_background - (raddr_background / H_LEN) * H_LEN) < 197) begin
            out_score <= 1;
            raddr_score <= ((raddr_background / H_LEN) - 140) * 7 + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - 190) + (score % 10)*70;    
        end else if ((raddr_background / H_LEN) >= 140 && (raddr_background / H_LEN) < 150 && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= 181 && (raddr_background - (raddr_background / H_LEN) * H_LEN) < 188) begin
            out_score <= 1;
            raddr_score <= ((raddr_background / H_LEN) - 140) * 7 + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - 181) + ((score / 10) % 10)*70;    
        end else if ((raddr_background / H_LEN) >= 140 && (raddr_background / H_LEN) < 150 && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= 172 && (raddr_background - (raddr_background / H_LEN) * H_LEN) < 179) begin
            out_score <= 1;
            raddr_score <= ((raddr_background / H_LEN) - 140) * 7 + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - 172) + (score / 100)*70;    
        end else begin
            out_score <= 0;
            raddr_score <= 0;
        end
        raddr_bg <= raddr_background;
        if ((raddr_background / H_LEN) >= start_words_x && (raddr_background / H_LEN) < start_words_x + 20 && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= 37 && (raddr_background - (raddr_background / H_LEN) * H_LEN) < 163) begin
            out_words <= 1;
            raddr_words <= ((raddr_background / H_LEN) - start_words_x) * 126 + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - 37);    
        end else begin
            out_words <= 0;
            raddr_words <= 0;
        end
        if ((raddr_background / H_LEN) >= 15 && (raddr_background / H_LEN) < 55 && (raddr_background - (raddr_background / H_LEN) * H_LEN) >= 40 && (raddr_background - (raddr_background / H_LEN) * H_LEN) < 159) begin
            out_died <= 1;
            raddr_died <= ((raddr_background / H_LEN) - 15) * 119 + ((raddr_background - (raddr_background / H_LEN) * H_LEN) - 40);    
        end else begin
            out_died <= 0;
            raddr_died <= 0;
        end
    end
    
    always @(posedge pclk) begin           //????????????????hen,ven????
        if(!rstn) begin
            nsx <= 0; nsy <= 3;
            rgb <= 0;
            raddr_background <= 0;
        end
        else if(hen && ven) begin
            if (!exist_player && out_died && rdata_died != 12'h0F0) rgb <= rdata_died;
            else if (!exist_player && out_words && rdata_words != 12'h0F0) rgb <= rdata_words;
            else if (!exist_player && out_score && rdata_score != 12'h0F0) rgb <= rdata_score;
            else if (!exist_player) rgb <= 12'h000;
            else if (!game && out_words && rdata_words != 12'h0F0) rgb <= rdata_words;
            else if (!game) rgb <= rdata_bg;
            else if (out_score && rdata_score != 12'h0F0) rgb <= rdata_score;
            else if (out_bullet && rdata_bullet != 12'h0F0) rgb <= rdata_bullet;
            else if (out_enemy && rdata_enemy != 12'h0F0) rgb <= rdata_enemy;
            else if (out_player && rdata_player != 12'h0F0) rgb <= rdata_player;
            else rgb <= rdata_background;
            if(sx == 2'b11) begin
                raddr_background <= raddr_background + 1;
            end
            nsx <= sx + 1;
        end                                      //????????
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
