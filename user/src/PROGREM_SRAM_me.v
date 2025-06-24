
module PROGREM_SRAM_me(
        input clk,
        input wire WD,
        input wire RD,
        input wire CS_D,
        input wire [15:0] DIN,
        input wire [7:0] ADDR,
        output reg [15:0] DOUT,
        output reg is_coming
    );

    reg [15:0] MEM[255:0];

    always @(posedge clk) begin
        if(CS_D==0) begin
            if((WD == 1'b1)) begin
                MEM[ADDR] = DIN;
                is_coming<=1'd0;
            end
            else if((RD == 1'd1)) begin
                DOUT = MEM[ADDR];
                is_coming =1'd1;
            end
            else begin
                is_coming<=1'd0;
            end
        end
        else begin
            is_coming<=1'd0;
        end

    end


endmodule

