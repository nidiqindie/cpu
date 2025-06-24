module top(
        input  clk,
        input  rst_n,
        input PROGREM_WD,
        input PROGREM_SRAM_out_CS_D,
        input [7:0]  PROGREM_RAM_OUT_ADDR,
        input [15:0]  PROGREM_DIN,
        input DATA_RAM_out_WD,
        input DATA_RAM_SRAM_out_CS_D,
        input [7:0] DATA_RAM_OUT_DIN,
        input [7:0] DATA_RAM_OUT_ADDR,
        output  [7:0] out_to_wave
    );
    parameter       IDLE            =   3'b001                  ,
                    end_op          =   4'b1100                 ,
                    START           =   3'b010                  ,
                    P1              =   3'b100                  ,
                    P2              =   3'b010                  ,
                    P3              =   3'b001                  ,
                    move            =   4'b0010                 ,
                    cmp             =   4'b0100                 ,
                    INCC             =   4'b0101                ,
                    DECC             =   4'b0110                ,
                    JL              =   4'b0111                 ,
                    JNZ             =   4'b1000                 ,
                    out1          =   4'b1001                   ,
                    LAD            =   4'b1011                  ,
                    St             =   4'b1110                  ,
                    ot             =   4'b1111                  ,
                    the_end        =   4'b1100                  ;
    reg             [ 2:0]              state_big               ;
    //数据总线
    wire [7:0] the_data_bus;
    reg [5:0] micro_addr;

    //控制信号线，状态机控制的信号在这里
    //DATA_RAM控制，数据ram控制信号，wd表示写使能，rd表示读使能均高电平有效，cs_d片选信号低电平有效
    reg DATA_WD;
    reg DATA_RD;
    reg DATA_SRAM_CS_D;
    //pc计数器控制信号线，load表示pc自加一，ldpc表示读取总线上的数据
    reg LOAD;
    reg LDPC;
    //PROGREM_RAM控制，程序ram控制信号，rd表示允许读取高电平有效，cs_D低电平有效
    reg PROGREM_RD;
    reg PROGREM_SRAM_in_CS_D;
    //数据地址寄存器，为一表示读取总线上数据，到数据ram的地址寄存器当中，
    reg LDAR;
    //寄存器堆控制，为1表示可写入数据到指定寄存器
    reg LDPI;
    //ALU控制信号，表示指定运算
    reg add;
    reg sub;
    reg inc;
    reg dec;
    //三态门允许接通信号定义，表示什么信号可以打入数据总线当中，这些信号为1的时候表示对应信号打入数据总线
    reg ALU_B;
    reg ADDR_B;
    reg DATA_RAM_B;
    reg RG_B;
    reg DATA_IN_B;
    reg DATA_ADDR_IN_B;
    reg PROGREM_DOUT_clear;

    //
    reg PROGREM_SRAM_out_CS_D_B;
    reg PROGREM_SRAM_in_CS_D_B;

    reg PROGREM_ADDR_in_B;

    reg have_after_beat;
    reg DATA_ADDR_OUT_B;
    wire [7:0] DATA_RAM_IN_ADDR;
    reg DATA_RAM_IN_WD;
    reg PROGREM_ADDR_B;
    reg DATA_RAM_IN_CS_D;
    wire [25:0] micro_op;
    wire [25:0] 	output_micro_op;
    wire [7:0] 	alu_b;
    wire       	CF;
    wire       	AF;
    wire       	ZF;
    wire       	SF;
    wire       	OF;
    wire [7:0] 	out_R0;
    wire [7:0] 	out_R1;
    wire [7:0] 	out_R2;
    wire [7:0] 	out_R3;
    wire        	I8;
    wire        	I9;
    wire        	I10;
    wire        	I11;
    wire [3:0]  	out_op;
    wire [7:0]  	ADDR_num;
    wire PROGREM_SRAM_CS_D;
    // outports wire还需要改
    wire [15:0] 	PROGREM_DOUT;
    // wire is_coming;
    wire [7:0] 	ABUSI_in;
    wire [7:0] ABUSI;
    wire [7:0] 	DATA_DOUT;
    wire [7:0] 	ABUSD;
    wire [7:0] 	output_y;
    wire [7:0] 	output_x;
    // wire T1;
    // wire T2;
    // wire T3;


    ///////////////////////////////////////////////////////////////以下开始模块实例化
    /******************************
    ��一段 状态转移
    ******************************/
    //总体状态机
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_big <= IDLE;

        end
        else if(state_big==IDLE&&PROGREM_DIN[15:12]==end_op) begin
            state_big<= START;
        end
        else if(state_big==START&&out_op==end_op) begin
            state_big <= IDLE;
        end
    end
    //over
    tristimulus_1 u_PROGREM_RAM_out_CS_D_tristimulus_1(
                      .in     	( PROGREM_SRAM_out_CS_D  ),
                      .enable 	( PROGREM_SRAM_out_CS_D_B  ),
                      .out    	( PROGREM_SRAM_CS_D     )
                  );
    //over
    tristimulus_1 u_PROGREM_SRAM_in_CS_D_tristimulus_1(
                      .in     	( PROGREM_SRAM_in_CS_D  ),
                      .enable 	( PROGREM_SRAM_in_CS_D_B  ),
                      .out    	( PROGREM_SRAM_CS_D     )
                  );
    /******************************
       第二段 状态转移规律
    ******************************/
    always @(posedge clk or negedge rst_n)   begin
        case (state_big)
            IDLE : begin
                PROGREM_SRAM_out_CS_D_B<=1'd1;
                PROGREM_SRAM_in_CS_D_B<=1'd0;

                DATA_WD=DATA_RAM_out_WD;
                DATA_SRAM_CS_D=DATA_RAM_SRAM_out_CS_D;

                //外部访问DATARAM模块的三态门定义
                DATA_ADDR_OUT_B=1'd1;
                DATA_IN_B=1'd1;
                //内部访问DATARAM
                DATA_ADDR_IN_B=1'd0;
                PROGREM_ADDR_B=1'd1;
                PROGREM_ADDR_in_B=1'd0;
            end
            START: begin
                PROGREM_SRAM_out_CS_D_B<=1'd0;
                PROGREM_SRAM_in_CS_D_B<=1'd1;


                DATA_WD=DATA_RAM_IN_WD;
                DATA_SRAM_CS_D=DATA_RAM_IN_CS_D;

                DATA_ADDR_OUT_B=1'd0;
                DATA_IN_B=1'd0;

                DATA_ADDR_IN_B=1'd1;
                PROGREM_ADDR_B=1'd0;
                PROGREM_ADDR_in_B=1'd1;
            end
            default: begin
            end
        endcase
    end

    assign  out_to_wave=the_data_bus;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            DATA_RAM_IN_WD      <='d0;
            DATA_RD             <='d0;
            DATA_RAM_IN_CS_D    <='d1;
            LOAD                <='d0;
            LDPC                <='d0;
            PROGREM_RD          <='d0;
            PROGREM_SRAM_in_CS_D<='d1;
            LDAR                <='d0;
            LDPI                <='d0;
            add                 <='d0;
            sub                 <='d0;
            inc                 <='d0;
            dec                 <='d0;
            ALU_B               <='d0;
            ADDR_B              <='d0;
            DATA_RAM_B          <='d0;
            RG_B                <='d0;
            micro_addr          ='d0;
            have_after_beat         <='d0;
        end
        else if (state_big==START) begin
            // if(have_after_beat==0&&T1==1) begin
            DATA_RAM_IN_WD      =output_micro_op[25];
            DATA_RD             =output_micro_op[24];
            DATA_RAM_IN_CS_D    =output_micro_op[23];
            LOAD                =output_micro_op[22];
            LDPC                =output_micro_op[21];
            PROGREM_RD          =output_micro_op[20];
            PROGREM_SRAM_in_CS_D=output_micro_op[19];
            LDAR                =output_micro_op[18];
            LDPI                =output_micro_op[17];
            add                 =output_micro_op[16];
            sub                 =output_micro_op[15];
            inc                 =output_micro_op[14];
            dec                 =output_micro_op[13];
            ALU_B               =output_micro_op[12];
            ADDR_B              =output_micro_op[11];
            DATA_RAM_B          =output_micro_op[10];
            RG_B                =output_micro_op[9];
            micro_addr         =output_micro_op[5:0];
          
        end
      
        else begin
            DATA_RAM_IN_WD      <='d0;
            DATA_RD             <='d0;
            DATA_RAM_IN_CS_D    <='d1;
            LOAD                <='d0;
            LDPC                <='d0;
            PROGREM_RD          <='d0;
            PROGREM_SRAM_in_CS_D<='d1;
            LDAR                <='d0;
            LDPI                <='d0;
            add                 <='d0;
            sub                 <='d0;
            inc                 <='d0;
            dec                 <='d0;
            ALU_B               <='d0;
            ADDR_B              <='d0;
            DATA_RAM_B          <='d0;
            RG_B                <='d0;
            micro_addr          ='d0;
            have_after_beat         <='d0;
        end

    end
    p_test u_p_test(
               .clk             	( clk              ),
               .rst_n           	( rst_n            ),
               .input_micro_op  	( micro_op   ),
               .in_op           	( out_op            ),
               .CF              	( CF               ),
               .AF              	( AF               ),
               .ZF              	( ZF               ),
               .SF              	( SF               ),
               .OF              	( OF               ),
               .output_micro_op 	( output_micro_op  )
           );


    micro_Rom_wire u_micro(
                  .micro_addr   (micro_addr),
                  .micro_op     (micro_op  )
              );
    // counter counter_inst(
    //             .sys_clk(clk),
    //             .sys_rst(rst_n),
    //             .T1     (T1),
    //             .T2     (T2),
    //             .T3     (T3)
    //         );
    ALU u_ALU(
            .clk     	( clk      ),
            .rst_n   	( rst_n    ),
            .add     	( add      ),
            .sub     	( sub      ),
            .inc     	( inc      ),
            .dec        (dec       ),
            .input_x 	( output_x  ),
            .input_y 	( output_y  ),
            .alu_b   	( alu_b    ),
            .CF      	( CF       ),
            .AF      	( AF       ),
            .ZF      	( ZF       ),
            .SF      	( SF       ),
            .OF      	( OF       )
        );


    register_stack u_register_stack(
                       .clk        	( clk         ),
                       .rst_n      	( rst_n       ),
                       .LDPI       	( LDPI        ),
                       .I9         	( I9          ),
                       .I8         	( I8          ),
                       .write_data 	( the_data_bus  ),
                       .out_R0     	( out_R0      ),
                       .out_R1     	( out_R1      ),
                       .out_R2     	( out_R2      ),
                       .out_R3     	( out_R3      )
                   );
    the_mux_switch_1 u_the_mux_switch_1(
                         .I11      	( I11       ),
                         .I10      	( I10       ),
                         .input_R0 	( out_R0  ),
                         .input_R1 	( out_R1  ),
                         .input_R2 	( out_R2  ),
                         .input_R3 	( out_R3  ),
                         .output_x 	( output_x  )
                     );

    // outports wire
    //over


    the_mux_switch_2 u_the_mux_switch_2(
                         .I9       	( I9        ),
                         .I8       	( I8        ),
                         .input_R0 	( out_R0  ),
                         .input_R1 	( out_R1  ),
                         .input_R2 	( out_R2  ),
                         .input_R3 	( out_R3  ),
                         .output_y 	( output_y  )
                     );

    // outports wire
    //over

    addr_reg u_addr_reg(
                 .load_addr 	( the_data_bus  ),
                 .LDAR      	( LDAR       ),
                 .sys_clk   	( clk      ),
                 .sys_rst   	( rst_n    ),
                 .ABUSD     	( DATA_RAM_IN_ADDR      )
             );
    // outports wire
    //over

    // DATA_SRAM u_DATA_SRAM(
    //               .WD   	( DATA_WD    ),
    //               .RD   	( DATA_RD    ),
    //               .CS_D 	( DATA_SRAM_CS_D  ),
    //               .DIN  	( the_data_bus   ),
    //               .ADDR 	( ABUSD  ),
    //               .DOUT 	( DATA_DOUT  )
    //           );

DATARAM_RAM_8_256 u_DATARAM_RAM_8_256(
	.address 	( ABUSD  ),
	.clock   	( clk    ),
	.data    	( the_data_bus     ),
	.rden    	( DATA_RD     ),
	.wren    	( DATA_WD     ),
	.q       	( DATA_DOUT        )
);


 
    PC_counter u_PC_counter(
                   .sys_clk   	( clk    ),
                   .sys_rst   	( rst_n    ),
                   .load_addr 	( the_data_bus  ),
                   .LOAD      	( LOAD       ),
                   .LDPC      	( LDPC       ),
                   .ABUSI     	( ABUSI_in     )
               );
    PROGRAM_RAM u_PROGRAM_RAM(
                    .aclr    	( PROGREM_DOUT_clear     ),
                    .address 	( ABUSI  ),
                    .clock   	( clk    ),
                    .data    	( PROGREM_DIN     ),
                    .rden    	(  PROGREM_RD   ),
                    .wren    	(  PROGREM_WD     ),
                    .q       	( PROGREM_DOUT        )
                );

    IR_register u_IR_register(
                    .directives_coming 	( PROGREM_RD  ),
                    .input_directives  	( PROGREM_DOUT   ),
                    .I8                	( I8                 ),
                    .I9                	( I9                 ),
                    .I10               	( I10                ),
                    .I11               	( I11                ),
                    .out_op            	( out_op             ),
                    .ADDR_num          	( ADDR_num           )
                );




    //三个三态门设计

    ////////////////////////////////////////////////////////////////////////////////
    //over is 8
    tristimulus_8 u_ADDR_tristimulus_8(
                      .in     	( ADDR_num      ),
                      .enable 	( ADDR_B  ),
                      .out    	( the_data_bus     )
                  );


    //over is 8
    tristimulus_8 u_ALU_tristimulus_8(
                      .in     	( alu_b      ),
                      .enable 	( ALU_B  ),
                      .out    	( the_data_bus     )
                  );

    //over is 8
    tristimulus_8 u_DATA_RAM_tristimulus_8(
                      .in     	( DATA_DOUT      ),
                      .enable 	( DATA_RAM_B  ),
                      .out    	( the_data_bus     )
                  );


    //over is 8
    tristimulus_8 u_RG_tristimulus_8(
                      .in     	( output_x  ),
                      .enable 	( RG_B  ),
                      .out    	( the_data_bus     )
                  );
    //over is 8
    tristimulus_8 u_DATAIN_tristimulus_8(
                      .in     	( DATA_RAM_OUT_DIN  ),
                      .enable 	( DATA_IN_B  ),
                      .out    	( the_data_bus     )
                  );

    //over is 8
    tristimulus_8 u_DATA_RAM_OUT_ADDR_tristimulus_8(
                      .in     	( DATA_RAM_OUT_ADDR  ),
                      .enable 	( DATA_ADDR_OUT_B  ),
                      .out    	( ABUSD     )
                  );
    //over is 8
    tristimulus_8 u_DATA_ADDR_IN_tristimulus_8(
                      .in     	( DATA_RAM_IN_ADDR  ),
                      .enable 	( DATA_ADDR_IN_B  ),
                      .out    	( ABUSD     )
                  );
    //over is 8
    tristimulus_8 u_PROGREM_RAM_OUT_ADDR_tristimulus_8(
                      .in     	( PROGREM_RAM_OUT_ADDR  ),
                      .enable 	( PROGREM_ADDR_B  ),
                      .out    	( ABUSI     )
                  );
    //over is 8
    tristimulus_8 u_ABUSI_in_tristimulus_8(
                      .in     	( ABUSI_in  ),
                      .enable 	( PROGREM_ADDR_in_B  ),
                      .out    	( ABUSI     )
                  );

endmodule
