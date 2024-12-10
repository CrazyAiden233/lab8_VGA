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
/*TODO：这里的例化具体关系还没搞清楚，rdata是上个像素的rgb数据，
        这个部分相当于输入上个周期得到的rbg并显示，然后输出这个周期的rgb用于下个周期显示？
        这部分逻辑有点混乱，晚上再看
DDP ddp(
               hen,
               ven,
               rstn,
               pclk,
  [11:0]       rdata,

[11:0]   rgb,
[DW-1:0] raddr
)*/
endmodule