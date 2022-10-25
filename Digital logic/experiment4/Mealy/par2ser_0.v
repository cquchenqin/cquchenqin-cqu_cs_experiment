`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/05 15:29:38
// Design Name: 
// Module Name: par2ser_0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module par2ser_0 (input [7:0]register,input clk,input set,output reg [7:0]out_8);
    reg ou; //ouΪ0ʱ�Ǽ�����е�һλ�������registerֱ�Ӷ����out_8��ֵ������ouΪ1ʱ������к�λ��������Ƕ�out_8���Ʋ���
    always @ (posedge clk)
    begin
        if((ou != 1)&&set == 1)//������е�һλ
        begin
            out_8 <= register;
            ou <= 1;
        end
        else if(set == 0)//set�ر�ʱou�ص�0
        begin
            ou <= 0;
        end
        else if(ou == 1) //������к�λ
        begin
            out_8 <= (out_8>>1);
            out_8[7] <= 1'b0;
        end
    end
endmodule
