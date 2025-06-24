
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE
// VSCODE plug-in version: Verilog-Hdl-Format-2.4.20240526
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            COMPANY_NAME
// All rights reserved
// File name:
// Last modified Date:     2024/07/05 17:53:57
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             mzc
// Created date:           2024/07/05 17:53:57
// Version:                V1.0
// TEXT NAME:              register_stack.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\src\register_stack.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//
module register_stack(
        input clk,
        input rst_n,
        input LDPI,
        input I9,
        input I8,
        input wire [7:0] write_data,
        output reg [7:0] out_R0,
        output reg [7:0] out_R1,
        output reg [7:0] out_R2,
        output reg [7:0] out_R3
    );
    
    reg [1:0] temp;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            out_R0<='d0;
            out_R1<='d0;
            out_R2<='d0;
            out_R3<='d0;
            temp<=2'd0;
        end
        else if(!LDPI) begin
            out_R0<=out_R0;
            out_R1<=out_R1;
            out_R2<=out_R2;
            out_R3<=out_R3;
        end
        else begin
            temp[0]=I8;
            temp[1]=I9;
            case (temp)
                2'd0:
                    out_R0=write_data;
                2'd1:
                    out_R1=write_data;
                2'd2:
                    out_R2=write_data;
                2'd3:
                    out_R3=write_data;
                default:
                    ;
            endcase
        end
    end


endmodule
