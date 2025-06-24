`timescale 1ns / 1ns
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
// Last modified Date:     2024/07/12 17:15:59
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/12 17:15:59
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_test.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_test.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_test(
    input a,
    output b
);
    reg  clk  ;
    reg  rst_n;
    // outports wire
    wire   	test_out;
    wire   	out;

    test_1 u_test_1(
               .clk     	( clk      ),
               .rst_n   	( rst_n    ),
               .test_in 	( test_out  ),
               .out     	( out      )
           );

    // outports wire


    test2 u_test2(
              .clk      	( clk       ),
              .rst_n    	( rst_n     ),
              .test_out 	( test_out  )
          );
    initial begin
        rst_n<=1'd0;
        clk<=1'd0;
        #10
         rst_n<=1'd1;
    end
    always #10 begin
        clk<=~clk;
    end

endmodule
