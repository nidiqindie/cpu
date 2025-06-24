module the_mux_switch_2(
        I9,I8,input_R0,
        input_R1,
        input_R2,
        input_R3,
        output_y,

    );

    input wire I9;
    input wire I8;
    input wire [7:0] input_R0;
    input wire [7:0] input_R1;
    input wire [7:0] input_R2;
    input wire [7:0] input_R3;

    output reg [7:0] output_y;
    reg [1:0] temp;
    always @(*) begin

        temp[0]=I8;
        temp[1]=I9;
        case (temp)
            2'd0:
                output_y=input_R0;
            2'd1:
                output_y=input_R1;
            2'd2:
                output_y=input_R2;
            2'd3:
                output_y=input_R3;
            default:
                output_y=8'd0;
        endcase
    end





endmodule
