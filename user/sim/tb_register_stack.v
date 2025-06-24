`timescale 1ns / 1ns
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE
// VSCODE plug-in version: Verilog-Hdl-Format-2.6.20240622
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)           gd
// All rights reserved
// File name:
// Last modified Date:     2024/07/05 18:21:01
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:            mzc
// Created date:           2024/07/05 18:21:01
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_register_stack.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_register_stack.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_register_stack;


    reg       clk;
    reg       rst_n;
    reg       I9;
    reg       I8;
    reg       LDPI;
    reg  [7:0] write_data;
    // outports wire

    wire [7:0] out_R0;
    wire [7:0] out_R1;
    wire [7:0] out_R2;
    wire [7:0] out_R3;
    register_stack u_register_stack(
                       .clk        	( clk         ),
                       .rst_n      	( rst_n       ),
                       .LDPI       	( LDPI        ),
                       .I9         	( I9          ),
                       .I8         	( I8          ),
                       .write_data 	( write_data  ),
                       .out_R0         (out_R0),
                       .out_R1         (out_R1),
                       .out_R2         (out_R2),
                       .out_R3         (out_R3)
                   );

    initial begin
        rst_n<=1'd0;
        clk<=1'd0;
        write_data<=8'b0001_0000;
        I8<=1'd0;
        I9<=1'd0;
        LDPI<=1'd0;
        #10
         rst_n<=1'd1;
        LDPI<=1'd1;
        #100
         I8<=1'd1;
        I9<=1'd0;
        #100
         I8<=1'd0;
        I9<=1'd1;

        #100
         I8<=1'd1;
        I9<=1'd1;


    end
    always #10 begin
        clk<=~clk;
    end


endmodule
