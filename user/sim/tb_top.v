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
// Last modified Date:     2024/07/10 15:38:47
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/10 15:38:47
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_top.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_top.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_top;
    reg         clk  ;
    reg         rst_n;
    //程序ram的写入和片选使能，写入总线。
    reg PROGREM_WD;
    reg PROGREM_SRAM_out_CS_D;
    reg [15:0] PROGREM_DIN;
    reg [7:0] PROGREM_RAM_OUT_ADDR;
    //外部数据ram写入片选使能，写入的数据和地址总线。
    reg DATA_RAM_out_WD;
    reg DATA_RAM_SRAM_out_CS_D;
    reg [7:0] DATA_RAM_OUT_DIN;
    reg [7:0] DATA_RAM_OUT_ADDR;
    //输出线，接内部的数据总线
    wire [7:0] out_to_wave;



    top u_top(
            .clk                    	( clk                     ),
            .rst_n                  	( rst_n                   ),
            .PROGREM_WD             	( PROGREM_WD              ),
            .PROGREM_SRAM_out_CS_D  	( PROGREM_SRAM_out_CS_D   ),
            .PROGREM_RAM_OUT_ADDR   	( PROGREM_RAM_OUT_ADDR    ),
            .PROGREM_DIN            	( PROGREM_DIN             ),
            .DATA_RAM_out_WD        	( DATA_RAM_out_WD         ),
            .DATA_RAM_SRAM_out_CS_D 	( DATA_RAM_SRAM_out_CS_D  ),
            .DATA_RAM_OUT_DIN       	( DATA_RAM_OUT_DIN        ),
            .DATA_RAM_OUT_ADDR      	( DATA_RAM_OUT_ADDR       ),
            .out_to_wave            	( out_to_wave             )
        );

    initial begin
        rst_n<=1'd0;
        clk<=1'd0;
        PROGREM_WD<=1'd0;
        PROGREM_DIN<='d0;
        PROGREM_RAM_OUT_ADDR<='d0;
        //默认片选
        PROGREM_SRAM_out_CS_D<=1'd0;
        #10
         rst_n<=1'd1;
        burn_to_progrem_ram(16'b0010_00_10_00001000,8'd0);//二号存8，存要打到ram的数
        burn_to_progrem_ram(16'b0010_00_11_00001100,8'd1);//三号存8，存要打到ram的数
        burn_to_progrem_ram(16'b0100_10_11_00000000,8'd2);//cmp命令，拿二号和三号来比
        burn_to_progrem_ram(16'b1000_00_00_00000101,8'd3);//jNZ
        burn_to_progrem_ram(16'b0010_00_11_00001001,8'd4);//三号存9，存要打到ram的数
        burn_to_progrem_ram(16'b0010_00_11_00001010,8'd5);//三号存10，存要打到ram的数

        //程序结束end
        burn_to_progrem_ram(16'b1100_00_00_00000000,8'd6);

        // burn_to_progrem_ram(16'b0010_00010000,8'd0);//二号存8，存要打到
        // burn_to_progrem_ram(16'b0010_00101010,8'd1);//三号存8，存要打到
        // burn_to_progrem_ram(16'b0010_00101001,8'd2);//cmp命令，拿二号
        // burn_to_progrem_ram(16'b0010_00010000,8'd3);
        // burn_to_progrem_ram(16'b1011_01000000,8'd4);//三号存9，存要打到
        // burn_to_progrem_ram(16'b0101_01000000,8'd5);//三号存10，存要打到
        // burn_to_progrem_ram(16'b1011_01110000,8'd6);//二号存8，存要打到
        // burn_to_progrem_ram(16'b0100_00110000,8'd7);//三号存8，存要打到
        // burn_to_progrem_ram(16'b0111_00001111,8'd8);//cmp命令，拿二号
        // burn_to_progrem_ram(16'b0110_01000000,8'd9);
        // burn_to_progrem_ram(16'b1110_01000000,8'd10);//三号存9，存要打到
        // burn_to_progrem_ram(16'b1111_11000000,8'd11);//三号存10，存要打到
        // burn_to_progrem_ram(16'b0101_01000000,8'd12);//二号存8，存要打到
        // burn_to_progrem_ram(16'b1110_01000000,8'd13);//三号存8，存要打到
        // burn_to_progrem_ram(16'b1111_00000000,8'd14);//cmp命令，拿二号
        // burn_to_progrem_ram(16'b0101_01000000,8'd15);
        // burn_to_progrem_ram(16'b0010_00001010,8'd16);//三号存9，存要打到
        // burn_to_progrem_ram(16'b0100_01001010,8'd17);//三号存10，存要打到
        // burn_to_progrem_ram(16'b1000_00001001,8'd18);//二号存8，存要打到
        // burn_to_progrem_ram(16'b0110_10000000,8'd19);//三号存8，存要打到
        // burn_to_progrem_ram(16'b1000_00001000,8'd20);//cmp命令，拿二号
        // burn_to_progrem_ram(16'b0010_00010000,8'd21);
        // burn_to_progrem_ram(16'b0010_00101010,8'd22);//三号存9，存要打到
        // burn_to_progrem_ram(16'b1011_01000000,8'd23);//三号存10，存要打到
        // burn_to_progrem_ram(16'b1001_00000000,8'd24);//二号存8，存要打到
        // burn_to_progrem_ram(16'b0101_01000000,8'd25);//三号存8，存要打到
        // burn_to_progrem_ram(16'b0110_10000000,8'd26);//cmp命令，拿二号
        // burn_to_progrem_ram(16'b1000_00010110,8'd27);
        // burn_to_progrem_ram(16'b1100_00000000,8'd28);//三号存9，存要打到
     
        #20
         PROGREM_WD<=1'd0;

    end
    always #10 begin
        clk<=~clk;
    end


    //输入一个程序，16位的
    task burn_to_progrem_ram;
        input        [15:0]      progrem;
        input        [7:0]       addr;
        begin
            //准备要烧录的程序
            #20
             PROGREM_WD<=1'd0;
            PROGREM_DIN<=progrem;
            PROGREM_RAM_OUT_ADDR<=addr;
            //执行烧录程序
            #20
             PROGREM_WD<=1'd1;

        end
    endtask
endmodule
