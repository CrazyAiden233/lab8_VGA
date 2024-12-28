module Move(
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            bt_W,
    input                   [ 0 : 0]            bt_S,
    input                   [ 0 : 0]            bt_J,
    input                   [ 0 : 0]            bt_SPACE,
    
    output                [ 0:  0]            exist_bullet_one_,
    output                [ 0:  0]            exist_bullet_two_,
    output                [ 0:  0]            exist_bullet_three_,
    output                [ 0:  0]            exist_bullet_four_,
    output                [ 0:  0]            exist_bullet_five_,
    
    output                [ 0:  0]            exist_enemy_one_,
    output                [ 0:  0]            exist_enemy_two_,
    output                [ 0:  0]            exist_enemy_three_,
    output                [ 0:  0]            exist_enemy_four_,
    output                [ 0:  0]            exist_enemy_five_,
    
    output                [ 0:  0]            exist_player_,
    
    output reg [9:0] 		score,
    
    output   [8:0]        start_player_x_,
    output   [8:0]        start_player_y_,
    
    output   [8:0]        start_enemy_x_one_,
    output   [8:0]        start_enemy_y_one_,
    output   [8:0]        start_enemy_x_two_,
    output   [8:0]        start_enemy_y_two_,
    output   [8:0]        start_enemy_x_three_,
    output   [8:0]        start_enemy_y_three_,
    output   [8:0]        start_enemy_x_four_,
    output   [8:0]        start_enemy_y_four_,
    output   [8:0]        start_enemy_x_five_,
    output   [8:0]        start_enemy_y_five_,
    
    output   [8:0]        start_bullet_x_one_,
    output   [8:0]        start_bullet_y_one_,
    output   [8:0]        start_bullet_x_two_,
    output   [8:0]        start_bullet_y_two_,
    output   [8:0]        start_bullet_x_three_,
    output   [8:0]        start_bullet_y_three_,
    output   [8:0]        start_bullet_x_four_,
    output   [8:0]        start_bullet_y_four_,
    output   [8:0]        start_bullet_x_five_,
    output   [8:0]        start_bullet_y_five_,
    output   [8:0]        start_words_x_,

    output   reg          game
    
    );

        reg  [8:0]               start_player_x;
        reg  [8:0]               start_player_y;
        reg  [8:0]               start_enemy_x_one;
        reg  [8:0]               start_enemy_y_one;
        reg  [8:0]               start_enemy_x_two;
        reg  [8:0]               start_enemy_y_two;
        reg  [8:0]               start_enemy_x_three;
        reg  [8:0]               start_enemy_y_three;
        reg  [8:0]               start_enemy_x_four;
        reg  [8:0]               start_enemy_y_four;
        reg  [8:0]               start_enemy_x_five;
        reg  [8:0]               start_enemy_y_five;
        reg  [8:0]               start_bullet_x_one;
        reg  [8:0]               start_bullet_y_one;
        reg  [8:0]               start_bullet_x_two;
        reg  [8:0]               start_bullet_y_two;
        reg  [8:0]               start_bullet_x_three;
        reg  [8:0]               start_bullet_y_three;
        reg  [8:0]               start_bullet_x_four;
        reg  [8:0]               start_bullet_y_four;
        reg  [8:0]               start_bullet_x_five;
        reg  [8:0]               start_bullet_y_five;
        reg  [ 0:  0]            exist_bullet_one;
        reg  [ 0:  0]            exist_bullet_two;
        reg  [ 0:  0]            exist_bullet_three;
        reg  [ 0:  0]            exist_bullet_four;
        reg  [ 0:  0]            exist_bullet_five;
        reg  [ 0:  0]            exist_enemy_one;
        reg  [ 0:  0]            exist_enemy_two;
        reg  [ 0:  0]            exist_enemy_three;
        reg  [ 0:  0]            exist_enemy_four;
        reg  [ 0:  0]            exist_enemy_five;
        reg  [ 0:  0]            exist_player;
        reg  [ 8:  0]            start_words_x;

    reg [31:0]  counter = 32'd0;
    reg [4:0]   duration = 0;
    reg [1:0]   state = 2'b0;
    reg         position = 0;
    reg [9:0]   seed = 0;
    
always @(posedge clk) begin
    if(!rstn) begin
        state <= 2;
        game <= 0;
        position <= 1;

        start_player_x <= 0;
        start_player_y <= 0;

        start_words_x <= 65;
        
        start_enemy_x_one <= 0;
        start_enemy_y_one <= 200;
        start_enemy_x_two <= 0;
        start_enemy_y_two <= 200;
        start_enemy_x_three <= 0;
        start_enemy_y_three <= 200;
        start_enemy_x_four <= 0;
        start_enemy_y_four <= 200;
        start_enemy_x_five <= 0;
        start_enemy_y_five <= 200;
        
        start_bullet_x_one <= 500;
        start_bullet_y_one <= 40;
        start_bullet_x_two <= 500;
        start_bullet_y_two <= 40;
        start_bullet_x_three <= 500;
        start_bullet_y_three <= 40;
        start_bullet_x_four <= 500;
        start_bullet_y_four <= 40;
        start_bullet_x_five <= 500;
        start_bullet_y_five <= 40;
        
        exist_bullet_one <= 0;
        exist_bullet_two <= 0;
        exist_bullet_three <= 0;
        exist_bullet_four <= 0;
        exist_bullet_five <= 0;
        exist_enemy_one <= 0;
        exist_enemy_two <= 0;
        exist_enemy_three <= 0;
        exist_enemy_four <= 0;
        exist_enemy_five <= 0;
        exist_player <= 1;

        score <= 0;
    end
    else begin
        if (bt_SPACE && (!game || !exist_player)) begin
                state <= 2;
                game <= 1;
                exist_player <= 1;
                start_player_x <= 0;
                start_player_y <= 0;

                start_words_x <= 65;
                
                start_enemy_x_one <= 0;
                start_enemy_y_one <= 200;
                start_enemy_x_two <= 0;
                start_enemy_y_two <= 200;
                start_enemy_x_three <= 0;
                start_enemy_y_three <= 200;
                start_enemy_x_four <= 0;
                start_enemy_y_four <= 200;
                start_enemy_x_five <= 0;
                start_enemy_y_five <= 200;
                
                start_bullet_x_one <= 500;
                start_bullet_y_one <= 40;
                start_bullet_x_two <= 500;
                start_bullet_y_two <= 40;
                start_bullet_x_three <= 500;
                start_bullet_y_three <= 40;
                start_bullet_x_four <= 500;
                start_bullet_y_four <= 40;
                start_bullet_x_five <= 500;
                start_bullet_y_five <= 40;
                
                exist_bullet_one <= 0;
                exist_bullet_two <= 0;
                exist_bullet_three <= 0;
                exist_bullet_four <= 0;
                exist_bullet_five <= 0;
                exist_enemy_one <= 0;
                exist_enemy_two <= 0;
                exist_enemy_three <= 0;
                exist_enemy_four <= 0;
                exist_enemy_five <= 0;

                score <= 0;
        end
        if (start_words_x == 95) begin
                position <= position + 1;
                start_words_x <= start_words_x - 1;
        end
        else if (start_words_x == 65) begin
                position <= position + 1;
                start_words_x <= start_words_x + 1;
        end
        if ((!game || !exist_player) && counter >= 32'd3000000) begin
                if (!position) begin
                        start_words_x <= start_words_x + 1;
                end else begin
                        start_words_x <= start_words_x - 1;
                end
        end
        if (game && exist_player) begin
        if (bt_W) begin
            start_player_x <= (start_player_x + 120)%150;
        end
        else if (bt_S) begin
            start_player_x <= (start_player_x + 30)%150;
        end
        if (bt_J && !exist_bullet_one) begin
                exist_bullet_one <= 1;
                start_bullet_x_one <= start_player_x + 7;
                start_bullet_y_one <= 40;
        end else if (bt_J && !exist_bullet_two) begin
                exist_bullet_two <= 1;
                start_bullet_x_two <= start_player_x + 7;
                start_bullet_y_two <= 40;
        end else if (bt_J && !exist_bullet_three) begin
                exist_bullet_three <= 1;
                start_bullet_x_three <= start_player_x + 7;
                start_bullet_y_three <= 40;
        end else if (bt_J && !exist_bullet_four) begin
                exist_bullet_four <= 1;
                start_bullet_x_four <= start_player_x + 7;
                start_bullet_y_four <= 40;
        end else if (bt_J && !exist_bullet_five) begin
                exist_bullet_five <= 1;
                start_bullet_x_five <= start_player_x + 7;
                start_bullet_y_five <= 40;
        end else;
        if (exist_bullet_one && counter >= 32'd3000000) begin
                start_bullet_y_one <= start_bullet_y_one + 1;
        end
        if (exist_bullet_two && counter >= 32'd3000000) begin
                start_bullet_y_two <= start_bullet_y_two + 1;
        end
        if (exist_bullet_three && counter >= 32'd3000000) begin
                start_bullet_y_three <= start_bullet_y_three + 1;
        end
        if (exist_bullet_four && counter >= 32'd3000000) begin
                start_bullet_y_four <= start_bullet_y_four + 1;
        end
        if (exist_bullet_five && counter >= 32'd3000000) begin
                start_bullet_y_five <= start_bullet_y_five + 1;
        end
        
        if (exist_enemy_one && counter >= 32'd3000000) begin
                start_enemy_y_one <= start_enemy_y_one - 1;
        end
        if (exist_enemy_two && counter >= 32'd3000000) begin
                start_enemy_y_two <= start_enemy_y_two - 1;
        end
        if (exist_enemy_three && counter >= 32'd3000000) begin
                start_enemy_y_three <= start_enemy_y_three - 1;
        end
        if (exist_enemy_four && counter >= 32'd3000000) begin
                start_enemy_y_four <= start_enemy_y_four - 1;
        end
        if (exist_enemy_five && counter >= 32'd3000000) begin
                start_enemy_y_five <= start_enemy_y_five - 1;
        end
        if (counter >= 32'd3000000) begin
            state <= 0;
        end
        if (state == 0)begin
                //whether player collide with enemy

if (exist_player && exist_enemy_one && ((start_player_x < start_enemy_x_one + 27 && start_player_x >= start_enemy_x_one) || (start_enemy_x_one < start_player_x + 26 && start_enemy_x_one >= start_player_x)) && ((start_player_y < start_enemy_y_one + 30 && start_player_y >= start_enemy_y_one) || (start_enemy_y_one < start_player_y + 30 && start_enemy_y_one >= start_player_y))) begin
	exist_player <= 0;
	exist_enemy_one <= 0;
end
else if (exist_player && exist_enemy_two && ((start_player_x < start_enemy_x_two + 27 && start_player_x >= start_enemy_x_two) || (start_enemy_x_two < start_player_x + 26 && start_enemy_x_two >= start_player_x)) && ((start_player_y < start_enemy_y_two + 30 && start_player_y >= start_enemy_y_two) || (start_enemy_y_two < start_player_y + 30 && start_enemy_y_two >= start_player_y))) begin
	exist_player <= 0;
	exist_enemy_two <= 0;
end
else if (exist_player && exist_enemy_three && ((start_player_x < start_enemy_x_three + 27 && start_player_x >= start_enemy_x_three) || (start_enemy_x_three < start_player_x + 26 && start_enemy_x_three >= start_player_x)) && ((start_player_y < start_enemy_y_three + 30 && start_player_y >= start_enemy_y_three) || (start_enemy_y_three < start_player_y + 30 && start_enemy_y_three >= start_player_y))) begin
	exist_player <= 0;
	exist_enemy_three <= 0;
end
else if (exist_player && exist_enemy_four && ((start_player_x < start_enemy_x_four + 27 && start_player_x >= start_enemy_x_four) || (start_enemy_x_four < start_player_x + 26 && start_enemy_x_four >= start_player_x)) && ((start_player_y < start_enemy_y_four + 30 && start_player_y >= start_enemy_y_four) || (start_enemy_y_four < start_player_y + 30 && start_enemy_y_four >= start_player_y))) begin
	exist_player <= 0;
	exist_enemy_four <= 0;
end
else if (exist_player && exist_enemy_five && ((start_player_x < start_enemy_x_five + 27 && start_player_x >= start_enemy_x_five) || (start_enemy_x_five < start_player_x + 26 && start_enemy_x_five >= start_player_x)) && ((start_player_y < start_enemy_y_five + 30 && start_player_y >= start_enemy_y_five) || (start_enemy_y_five < start_player_y + 30 && start_enemy_y_five >= start_player_y))) begin
	exist_player <= 0;
	exist_enemy_five <= 0;
end

// whether bullet collide with enemy

//bullet_one
if (exist_bullet_one && exist_enemy_five && ((start_bullet_x_one < start_enemy_x_five + 27 && start_bullet_x_one >= start_enemy_x_five) || (start_enemy_x_five < start_bullet_x_one + 15 && start_enemy_x_five >= start_bullet_x_one)) && ((start_bullet_y_one < start_enemy_y_five + 27 && start_bullet_y_one >= start_enemy_y_five) || (start_enemy_y_five < start_bullet_y_one + 15 && start_enemy_y_five >= start_bullet_y_one))) begin
	exist_bullet_one <= 0;
	exist_enemy_five <= 0;
	score <= score + 1;
end
else if (exist_bullet_one && exist_enemy_two && ((start_bullet_x_one < start_enemy_x_two + 27 && start_bullet_x_one >= start_enemy_x_two) || (start_enemy_x_two < start_bullet_x_one + 15 && start_enemy_x_two >= start_bullet_x_one)) && ((start_bullet_y_one < start_enemy_y_two + 27 && start_bullet_y_one >= start_enemy_y_two) || (start_enemy_y_two < start_bullet_y_one + 15 && start_enemy_y_two >= start_bullet_y_one))) begin
	exist_bullet_one <= 0;
	exist_enemy_two <= 0;
	score <= score + 1;
end
else if (exist_bullet_one && exist_enemy_three && ((start_bullet_x_one < start_enemy_x_three + 27 && start_bullet_x_one >= start_enemy_x_three) || (start_enemy_x_three < start_bullet_x_one + 15 && start_enemy_x_three >= start_bullet_x_one)) && ((start_bullet_y_one < start_enemy_y_three + 27 && start_bullet_y_one >= start_enemy_y_three) || (start_enemy_y_three < start_bullet_y_one + 15 && start_enemy_y_three >= start_bullet_y_one))) begin
	exist_bullet_one <= 0;
	exist_enemy_three <= 0;
	score <= score + 1;
end
else if (exist_bullet_one && exist_enemy_four && ((start_bullet_x_one < start_enemy_x_four + 27 && start_bullet_x_one >= start_enemy_x_four) || (start_enemy_x_four < start_bullet_x_one + 15 && start_enemy_x_four >= start_bullet_x_one)) && ((start_bullet_y_one < start_enemy_y_four + 27 && start_bullet_y_one >= start_enemy_y_four) || (start_enemy_y_four < start_bullet_y_one + 15 && start_enemy_y_four >= start_bullet_y_one))) begin
	exist_bullet_one <= 0;
	exist_enemy_four <= 0;
	score <= score + 1;
end
else if (exist_bullet_one && exist_enemy_one && ((start_bullet_x_one < start_enemy_x_one + 27 && start_bullet_x_one >= start_enemy_x_one) || (start_enemy_x_one < start_bullet_x_one + 15 && start_enemy_x_one >= start_bullet_x_one)) && ((start_bullet_y_one < start_enemy_y_one + 27 && start_bullet_y_one >= start_enemy_y_one) || (start_enemy_y_one < start_bullet_y_one + 15 && start_enemy_y_one >= start_bullet_y_one))) begin
	exist_bullet_one <= 0;
	exist_enemy_one <= 0;
	score <= score + 1;
end

//bullet_two

if (exist_bullet_two && exist_enemy_five && ((start_bullet_x_two < start_enemy_x_five + 30 && start_bullet_x_two >= start_enemy_x_five) || (start_enemy_x_five < start_bullet_x_two + 15 && start_enemy_x_five >= start_bullet_x_two)) && ((start_bullet_y_two < start_enemy_y_five + 30 && start_bullet_y_two >= start_enemy_y_five) || (start_enemy_y_five < start_bullet_y_two + 15 && start_enemy_y_five >= start_bullet_y_two))) begin
	exist_bullet_two <= 0;
	exist_enemy_five <= 0;
	score <= score + 1;
end
else if (exist_bullet_two && exist_enemy_one && ((start_bullet_x_two < start_enemy_x_one + 30 && start_bullet_x_two >= start_enemy_x_one) || (start_enemy_x_one < start_bullet_x_two + 15 && start_enemy_x_one >= start_bullet_x_two)) && ((start_bullet_y_two < start_enemy_y_one + 30 && start_bullet_y_two >= start_enemy_y_one) || (start_enemy_y_one < start_bullet_y_two + 15 && start_enemy_y_one >= start_bullet_y_two))) begin
	exist_bullet_two <= 0;
	exist_enemy_one <= 0;
	score <= score + 1;
end
else if (exist_bullet_two && exist_enemy_three && ((start_bullet_x_two < start_enemy_x_three + 30 && start_bullet_x_two >= start_enemy_x_three) || (start_enemy_x_three < start_bullet_x_two + 15 && start_enemy_x_three >= start_bullet_x_two)) && ((start_bullet_y_two < start_enemy_y_three + 30 && start_bullet_y_two >= start_enemy_y_three) || (start_enemy_y_three < start_bullet_y_two + 15 && start_enemy_y_three >= start_bullet_y_two))) begin
	exist_bullet_two <= 0;
	exist_enemy_three <= 0;
	score <= score + 1;
end
else if (exist_bullet_two && exist_enemy_four && ((start_bullet_x_two < start_enemy_x_four + 30 && start_bullet_x_two >= start_enemy_x_four) || (start_enemy_x_four < start_bullet_x_two + 15 && start_enemy_x_four >= start_bullet_x_two)) && ((start_bullet_y_two < start_enemy_y_four + 30 && start_bullet_y_two >= start_enemy_y_four) || (start_enemy_y_four < start_bullet_y_two + 15 && start_enemy_y_four >= start_bullet_y_two))) begin
	exist_bullet_two <= 0;
	exist_enemy_four <= 0;
	score <= score + 1;
end
else if (exist_bullet_two && exist_enemy_two && ((start_bullet_x_two < start_enemy_x_two + 30 && start_bullet_x_two >= start_enemy_x_two) || (start_enemy_x_two < start_bullet_x_two + 15 && start_enemy_x_two >= start_bullet_x_two)) && ((start_bullet_y_two < start_enemy_y_two + 30 && start_bullet_y_two >= start_enemy_y_two) || (start_enemy_y_two < start_bullet_y_two + 15 && start_enemy_y_two >= start_bullet_y_two))) begin
	exist_bullet_two <= 0;
	exist_enemy_two <= 0;
	score <= score + 1;
end

//bullet_three

if (exist_bullet_three && exist_enemy_five && ((start_bullet_x_three < start_enemy_x_five + 30 && start_bullet_x_three >= start_enemy_x_five) || (start_enemy_x_five < start_bullet_x_three + 15 && start_enemy_x_five >= start_bullet_x_three)) && ((start_bullet_y_three < start_enemy_y_five + 30 && start_bullet_y_three >= start_enemy_y_five) || (start_enemy_y_five < start_bullet_y_three + 15 && start_enemy_y_five >= start_bullet_y_three))) begin
	exist_bullet_three <= 0;
	exist_enemy_five <= 0;
	score <= score + 1;
end
else if (exist_bullet_three && exist_enemy_one && ((start_bullet_x_three < start_enemy_x_one + 30 && start_bullet_x_three >= start_enemy_x_one) || (start_enemy_x_one < start_bullet_x_three + 15 && start_enemy_x_one >= start_bullet_x_three)) && ((start_bullet_y_three < start_enemy_y_one + 30 && start_bullet_y_three >= start_enemy_y_one) || (start_enemy_y_one < start_bullet_y_three + 15 && start_enemy_y_one >= start_bullet_y_three))) begin
	exist_bullet_three <= 0;
	exist_enemy_one <= 0;
	score <= score + 1;
end
else if (exist_bullet_three && exist_enemy_two && ((start_bullet_x_three < start_enemy_x_two + 30 && start_bullet_x_three >= start_enemy_x_two) || (start_enemy_x_two < start_bullet_x_three + 15 && start_enemy_x_two >= start_bullet_x_three)) && ((start_bullet_y_three < start_enemy_y_two + 30 && start_bullet_y_three >= start_enemy_y_two) || (start_enemy_y_two < start_bullet_y_three + 15 && start_enemy_y_two >= start_bullet_y_three))) begin
	exist_bullet_three <= 0;
	exist_enemy_two <= 0;
	score <= score + 1;
end
else if (exist_bullet_three && exist_enemy_four && ((start_bullet_x_three < start_enemy_x_four + 30 && start_bullet_x_three >= start_enemy_x_four) || (start_enemy_x_four < start_bullet_x_three + 15 && start_enemy_x_four >= start_bullet_x_three)) && ((start_bullet_y_three < start_enemy_y_four + 30 && start_bullet_y_three >= start_enemy_y_four) || (start_enemy_y_four < start_bullet_y_three + 15 && start_enemy_y_four >= start_bullet_y_three))) begin
	exist_bullet_three <= 0;
	exist_enemy_four <= 0;
	score <= score + 1;
end
else if (exist_bullet_three && exist_enemy_three && ((start_bullet_x_three < start_enemy_x_three + 30 && start_bullet_x_three >= start_enemy_x_three) || (start_enemy_x_three < start_bullet_x_three + 15 && start_enemy_x_three >= start_bullet_x_three)) && ((start_bullet_y_three < start_enemy_y_three + 30 && start_bullet_y_three >= start_enemy_y_three) || (start_enemy_y_three < start_bullet_y_three + 15 && start_enemy_y_three >= start_bullet_y_three))) begin
	exist_bullet_three <= 0;
	exist_enemy_three <= 0;
	score <= score + 1;
end

//bullet_four
if (exist_bullet_four && exist_enemy_five && ((start_bullet_x_four < start_enemy_x_five + 30 && start_bullet_x_four >= start_enemy_x_five) || (start_enemy_x_five < start_bullet_x_four + 15 && start_enemy_x_five >= start_bullet_x_four)) && ((start_bullet_y_four < start_enemy_y_five + 30 && start_bullet_y_four >= start_enemy_y_five) || (start_enemy_y_five < start_bullet_y_four + 15 && start_enemy_y_five >= start_bullet_y_four))) begin
	exist_bullet_four <= 0;
	exist_enemy_five <= 0;
	score <= score + 1;
end
else if (exist_bullet_four && exist_enemy_one && ((start_bullet_x_four < start_enemy_x_one + 30 && start_bullet_x_four >= start_enemy_x_one) || (start_enemy_x_one < start_bullet_x_four + 15 && start_enemy_x_one >= start_bullet_x_four)) && ((start_bullet_y_four < start_enemy_y_one + 30 && start_bullet_y_four >= start_enemy_y_one) || (start_enemy_y_one < start_bullet_y_four + 15 && start_enemy_y_one >= start_bullet_y_four))) begin
	exist_bullet_four <= 0;
	exist_enemy_one <= 0;
	score <= score + 1;
end
else if (exist_bullet_four && exist_enemy_two && ((start_bullet_x_four < start_enemy_x_two + 30 && start_bullet_x_four >= start_enemy_x_two) || (start_enemy_x_two < start_bullet_x_four + 15 && start_enemy_x_two >= start_bullet_x_four)) && ((start_bullet_y_four < start_enemy_y_two + 30 && start_bullet_y_four >= start_enemy_y_two) || (start_enemy_y_two < start_bullet_y_four + 15 && start_enemy_y_two >= start_bullet_y_four))) begin
	exist_bullet_four <= 0;
	exist_enemy_two <= 0;
	score <= score + 1;
end
else if (exist_bullet_four && exist_enemy_three && ((start_bullet_x_four < start_enemy_x_three + 30 && start_bullet_x_four >= start_enemy_x_three) || (start_enemy_x_three < start_bullet_x_four + 15 && start_enemy_x_three >= start_bullet_x_four)) && ((start_bullet_y_four < start_enemy_y_three + 30 && start_bullet_y_four >= start_enemy_y_three) || (start_enemy_y_three < start_bullet_y_four + 15 && start_enemy_y_three >= start_bullet_y_four))) begin
	exist_bullet_four <= 0;
	exist_enemy_three <= 0;
	score <= score + 1;
end
else if (exist_bullet_four && exist_enemy_four && ((start_bullet_x_four < start_enemy_x_four + 30 && start_bullet_x_four >= start_enemy_x_four) || (start_enemy_x_four < start_bullet_x_four + 15 && start_enemy_x_four >= start_bullet_x_four)) && ((start_bullet_y_four < start_enemy_y_four + 30 && start_bullet_y_four >= start_enemy_y_four) || (start_enemy_y_four < start_bullet_y_four + 15 && start_enemy_y_four >= start_bullet_y_four))) begin
	exist_bullet_four <= 0;
	exist_enemy_four <= 0;
	score <= score + 1;
end

//bullet_five
if (exist_bullet_five && exist_enemy_one && ((start_bullet_x_five < start_enemy_x_one + 30 && start_bullet_x_five >= start_enemy_x_one) || (start_enemy_x_one < start_bullet_x_five + 15 && start_enemy_x_one >= start_bullet_x_five)) && ((start_bullet_y_five < start_enemy_y_one + 30 && start_bullet_y_five >= start_enemy_y_one) || (start_enemy_y_one < start_bullet_y_five + 15 && start_enemy_y_one >= start_bullet_y_five))) begin
	exist_bullet_five <= 0;
	exist_enemy_one <= 0;
	score <= score + 1;
end
else if (exist_bullet_five && exist_enemy_two && ((start_bullet_x_five < start_enemy_x_two + 30 && start_bullet_x_five >= start_enemy_x_two) || (start_enemy_x_two < start_bullet_x_five + 15 && start_enemy_x_two >= start_bullet_x_five)) && ((start_bullet_y_five < start_enemy_y_two + 30 && start_bullet_y_five >= start_enemy_y_two) || (start_enemy_y_two < start_bullet_y_five + 15 && start_enemy_y_two >= start_bullet_y_five))) begin
	exist_bullet_five <= 0;
	exist_enemy_two <= 0;
	score <= score + 1;
end
else if (exist_bullet_five && exist_enemy_three && ((start_bullet_x_five < start_enemy_x_three + 30 && start_bullet_x_five >= start_enemy_x_three) || (start_enemy_x_three < start_bullet_x_five + 15 && start_enemy_x_three >= start_bullet_x_five)) && ((start_bullet_y_five < start_enemy_y_three + 30 && start_bullet_y_five >= start_enemy_y_three) || (start_enemy_y_three < start_bullet_y_five + 15 && start_enemy_y_three >= start_bullet_y_five))) begin
	exist_bullet_five <= 0;
	exist_enemy_three <= 0;
	score <= score + 1;
end
else if (exist_bullet_five && exist_enemy_four && ((start_bullet_x_five < start_enemy_x_four + 30 && start_bullet_x_five >= start_enemy_x_four) || (start_enemy_x_four < start_bullet_x_five + 15 && start_enemy_x_four >= start_bullet_x_five)) && ((start_bullet_y_five < start_enemy_y_four + 30 && start_bullet_y_five >= start_enemy_y_four) || (start_enemy_y_four < start_bullet_y_five + 15 && start_enemy_y_four >= start_bullet_y_five))) begin
	exist_bullet_five <= 0;
	exist_enemy_four <= 0;
	score <= score + 1;
end
else if (exist_bullet_five && exist_enemy_five && ((start_bullet_x_five < start_enemy_x_five + 30 && start_bullet_x_five >= start_enemy_x_five) || (start_enemy_x_five < start_bullet_x_five + 15 && start_enemy_x_five >= start_bullet_x_five)) && ((start_bullet_y_five < start_enemy_y_five + 30 && start_bullet_y_five >= start_enemy_y_five) || (start_enemy_y_five < start_bullet_y_five + 15 && start_enemy_y_five >= start_bullet_y_five))) begin
	exist_bullet_five <= 0;
	exist_enemy_five <= 0;
	score <= score + 1;
end

// whether bullet is out of space
if (exist_bullet_one && (start_bullet_x_one < 0 || start_bullet_x_one > 150 || start_bullet_y_one < 0 || start_bullet_y_one > 200)) begin
	exist_bullet_one <= 0;
end 
if (exist_bullet_two && (start_bullet_x_two < 0 || start_bullet_x_two > 150 || start_bullet_y_two < 0 || start_bullet_y_two > 200)) begin
	exist_bullet_two <= 0;
end 
if (exist_bullet_three && (start_bullet_x_three < 0 || start_bullet_x_three > 150 || start_bullet_y_three < 0 || start_bullet_y_three > 200)) begin
	exist_bullet_three <= 0;
end 
if (exist_bullet_four && (start_bullet_x_four < 0 || start_bullet_x_four > 150 || start_bullet_y_four < 0 || start_bullet_y_four > 200)) begin
	exist_bullet_four <= 0;
end 
if (exist_bullet_five && (start_bullet_x_five < 0 || start_bullet_x_five > 150 || start_bullet_y_five < 0 || start_bullet_y_five > 200)) begin
	exist_bullet_five <= 0;
end 

// whether enemy is out of space
if (exist_enemy_one && (start_enemy_x_one < 0 || start_enemy_x_one > 150 || start_enemy_y_one == 0 || start_enemy_y_one > 200)) begin
	if (start_enemy_y_one == 0) begin
                exist_player <= 0;
                exist_enemy_one <= 0;    
        end else begin
                exist_enemy_one <= 0; 
        end
end 
if (exist_enemy_two && (start_enemy_x_two < 0 || start_enemy_x_two > 150 || start_enemy_y_two == 0 || start_enemy_y_two > 200)) begin
	if (start_enemy_y_two == 0) begin
                exist_player <= 0;
                exist_enemy_two <= 0;    
        end else begin
                exist_enemy_two <= 0; 
        end
end 
if (exist_enemy_three && (start_enemy_x_three < 0 || start_enemy_x_three > 150 || start_enemy_y_three == 0 || start_enemy_y_three > 200)) begin
	if (start_enemy_y_three == 0) begin
                exist_player <= 0;
                exist_enemy_three <= 0;    
        end else begin
                exist_enemy_three <= 0; 
        end
end 
if (exist_enemy_four && (start_enemy_x_four < 0 || start_enemy_x_four > 150 || start_enemy_y_four == 0 || start_enemy_y_four > 200)) begin
	if (start_enemy_y_four == 0) begin
                exist_player <= 0;
                exist_enemy_four <= 0;    
        end else begin
                exist_enemy_four <= 0; 
        end
end 
if (exist_enemy_five && (start_enemy_x_five < 0 || start_enemy_x_five > 150 || start_enemy_y_five == 0 || start_enemy_y_five > 200)) begin
	if (start_enemy_y_five == 0) begin
                exist_player <= 0;
                exist_enemy_five <= 0;    
        end else begin
                exist_enemy_five <= 0; 
        end
end 
                state <= state + 1;
        end else if (state == 1) begin
    if (!exist_enemy_one && duration == 31) begin
    	exist_enemy_one <= 1;
    	start_enemy_y_one <= 200;
    	start_enemy_x_one <= (seed %5)* 30;
    end else if (!exist_enemy_two && duration == 31) begin
    	exist_enemy_two <= 1;
    	start_enemy_y_two <= 200;
    	start_enemy_x_two <= (seed %5)* 30;
    end else if (!exist_enemy_three && duration == 31) begin
    	exist_enemy_three <= 1;
    	start_enemy_y_three <= 200;
    	start_enemy_x_three <= (seed %5)* 30;
    end else if (!exist_enemy_four && duration == 31) begin
    	exist_enemy_four <= 1;
    	start_enemy_y_four <= 200;
    	start_enemy_x_four <= (seed %5)* 30;
    end else if (!exist_enemy_five && duration == 31) begin
    	exist_enemy_five <= 1;
    	start_enemy_y_five <= 200;
    	start_enemy_x_five <= (seed %5)* 30;
    end else; 
                state <= state + 1;  
        end
    end
    end
end

always @(posedge clk) begin
    if (counter >= 32'd3000000) begin
            counter <= 32'd0;
            duration <= duration + 1;
            seed <= (seed + 13) * 7 * (start_player_x+1);
    end else begin
            counter <= counter + 32'd1;
    end
end
assign start_player_x_ = start_player_x;
assign start_player_y_ = start_player_y;
assign start_enemy_x_one_ = start_enemy_x_one;
assign start_enemy_y_one_ = start_enemy_y_one;
assign start_enemy_x_two_ = start_enemy_x_two;
assign start_enemy_y_two_ = start_enemy_y_two;
assign start_enemy_x_three_ = start_enemy_x_three;
assign start_enemy_y_three_ = start_enemy_y_three;
assign start_enemy_x_four_ = start_enemy_x_four;
assign start_enemy_y_four_ = start_enemy_y_four;
assign start_enemy_x_five_ = start_enemy_x_five;
assign start_enemy_y_five_ = start_enemy_y_five;
assign start_bullet_x_one_ = start_bullet_x_one;
assign start_bullet_y_one_ = start_bullet_y_one;
assign start_bullet_x_two_ = start_bullet_x_two;
assign start_bullet_y_two_ = start_bullet_y_two;
assign start_bullet_x_three_ = start_bullet_x_three;
assign start_bullet_y_three_ = start_bullet_y_three;
assign start_bullet_x_four_ = start_bullet_x_four;
assign start_bullet_y_four_ = start_bullet_y_four;
assign start_bullet_x_five_ = start_bullet_x_five;
assign start_bullet_y_five_ = start_bullet_y_five;
assign start_words_x_ = start_words_x;
assign exist_bullet_one_ = exist_bullet_one;
assign exist_bullet_two_ = exist_bullet_two;
assign exist_bullet_three_ = exist_bullet_three;
assign exist_bullet_four_ = exist_bullet_four;
assign exist_bullet_five_ = exist_bullet_five;
assign exist_enemy_one_ = exist_enemy_one;
assign exist_enemy_two_ = exist_enemy_two;
assign exist_enemy_three_ = exist_enemy_three;
assign exist_enemy_four_ = exist_enemy_four;
assign exist_enemy_five_ = exist_enemy_five;
assign exist_player_ = exist_player;
endmodule
