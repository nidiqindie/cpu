
`timescale 1ns/1ns
module tb_the_mux_switch_1;
reg       sys_clk;
reg       sys_rst;
reg       I11;
reg       I10;
reg  [7:0] input_R0;
reg [7:0] input_R1;
reg [7:0] input_R2;
reg [7:0] input_R3;
wire [7:0] output_x;
// outports wire


the_mux_switch_1 u_the_mux_switch_1(
	.sys_clk  	( sys_clk   ),
	.sys_rst  	( sys_rst   ),
	.I11      	( I11       ),
	.I10      	( I10       ),
	.input_R0 	( input_R0  ),
	.input_R1 	( input_R1  ),
	.input_R2 	( input_R2  ),
	.input_R3 	( input_R3  ),
	.output_x 	( output_x  )
);

initial begin
    sys_rst<=1'd0;
    sys_clk<=1'd0;
    input_R0<=8'b0001_0000;
    input_R1<=8'b0001_0001;
    input_R2<=8'b0001_0010;
    input_R3<=8'b0001_0011;
    I10<=1'd0;
    I11<=1'd0;
    #10
    sys_rst<=1'd1;
    #100
     I10<=1'd1;
    I11<=1'd0;
    #100
    I10<=1'd0;
    I11<=1'd1;

    #100
    I10<=1'd1;
    I11<=1'd1;

  
end
always #10 begin
    sys_clk<=~sys_clk;
end
endmodule