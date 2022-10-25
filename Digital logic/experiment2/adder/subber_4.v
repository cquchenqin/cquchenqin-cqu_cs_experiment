`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/16 10:00:32
// Design Name: 
// Module Name: subber_4
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

//4λ������
module subber_4(cin,minus,cout,a,b,overflow,flag_end,symbol);
    parameter n=3;
    output cout;            //��λ�ź�
    output [n:0] minus;   //�������
    output overflow;       //����ź�
    input [n:0] a;
    input [n:0] b;
    input cin;
    output  flag_end;
    integer i;
    reg [n:0] c;
    wire [n:0] d;
    input symbol;
    always @(*) begin
        for (i=0;i<=n;i=i+1) begin
            c[i]=~b[i];
        end
    end
    assign d=c+4'b0001;
    adder_4 t1(cin,minus,cout,a,d,overflow,flag_end,symbol);
endmodule
