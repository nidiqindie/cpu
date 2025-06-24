`timescale 1ns/1ns
module tb_fenpin;
reg         sys_clk;       
reg         sys_rst;  
wire         fen_clk;
fenpin_notuse fenpin_notuse_inst(
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .fen_clk(fen_clk)
);

initial begin
    sys_rst=1'd0;
    sys_clk=1'd0;
    #10
    sys_rst=1'd1;
end
always #10 begin
    sys_clk<=~sys_clk;
end
endmodule