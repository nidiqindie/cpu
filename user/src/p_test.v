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
// Last modified Date:     2024/07/10 22:33:38
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/10 22:33:38
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              p_test.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\src\p_test.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module p_test(
        input    clk   ,
        input    rst_n ,
        input   [25:0]   input_micro_op,
        input   [3:0]  	in_op,
        input  CF,
        input  AF,
        input  ZF,
        input  SF,
        input  OF,
        output reg [25:0] output_micro_op
    );
    parameter
        P1              =   3'b100                 ,
        P2              =   3'b010                 ,
        P3              =   3'b001                 ,
        move            =   4'b0010                ,
        cmp             =   4'b0100                ,
        INCC             =   4'b0101                ,
        DECC             =   4'b0110                ,
        JL              =   4'b0111                ,
        JNZ             =   4'b1000                ,
        out1            =   4'b1001                 ,
        LAD            =   4'b1011                ,
        St             =   4'b1110                ,
        ot             =   4'b1111                ;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  begin
            output_micro_op=26'b00000100000000000000_000001;
        end
        else  begin
            output_micro_op[25:6]=input_micro_op[25:6];
            case (input_micro_op[8:6])
                P1: begin
                    case (in_op)
                        move: begin
                            output_micro_op[5:0]=6'd3;
                        end
                         LAD: begin
                            output_micro_op[5:0]=6'd4;
                        end
                        INCC: begin
                            output_micro_op[5:0]=6'd8;
                        end
                        cmp: begin
                            output_micro_op[5:0]=6'd9;
                        end
                        JL: begin
                            output_micro_op[5:0]=6'd10;
                        end
                        JNZ: begin
                            output_micro_op[5:0]=6'd12;
                        end
                        DECC: begin
                            output_micro_op[5:0]=6'd14;
                        end
                        St: begin
                            output_micro_op[5:0]=6'd15;
                        end
                        ot: begin
                            output_micro_op[5:0]=6'd16;
                        end
                        out1: begin
                            output_micro_op[5:0]=6'd18;
                        end
                        default: begin
                            output_micro_op[5:0]=input_micro_op[5:0] ;
                        end
                    endcase
                end
                P2: begin
                    if (SF==1) begin
                        output_micro_op[5:0]=6'd11;
                    end
                    else begin
                        output_micro_op[5:0]=input_micro_op[5:0] ;
                    end
                end
                P3: begin
                    if (ZF==0) begin
                        output_micro_op[5:0]= 6'd13;
                    end
                    else begin
                        output_micro_op[5:0]=input_micro_op[5:0] ;
                    end
                end
                default: begin
                    output_micro_op[5:0]=input_micro_op[5:0];
                end
            endcase
        end
    end

endmodule
