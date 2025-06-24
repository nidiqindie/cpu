module ALU(
        input               clk    ,
        input               rst_n  ,
        input               add,
        input               sub,
        input               inc,
        input               dec,
        input [7:0]         input_x,
        input [7:0]         input_y,
        output reg [7:0]    alu_b,
        output reg          CF,
        output reg          AF,
        output reg          ZF,
        output reg          SF,
        output reg          OF
    );
    reg [8:0] temp; // 用于存储中间结果，防止溢出
    reg [8:0] temp_a, temp_b;
    //运算
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            alu_b<=8'd0;
            CF<=1'd0;
            AF<=1'd0;
            ZF<=1'd0;
            SF<=1'd0;
            OF<=1'd0;
        end
        else if(add==1) begin
            // 执行加法操作

            temp = {input_x[7], input_x} + {input_y[7], input_y};
            alu_b = temp[7:0]; // 只取低8位作为结果
            CF = (temp[8] != temp[7]); // 如果最高位为1，则CF为1
            OF = CF;
            ZF = (alu_b == 8'd0); // 如果结果为0，则ZF为1
            SF = alu_b[7] ; // 如果最高位为1，则SF为1
            AF = OF; // AF在这里没有使用，可以忽略或根据需要定义
        end

        else if(sub==1) begin


            // 扩展输入到16位，包括双符号位
            temp_a = {input_x[7], input_x}; //
            temp_b = {~input_y[7], ~input_y} + 1'b1;// 将input_y取反并加1，实现二进制的减法转加法
            // 进行加法运算（实际上是减法）
            temp = temp_a + temp_b;
            alu_b = temp[7:0]; // 只保留低8位作为结果
            CF = (temp[8] != temp[7]); // 如果最高位为1，则CF为1
            OF = CF;
            ZF = (alu_b == 8'd0); // 如果结果为0，则ZF为1
            SF = alu_b[7] ; // 如果最高位为1，则SF为1
            AF = OF; // AF在这里没有使用，可以忽略或根据需要定义
        end
        else if(inc==1) begin
            temp = {input_x[7], input_x} +1'd1;
            alu_b = temp[7:0]; // 只保留低8位作为结果
            CF = (temp[8] != temp[7]); // 如果最高位为1，则CF为1
            OF = CF;
            ZF = (alu_b == 8'd0); // 如果结果为0，则ZF为1
            SF = alu_b[7] ; // 如果最高位为1，则SF为1
            AF = OF; // AF在这里没有使用，可以忽略或根据需要定义
        end
         else if(dec==1) begin
            temp = {input_x[7], input_x} -1'd1;
            alu_b = temp[7:0]; // 只保留低8位作为结果
            CF = (temp[8] != temp[7]); // 如果最高位为1，则CF为1
            OF = CF;
            ZF = (alu_b == 8'd0); // 如果结果为0，则ZF为1
            SF = alu_b[7] ; // 如果最高位为1，则SF为1
            AF = OF; // AF在这里没有使用，可以忽略或根据需要定义
        end
        else begin
            alu_b <=alu_b ;
            CF    <=    CF;
            AF<=    AF;
            ZF<=    ZF;
            SF<=    SF;
            OF<=    OF;
        end
    end

endmodule

