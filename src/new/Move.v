module Move(
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            bt_W,
    input                   [ 0 : 0]            bt_S,
    input                   [ 0 : 0]            bt_J,

    output reg  [8:0]        start_player_x,
    output reg  [8:0]        start_player_y,
    output reg  [8:0]        start_enemy_x,
    output reg  [8:0]        start_enemy_y,
    output reg  [8:0]        start_bullet_x,
    output reg  [8:0]        start_bullet_y,
    output reg               exist_bullet
    );
    reg [32:0]  counter = 32'd0;
always @(posedge clk) begin
    if(!rstn) begin
        start_player_x <= 0;
        start_player_y <= 0;
        start_enemy_x <= 0;
        start_enemy_y <= 100;
        start_bullet_x <= 500;
        start_bullet_y <= 40;
        exist_bullet <= 0;
    end
    else begin
        if (bt_W) begin
            start_player_x <= (start_player_x + 120)%150;
        end
        if (bt_S) begin
            start_player_x <= (start_player_x + 30)%150;
        end 
        if (bt_J)begin
            exist_bullet <= 1;
            start_bullet_x <= start_player_x + 7;
            start_bullet_y <= 40;
        end
        else if (exist_bullet && counter >= 32'd10000000) begin
                start_bullet_y <= start_bullet_y + 1;
        end
    end
end

always @(posedge clk) begin
    if (counter >= 32'd10000000) begin
            counter <= 32'd0;
    end else begin
            counter <= counter + 32'd1;
    end
end
endmodule
