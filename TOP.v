module TOP (
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,

    output                  [ 0 : 0]            VGA_HS,         //行同�??
    output                  [ 0 : 0]            VGA_VS,          //场同�??
    output                  [11 : 0]            rgb
);
wire [0:0] pclk;
wire [0:0] hen;
wire [0:0] ven;
wire [14:0] raddr_player, raddr_enemy, raddr_bullet, raddr_background;
wire [11:0] rdata_player, rdata_enemy, rdtata_bullet, rdata_background;
reg [8:0] start_player_x, start_player_y, start_enemy_x, start_enemy_y, start_bullet_x, start_bullet_y;

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

blk_mem_gen_0 player (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_player), 
  .douta(rdata_player)  
);

blk_mem_gen_0 enemy (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_enemy), 
  .douta(rdata_enemy)  
);

blk_mem_gen_0 bullet (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_bullet), 
  .douta(rdata_bullet)  
);

blk_mem_gen_0 background (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr_background), 
  .douta(rdata_background)  
);

DDP ddp(
    .hen(hen),        
    .ven(ven),        
    .rstn(rstn),
    .rdata_background(rdata_background),
    .rdata_player(rdata_player),
    .rdata_enemy(rdata_enemy),
    .rdata_bullet(rdata_bullet),
    .pclk(pclk),
    .raddr_background(raddr_background),
    .raddr_player(raddr_player),
    .raddr_enemy(raddr_enemy),
    .raddr_bullet(raddr_bullet),
    .start_player_x(start_player_x),
    .start_player_y(start_player_y),
    .start_enemy_x(start_enemy_x),
    .start_enemy_y(start_enemy_y),
    .start_bullet_x(start_bullet_x),
    .start_bullet_y(start_bullet_y),
    .rgb(rgb)  
);


endmodule