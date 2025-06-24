`timescale 1ns/1ns
module tb_counter;
    
    reg         sys_clk;
    reg         sys_rst;
  // outports wire
wire   	T1;
wire   	T2;
wire   	T3;

counter u_counter(
	.sys_rst 	( sys_rst  ),
	.sys_clk 	( sys_clk  ),
	.T1      	( T1       ),
	.T2      	( T2       ),
	.T3      	( T3       )
);

    initial begin
        sys_rst=1'd0;
        sys_clk=1'd0;
        #10
         sys_rst=1'd1;
    end
    always #10 begin
        sys_clk<=~sys_clk;
    end
endmodule
