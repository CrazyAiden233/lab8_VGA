module TOP (
    input                   [ 0 : 0]            rstn,
    input                   [ 0 : 0]            clk,

    output                  [ 0 : 0]            VGA_HS,         //行同�?
    output                  [ 0 : 0]            VGA_VS,          //场同�?
    output                  [11 : 0]            rgb
);
wire [0:0] pclk;
wire [0:0] hen;
wire [0:0] ven;
wire [14:0] raddr=0;
wire [11:0] rdata;
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
DDP ddp(
    .hen(hen),        
    .ven(ven),        
    .rstn(rstn),
    .rdata(rdata),
    .pclk(pclk),
    .raddr(raddr),
    .rgb(rgb)  
);
blk_mem_gen_0 your_instance_name (
  .clka(pclk),   
  .ena(1'b1),    
  .wea(1'b0),    
  .addra(raddr), 
  .douta(rdata)  
);
endmodule