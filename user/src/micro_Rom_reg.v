
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE
// VSCODE plug-in version: Verilog-Hdl-Format-2.6.20240622
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            Please Write Company name
// All rights reserved
// File name:
// Last modified Date:     2024/07/09 15:38:42
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/09 15:38:42
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              micro_Rom.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\src\micro_Rom.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module micro_Rom_reg(
        input                               clk     ,
        input                               rst_n   ,
        input [5:0]                       micro_addr,
        output reg [25:0]                   micro_op
    );
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            micro_op<=26'b00000100000000000000_000001;
        end

        else  begin
            case (micro_addr)
                6'd0 :
                    micro_op<=26'b00000000000000000000_000001;
                6'd1 :
                    micro_op<=26'b00000100000000000000_000010;
                6'd2 :
                    micro_op<=26'b00001010000000000100_000000;
                6'd3 :
                    micro_op<=26'b00000010100000100000_000000;
                6'd4 :
                    micro_op<=26'b00100011000000001000_000101;
                6'd5 :
                    micro_op<=26'b01000010100000010000_000000;
                6'd6 :
                    micro_op<=26'b00000010100101000000_000000;
                6'd7 :
                    micro_op<=26'b00000010001000000000_000000;
                6'd8 :
                    micro_op<=26'b00000010000000000010_000000;
                6'd9 :
                    micro_op<=26'b00010010000000100000_000000;
                6'd10 :
                    micro_op<=26'b00000010000000000000_000000;
                6'd11 :
                    micro_op<=26'b00010010000000100000_000000;
                6'd12 :
                    micro_op<=26'b00000010100011000000_000000;
                6'd13 :
                    micro_op<=26'b00100011000000001000_000000;
                6'd14 :
                    micro_op<=26'b10000010000000001000_000000;
                6'd15 :
                    micro_op<=26'b00000010000000001000_000000;
                default:
                    micro_op<=micro_op;
            endcase
        end
    end

endmodule
