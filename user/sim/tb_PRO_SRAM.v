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
// Last modified Date:     2024/07/07 20:25:52
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/07 20:25:52
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_PRO_SRAM.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_PRO_SRAM.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_PRO_SRAM(
        input a,
        output b
    );

    reg RD  ;
    reg WD  ;
    reg CS_D;
    reg [7:0] ADDR;
    reg       clk;

    reg aclr;
    reg [15:0] DIN;

    // outports wire
    wire [15:0] 	q;

    PROGRAM_RAM u_PROGRAM_RAM(
                    .aclr    	( aclr     ),
                    .address 	( ADDR  ),
                    .clock   	( clk    ),
                    .data    	( DIN     ),
                    .rden    	( RD     ),
                    .wren    	( WD     ),
                    .q       	( q        )
                );


    initial begin
        clk<=1'd0;
        WD<=1'd0;
        RD<=1'd0;
        #10
        burn_to_progrem_ram(16'b0010_00_11_00001001,8'd0);
        burn_to_progrem_ram(16'b1001_11_00_0000_0000,8'd1);
        burn_to_progrem_ram(16'b1100_00_00_0000_0000,8'd2);
        #20
         WD<=1'd0;
        fine_to_progrem_ram(8'd0);
        fine_to_progrem_ram(8'd1);
        fine_to_progrem_ram(8'd2);
        #20
         RD<=1'd0;


    end
    always #10 begin
        clk<=~clk;
    end

    //输入一个程序，16位的
    task burn_to_progrem_ram;
        input        [15:0]      progrem;
        input        [7:0]       addrr;
        begin
            //准备要烧录的程序
            #20
             WD<=1'd0;
            DIN<=progrem;
            ADDR<=addrr;
            //执行烧录程序
            #20
             WD<=1'd1;

        end
    endtask

    task fine_to_progrem_ram;
        input        [7:0]       addrr;
        begin
            //准备要烧录的程序
            #20
             RD<=1'd0;
            ADDR<=addrr;
            //执行烧录程序
            #20
             RD<=1'd1;

        end
    endtask

endmodule
