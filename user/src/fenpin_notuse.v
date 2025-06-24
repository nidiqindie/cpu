module fenpin_notuse(
    sys_clk,fen_clk,sys_rst
);
    input      sys_rst;
    input      sys_clk;
    output reg fen_clk;
    reg [1:0] counter;
    always @(posedge sys_clk or negedge sys_rst) begin
        if (!sys_rst) begin
            counter<=2'd0;
        end
        else begin
             counter<=counter+2'd1;
        end
    end
    always @(posedge sys_clk or negedge sys_rst) begin
        if (!sys_rst) begin
            fen_clk<=1'd0;
        end
        else if (counter >2'd1 ) begin
            fen_clk<=1'd0;
        end
        else begin
            fen_clk<=1'd1;
        end
    end

endmodule