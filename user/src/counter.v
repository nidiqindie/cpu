module counter (
    sys_clk,T1,T2,T3,sys_rst
);
    input      sys_rst;
    input      sys_clk;

    output wire T1;
    output wire T2;
    output wire T3;



    reg [2:0] main_counter;
    //寄存器自增的always
    always @(posedge sys_clk or negedge sys_rst) begin
        if (!sys_rst) begin
         main_counter<=3'd0;
        end
        else if(main_counter==3'd2)begin
             main_counter<=3'd0;
        end
        else begin
               main_counter<=main_counter+3'd1;
        end
    end
    assign T1=  main_counter==3'd0;
    assign T2=  main_counter==3'd1;
    assign T3=  main_counter==3'd2;
endmodule