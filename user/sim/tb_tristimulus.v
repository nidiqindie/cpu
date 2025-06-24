`timescale 1ns / 1ps
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
// Last modified Date:     2024/07/10 17:41:37
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/10 17:41:37
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_tristimulus.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_tristimulus.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_tristimulus;
       // outports wire
    reg [7:0] in;
    reg enable1;
    wire [7:0] 	out;

    reg [7:0] in2;
    reg enable2;
 

    tristimulus u_tristimulus(
                    .in     	( in      ),
                    .enable 	( enable1  ),
                    .out    	( out     )
                );
                // outports wire


tristimulus u_tristimulus2(
	.in     	( in2      ),
	.enable 	( enable2  ),
	.out    	( out     )
);

    initial begin
        enable1<=1'd0;
         in<=8'd2;
         in2<=8'd3;
         enable2<=1'd0;
        #20
        enable2<=1'd0;
        enable1<=1'd1;
        #20
        enable2<=1'd1;
         enable1<=1'd0;
        #20
        enable2<=1'd0;
        enable1<=1'd1;
        #20
        enable2<=1'd1;
         enable1<=1'd0;

    end
endmodule
