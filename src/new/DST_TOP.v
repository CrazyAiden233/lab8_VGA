module DST_TOP (
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,

    output                  [ 0 : 0]            VGA_HS,         //行同步
    output                  [ 0 : 0]            VGA_VS          //场同步
);
wire [0:0] pclk;
clk_wiz_0 clk_init(
    .clk_in1(clk),
    .clk_out1(pclk)
);
DST dst(
    .rstn(rstn),
    .pclk(pclk),
    .hs(VGA_HS),
    .vs(VGA_VS)
);
/*DDP ddp(
               hen,
               ven,
               rstn,
               pclk,
  [11:0]       rdata,

[11:0]   rgb,
[DW-1:0] raddr
)*/
endmodule