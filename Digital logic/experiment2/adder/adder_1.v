`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 20:29:38
// Design Name: 
// Module Name: adder_1
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


module adder_4(cin,sum,cout,a,b,overflow,flag_end,symbol);  //��λ�ӷ���
    parameter n=3;
    output cout;           //��λ�ź�
    output reg [n:0] sum;     //�ӷ����
    output overflow;     //����ź�
    input [n:0] a;
    input [n:0] b;
    input cin;
    input symbol;
    reg [n+1:0] c;
    output reg flag_end=1'b0; //��������źţ�Ĭ��Ϊ0
    assign cout=c[n+1];
    assign overflow= (symbol==1)?(a[n]&b[n]&~sum[n])|(~a[n]&~b[n]&sum[n]):0;
    integer i;
    always @(*) begin
        c[0]=cin;
        flag_end=1'b0;
        for (i=0;i<=n;i=i+1) begin
            sum[i]=(a[i]^b[i])^c[i];
            c[i+1]=(a[i]&b[i])|(a[i]&c[i])|(b[i]&c[i]);
        end
        flag_end=1'b1;  //�ӷ��������
    end
    //4λ�ӷ������������a��ʾ�ڵ�һ������ܣ���b��ʾ�ڵڶ�������ܣ��������ʾ�����ұ������
    //��cout��overflow�ź������led�ź���
    
endmodule
    