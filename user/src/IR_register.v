
module IR_register(
        input           directives_coming,
        input [15:0]    input_directives,
        output reg I8 ,
        output reg I9 ,
        output reg I10,
        output reg I11,
        output reg [3:0] out_op,
        output  reg [7:0] ADDR_num
    );
    reg is_coming;
    always @(*) begin
        is_coming<=directives_coming;
        ADDR_num<=   input_directives[7:0];
        I8 <= input_directives[8]  ;
        I9 <=input_directives[9]  ;
        I10<=input_directives[10];
        I11<=input_directives[11];
        out_op<=input_directives[15:12];
    end

endmodule
