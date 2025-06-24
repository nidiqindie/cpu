`timescale 1ns / 1ns
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE
// VSCODE plug-in version: Verilog-Hdl-Format-2.6.20240622
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            gd
// All rights reserved
// File name:
// Last modified Date:     2024/07/07 20:25:43
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             mzc
// Created date:           2024/07/07 20:25:43
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_DATA_SRAM.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_DATA_SRAM.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_DATA_SRAM;
    reg WD;
    reg RD;
    reg CS_D;
    reg [7:0] DIN;
    reg [6:0] ADDR;
    // outports wire
    wire [7:0] 	DOUT;

    DATA_SRAM u_DATA_SRAM(
                  .WD   	( WD    ),
                  .RD   	( RD    ),
                  .CS_D 	( CS_D  ),
                  .DIN  	( DIN   ),
                  .ADDR 	( ADDR  ),
                  .DOUT 	( DOUT  )
              );


    initial begin
        CS_D<=1'd1;
        DIN<=8'b0000_0001;
        ADDR<=0;
        RD<=0;
        WD<=1;
        #10
         CS_D<=1'd0;
        #10
         CS_D<=1'd1;
        DIN<=8'b0000_0011;
        ADDR<=1;
        #10
         CS_D<=1'd0;
        #10
         CS_D<=1'd1;
        RD<=1;
        WD<=0;
        ADDR<=0;
        #10
        CS_D<=1'd0;
        #10
        CS_D<=1'd1;
        ADDR<=7'd1;
        #10
        CS_D<=1'd0;
    end



endmodule
