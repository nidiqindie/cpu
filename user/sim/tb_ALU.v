`timescale 1ns/1ns
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
// Last modified Date:     2024/07/06 15:13:45
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/06 15:13:45
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_ALU.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_ALU.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_ALU;
    reg clk  ;
    reg rst_n;
    reg add  ;
    reg sub  ;
    reg inc  ;
    reg dec  ;
    reg  signed [7:0] input_x;
    reg  signed [7:0] input_y;
    wire [7:0] alu_b;
    wire    CF ;
    wire    AF ;
    wire    ZF ;
    wire    SF ;
    wire    OF ;


    ALU ALU_inst(
            .clk     (clk   )    ,
            .rst_n   (rst_n )     ,
            .add     (add   )    ,
            .sub     (sub   )       ,
            .inc     (inc   )    ,
            .input_x (input_x)    ,
            .input_y (input_y)    ,
            .alu_b   (alu_b )    ,
            .CF      (CF    )    ,
            .AF      (AF    )    ,
            .ZF      (ZF    )    ,
            .SF      (SF    )    ,
            .OF      (OF    ),
            .dec(dec)
        );

    initial begin
        rst_n=1'd0;
        clk=1'd0;
        input_x= -11;
        input_y=-11;
        
        #10
         rst_n<=1'd1;
        #20
         add<=1'd1;
        #20
         add<=1'd0;
        inc<=1'd1;
        #20
         inc<=1'd0;
        sub<=1'd1;

    end
    always #10 begin
        clk<=~clk;
    end


endmodule
