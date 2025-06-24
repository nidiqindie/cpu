`timescale 1ns/1ns
module tb_pc_counter;
reg         sys_clk;       
reg         sys_rst;  
reg         LOAD;
reg         LDPC;
reg [7:0] load_addr;
wire [7:0] ABUSI;

PC_counter PC_counter_inst(
    .ABUSI      (ABUSI),
    .LDPC       (LDPC),
    .LOAD       (LOAD),
    .load_addr  (load_addr),
    .sys_clk    (sys_clk),
    .sys_rst    (sys_rst)
);
initial begin
    sys_rst<=1'd0;
    sys_clk<=1'd0;
    load_addr<=8'b0001_0000;
    #10
    sys_rst<=1'd1;
    LOAD   <=1'd1;
    LDPC   <=1'd0;
    #100
    LOAD   <=1'd0;
    LDPC   <=1'd1;
end
initial
    begin            
        $dumpfile("tb_pc_counter.vcd");  //生成vcd文件，记录仿真信息
        $dumpvars(0, tb_pc_counter);  //指定层次数，记录信号
    end 
always #10 begin
    sys_clk<=~sys_clk;
end
endmodule