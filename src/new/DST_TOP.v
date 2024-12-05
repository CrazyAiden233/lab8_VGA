module DST_TOP (
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,

    output                  [ 0 : 0]            hs,         //行同步
    output                  [ 0 : 0]            vs          //场同步
);
wire [0:0] pclk;
clk_wiz_0 clk_init(
    .clk_in1(clk),
    .clk_out1(pclk)
);
DST dst(
    .rstn(rstn),
    .pclk(pclk),
    .hs(hs),
    .vs(vs)
);
endmodule