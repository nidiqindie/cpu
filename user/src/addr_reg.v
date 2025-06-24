module addr_reg(
load_addr,LDAR,ABUSD,sys_clk,sys_rst
);



input [7:0] load_addr;
input wire LDAR;
input sys_clk;
input sys_rst;
output reg [7:0] ABUSD;


    always @(posedge sys_clk or negedge sys_rst) begin
        if (!sys_rst) begin
         ABUSD<=8'd0;
        end
        else if (LDAR==1'd1) begin
            ABUSD<=load_addr;
        end
        else begin
            ABUSD<=ABUSD;
        end
    end

endmodule