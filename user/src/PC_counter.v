module PC_counter(
load_addr,LDPC,LOAD,ABUSI,sys_clk,sys_rst
);
input [7:0] load_addr;
input wire LOAD;
input wire LDPC;
input sys_clk;
input sys_rst;

output reg [7:0] ABUSI;
    reg  count;
    always @(posedge sys_clk or negedge sys_rst) begin
        if (!sys_rst) begin
         ABUSI<=8'd0;
         count<=1'd0;
        end
        else if (LOAD==1'd1&&LDPC==1'd0) begin
            ABUSI<=load_addr;
        end
        else if (LOAD==1'd0&&LDPC==1'd1) begin
            if (count==1'd1) begin
                 ABUSI<=ABUSI+8'd1;
                count<=1'd0;
            end
            else begin
                count<=count+1'd1;
            end
        end
        else begin
            ABUSI<=ABUSI;
        end
    end

endmodule