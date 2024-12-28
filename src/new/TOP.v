// move -> collsion -> create

module TOP (
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,

    output                  [ 0 : 0]            VGA_HS,         //??????
    output                  [ 0 : 0]            VGA_VS,          //??????
    output                  [11 : 0]            rgb,
    output                                      AUD_PWM,
    inout                                       PS2_CLK,
    inout                                       PS2_DATA,
    input                                       UART_RXD_OUT,
    output                                      UART_TXD_IN,
    output                                      UART_CTS,
    input                                       UART_RTS
);
wire [0:0] pclk;
wire [0:0] hen;
wire [0:0] ven;
wire [14:0] raddr_player, raddr_enemy, raddr_bullet, raddr_score, raddr_bg, raddr_words, raddr_died, raddr_background;
wire [11:0] rdata_player, rdata_enemy, rdata_bullet, rdata_score, rdata_bg, rdata_words, rdata_died, rdata_background;
wire [8:0] start_player_x, start_player_y;

wire [8:0] start_enemy_x_one, start_enemy_y_one;
wire [8:0] start_enemy_x_two, start_enemy_y_two;
wire [8:0] start_enemy_x_three, start_enemy_y_three;
wire [8:0] start_enemy_x_four, start_enemy_y_four;
wire [8:0] start_enemy_x_five, start_enemy_y_five;

wire [8:0] start_bullet_x_one, start_bullet_y_one;
wire [8:0] start_bullet_x_two, start_bullet_y_two;
wire [8:0] start_bullet_x_three, start_bullet_y_three;
wire [8:0] start_bullet_x_four, start_bullet_y_four;
wire [8:0] start_bullet_x_five, start_bullet_y_five;
wire [8:0] start_words_x;

wire [0:0] bt_W, bt_S, bt_J;
wire [0:0] exist_player, game;

wire [0:0] exist_enemy_one;
wire [0:0] exist_enemy_two;
wire [0:0] exist_enemy_three;
wire [0:0] exist_enemy_four;
wire [0:0] exist_enemy_five;

wire [0:0] exist_bullet_one;
wire [0:0] exist_bullet_two;
wire [0:0] exist_bullet_three;
wire [0:0] exist_bullet_four;
wire [0:0] exist_bullet_five;

wire [9:0] score;

wire [3:0]	    music_data;
wire [9:0]      addr;
clk_wiz_0 instance_name (
    .clk_out1(pclk),
    .reset(1'b0),
    .clk_in1(clk)
);
DST dst(
    .rstn(rstn),
    .pclk(pclk),
    .hs(VGA_HS),
    .vs(VGA_VS),
    .hen(hen),
    .ven(ven)
);
blk_mem_gen_0 background (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_background), 
  .douta(rdata_background)  
);

blk_mem_gen_1 player (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_player), 
  .douta(rdata_player)  
);

blk_mem_gen_2 enemy (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_enemy), 
  .douta(rdata_enemy)  
);
blk_mem_gen_3 bullet (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_bullet), 
  .douta(rdata_bullet)  
);
blk_mem_gen_4 scores (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_score), 
  .douta(rdata_score)  
);
blk_mem_gen_5 start_bg (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_bg), 
  .douta(rdata_bg)  
);
blk_mem_gen_6 words (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_words), 
  .douta(rdata_words)  
);
blk_mem_gen_7 died (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_died), 
  .douta(rdata_died)  
);

DDP ddp(
    .hen(hen),        
    .ven(ven),        
    .rstn(rstn),
    .rdata_background(rdata_background),
    .rdata_player(rdata_player),
    .rdata_enemy(rdata_enemy),
    .rdata_bullet(rdata_bullet),
    .rdata_score(rdata_score),
    .rdata_bg(rdata_bg),
    .rdata_words(rdata_words),
    .rdata_died(rdata_died),
    .pclk(pclk),
    .raddr_background(raddr_background),
    .raddr_player(raddr_player),
    .raddr_enemy(raddr_enemy),
    .raddr_bullet(raddr_bullet),
    .raddr_score(raddr_score),
    .raddr_bg(raddr_bg),
    .raddr_words(raddr_words),
    .raddr_died(raddr_died),
    .start_player_x(start_player_x),
    .start_player_y(start_player_y),
    
    .start_enemy_x_one(start_enemy_x_one),
    .start_enemy_y_one(start_enemy_y_one),
    .start_enemy_x_two(start_enemy_x_two),
    .start_enemy_y_two(start_enemy_y_two),
    .start_enemy_x_three(start_enemy_x_three),
    .start_enemy_y_three(start_enemy_y_three),
    .start_enemy_x_four(start_enemy_x_four),
    .start_enemy_y_four(start_enemy_y_four),
    .start_enemy_x_five(start_enemy_x_five),
    .start_enemy_y_five(start_enemy_y_five),
    
    .start_bullet_x_one(start_bullet_x_one),
    .start_bullet_y_one(start_bullet_y_one),
    .start_bullet_x_two(start_bullet_x_two),
    .start_bullet_y_two(start_bullet_y_two),
    .start_bullet_x_three(start_bullet_x_three),
    .start_bullet_y_three(start_bullet_y_three),
    .start_bullet_x_four(start_bullet_x_four),
    .start_bullet_y_four(start_bullet_y_four),
    .start_bullet_x_five(start_bullet_x_five),
    .start_bullet_y_five(start_bullet_y_five),
    
    .rgb(rgb),
    .score(score),
    .game(game),
    .start_words_x(start_words_x),
    
    .exist_bullet_one(exist_bullet_one),
    .exist_bullet_two(exist_bullet_two),
    .exist_bullet_three(exist_bullet_three),
    .exist_bullet_four(exist_bullet_four),
    .exist_bullet_five(exist_bullet_five),
    
    .exist_enemy_one(exist_enemy_one),
    .exist_enemy_two(exist_enemy_two),
    .exist_enemy_three(exist_enemy_three),
    .exist_enemy_four(exist_enemy_four),
    .exist_enemy_five(exist_enemy_five),
    
    .exist_player(exist_player)
);

keyboard keyboard0(
    .rst(~rstn),
    .clk(clk),
    .USB_CLOCK(PS2_CLK),
    .USB_DATA(PS2_DATA),
    .RXD(UART_RXD_OUT),
    .TXD(UART_TXD_IN),
    .CTS(UART_CTS),
    .RTS(UART_RTS),
    .bt_W(bt_W),
    .bt_S(bt_S),
    .bt_J(bt_J),
    .bt_SPACE(bt_SPACE)
);

Move move(
    .clk(pclk),
    .rstn(rstn),
    .score(score),

    .start_player_x_(start_player_x),
    .start_player_y_(start_player_y),
    
    .start_enemy_x_one_(start_enemy_x_one),
    .start_enemy_y_one_(start_enemy_y_one),
    .start_enemy_x_two_(start_enemy_x_two),
    .start_enemy_y_two_(start_enemy_y_two),
    .start_enemy_x_three_(start_enemy_x_three),
    .start_enemy_y_three_(start_enemy_y_three),
    .start_enemy_x_four_(start_enemy_x_four),
    .start_enemy_y_four_(start_enemy_y_four),
    .start_enemy_x_five_(start_enemy_x_five),
    .start_enemy_y_five_(start_enemy_y_five),
    
    .start_bullet_x_one_(start_bullet_x_one),
    .start_bullet_y_one_(start_bullet_y_one),
    .start_bullet_x_two_(start_bullet_x_two),
    .start_bullet_y_two_(start_bullet_y_two),
    .start_bullet_x_three_(start_bullet_x_three),
    .start_bullet_y_three_(start_bullet_y_three),
    .start_bullet_x_four_(start_bullet_x_four),
    .start_bullet_y_four_(start_bullet_y_four),
    .start_bullet_x_five_(start_bullet_x_five),
    .start_bullet_y_five_(start_bullet_y_five),
    .start_words_x_(start_words_x),
    
    .bt_W(bt_W),
    .bt_S(bt_S),
    .bt_J(bt_J),
    .bt_SPACE(bt_SPACE),
    
    .exist_bullet_one_(exist_bullet_one),
    .exist_bullet_two_(exist_bullet_two),
    .exist_bullet_three_(exist_bullet_three),
    .exist_bullet_four_(exist_bullet_four),
    .exist_bullet_five_(exist_bullet_five),
    
    .exist_enemy_one_(exist_enemy_one),
    .exist_enemy_two_(exist_enemy_two),
    .exist_enemy_three_(exist_enemy_three),
    .exist_enemy_four_(exist_enemy_four),
    .exist_enemy_five_(exist_enemy_five),
    
    .exist_player_(exist_player),

    .game(game)
);
blk_mem_gen_8 music (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(addr), 
  .douta(music_data)  
);
music music0(
    .clk(clk),
    .rst_n(rstn),
    .beep(AUD_PWM),
    .music_data(music_data),
    .cnt2(addr)
);
endmodule
