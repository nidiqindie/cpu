module tristimulus_1
    (
        input wire in,       // 输入信号
        input wire enable,   // 控制信号
        output reg out      // 输出信号，使用reg类型
    );

    // 默认输出为高阻态
    initial
        out = 1'bz;

    always @(*) begin
        if (enable) begin
            out <= in;  // 使能时传递输入信号
        end
        else begin
            out<=1'bz;
        end
    end

endmodule