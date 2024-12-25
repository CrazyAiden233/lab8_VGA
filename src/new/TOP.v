module TOP (
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,

    output                  [ 0 : 0]            VGA_HS,         //��ͬ???
    output                  [ 0 : 0]            VGA_VS,          //��ͬ???
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
dist_mem_gen_0 bullet (
  .clk(pclk),   
  .we(1'b0),    
  .a(raddr_bullet), 
  .spo(rdata_bullet)  
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
    .start_player_x(0),
    .start_player_y(0),
    .start_enemy_x(0),
    .start_enemy_y(100),
    .start_bullet_x(0),
    .start_bullet_y(60),
    .rgb(rgb)  
);

keyboard keyboard0(
    .rst(~rstn),
    .clk(clk),
    .USB_CLOCK(PS2_CLK),
    .USB_DATA(PS2_DATA),
    .RXD(UART_RXD_OUT),
    .TXD(UART_TXD_IN),
    .CTS(UART_CTS),
    .RTS(UART_RTS)
);
endmodule