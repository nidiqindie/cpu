
module DATA_SRAM(
        input wire WD,
        input wire RD,
        input wire CS_D,
        input wire [7:0] DIN,
        input wire [7:0] ADDR,
        output reg [7:0] DOUT
    );
    reg [7:0] MEM[255:0];

    always @(negedge CS_D) begin
        if((WD == 1'b1)) begin
            MEM[ADDR] = DIN;
        end
        else if((RD == 1'd1)) begin
            DOUT <= MEM[ADDR];
        end
        else begin
        end
    end


endmodule
