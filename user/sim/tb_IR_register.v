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
// Last modified Date:     2024/07/10 18:10:24
// Last Version:           V1.0
// Descriptions:
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name
// Created date:           2024/07/10 18:10:24
// mail      :             Please Write mail
// Version:                V1.0
// TEXT NAME:              tb_IR_register.v
// PATH:                   C:\Users\a1321\Desktop\fpga_project\cpu\user\sim\tb_IR_register.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module tb_IR_register(
	input a,
	output b
                         );
    reg WD  ;
    reg RD  ;
    reg CS_D;


    reg [15:0] DIN ;
    reg [7:0] ADDR;

    reg         clk  ;
    reg         rst_n;

        // outports wire
        wire        	I8;
    wire        	I9;
    wire        	I10;
    wire        	I11;
    wire [3:0]  	out_op;
    wire [7:0]  	ADDR_num;


    wire [15:0] 	DOUT;
    wire        	is_coming;

    IR_register u_IR_register(
                    .clk               	( clk                ),
                    .rst_n             	( rst_n              ),
                    .directives_coming 	( is_coming  ),
                    .input_directives  	( DOUT   ),
                    .I8                	( I8                 ),
                    .I9                	( I9                 ),
                    .I10               	( I10                ),
                    .I11               	( I11                ),
                    .out_op            	( out_op             ),
                    .ADDR_num          	( ADDR_num           )
                );
    // outports wire

    PROGREM_SRAM u_PROGREM_SRAM(
                     .clk       	( clk        ),
                     .WD        	( WD         ),
                     .RD        	( RD         ),
                     .CS_D      	( CS_D       ),
                     .DIN       	( DIN        ),
                     .ADDR      	( ADDR       ),
                     .DOUT      	( DOUT       ),
                     .is_coming 	( is_coming  )
                 );
    initial begin
        rst_n<=1'd0;
        clk<=1'd0;
        WD<=1'd0;
        RD<=1'd0;
        //默认片选
        CS_D<=1'd0;
        #10
         rst_n<=1'd1;
        burn_to_progrem_ram(16'b0010_00_01_0000_0000,8'd0);
        burn_to_progrem_ram(16'b1001_01_00_0000_0000,8'd1);
        burn_to_progrem_ram(16'b1100_00_00_0000_0000,8'd2);
        #20
         WD<=1'd0;
        fine_to_progrem_ram(8'd0);
        fine_to_progrem_ram(8'd1);
        fine_to_progrem_ram(8'd2);

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
            #20
             WD<=1'd0;
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
            #20
             RD<=1'd0;
        end
    endtask
endmodule
