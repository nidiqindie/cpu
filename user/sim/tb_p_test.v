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
// Last modified Date:     2024/07/10 23:54:11
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/10 23:54:11
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_p_test.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_p_test.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_p_test;
    reg clk           ;
    reg rst_n         ;
    reg [25:0] input_micro_op;
    reg [3:0] in_op         ;
    reg CF            ;
    reg AF            ;
    reg ZF            ;
    reg SF            ;
    reg OF            ;
    // outports wire
    wire [25:0] 	output_micro_op;

    p_test u_p_test(
               .clk             	( clk              ),
               .rst_n           	( rst_n            ),
               .input_micro_op  	( input_micro_op   ),
               .in_op           	( in_op            ),
               .CF              	( CF               ),
               .AF              	( AF               ),
               .ZF              	( ZF               ),
               .SF              	( SF               ),
               .OF              	( OF               ),
               .output_micro_op 	( output_micro_op  )
           );
    initial begin
        rst_n=1'd0;
        clk=1'd0;
        in_op<=4'd0;
        CF<=1'd0;
        AF<=1'd0;
        ZF<=1'd0;
        SF<=1'd0;
        OF<=1'd0;
        #10
         rst_n=1'd1;
        #20
         input_micro_op=26'b00000100000000000000_000001;
        #20
         input_micro_op=26'b00000000100000100000_000000;
    end
    always #10 begin
        clk<=~clk;
    end

endmodule
