module tristimulus_8
    (
        input wire [7:0] in,       // 输入信号
        input wire enable,   // 控制信号
        output reg [7:0] out      // 输出信号，使用reg类型
    );

    // 默认输出为高阻态
    initial
        out = 8'bzzzz_zzzz;

    always @(*) begin
        if (enable) begin
            out <= in;  // 使能时传递输入信号
        end
        else begin
            out<=8'bzzzz_zzzz;
        end
    end

endmodule
// module tristimulus(
// module tristimulus(
//     inout wire [7:0] in,  // 双向数据端 A
//     inout wire [7:0] out,  // 双向数据端 B
//     input wire enable  // 控制信号
// );

//     // 双向三态门逻辑
//     assign in = enable ? 8'bzzzz_zzzz : out;  // 当 control 为低电平时，data_a 传输 data_b 的值
//     assign out = enable ? 8'bzzzz_zzzz : in;  // 当 control 为高电平时，data_b 传输 data_a 的值

// endmodule
