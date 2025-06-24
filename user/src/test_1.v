
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
// Last modified Date:     2024/07/12 17:12:12
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/12 17:12:12
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              test_1.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\src\test_1.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module test_1(
        input                               clk                        ,
        input                               rst_n  ,
        input                               test_in,
        output reg out
    );
        always @(posedge clk or negedge rst_n)           
            begin                                        
                if(!rst_n)                               
                           out<=1'd0;                            
                else if(test_in==1)
                begin
                    out<=1'd1;
                end 
                else
                begin
                    out<=1'd0;
                end                               
                                                                                            
            end                                          


endmodule
