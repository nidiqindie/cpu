module the_mux_switch_1(
        I11,I10,
        input_R0,
        input_R1,
        input_R2,
        input_R3,
        output_x,

    );
    input wire       I11;
    input wire       I10;
    input wire [7:0] input_R0;
    input wire [7:0] input_R1;
    input wire [7:0] input_R2;
    input wire [7:0] input_R3;

    output reg [7:0] output_x;
    reg [1:0] temp;
    always @(*) begin
        temp[0]=I10;
        temp[1]=I11;
        case (temp)
            2'd0:
                output_x=input_R0;
            2'd1:
                output_x=input_R1;
            2'd2:
                output_x=input_R2;
            2'd3:
                output_x=input_R3;
            default:
                output_x=8'd0;
        endcase
    end





endmodule
