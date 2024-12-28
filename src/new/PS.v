module PS#(
        parameter  WIDTH = 1
)
(
        input             s,
        input             clk,
        output            p
);
reg [WIDTH-1:0] s_d;
always @(posedge clk) begin
    s_d <= s;
end
assign p = ~s_d && s;
assign p = ~s_d && s;
endmodule