`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 07:51:27
// Design Name: 
// Module Name: adder_32
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

module adder_1(input a, input b, input c,output sum, output carry);
    assign sum = a^b^c;
    assign carry = ((a|b)&c)|(a&b);
endmodule

module adder_32(input [31:0] a, input [31:0] b,input c,input control,output [31:0] sum,output carry,output over);
    wire [31:0] temp;
    adder_1 add1(a[0],b[0],c,sum[0],temp[0]);
    adder_1 add2(a[1],b[1],temp[0],sum[1],temp[1]);
    adder_1 add3(a[2],b[2],temp[1],sum[2],temp[2]);
    adder_1 add4(a[3],b[3],temp[2],sum[3],temp[3]);
    adder_1 add5(a[4],b[4],temp[3],sum[4],temp[4]);
    adder_1 add6(a[5],b[5],temp[4],sum[5],temp[5]);
    adder_1 add7(a[6],b[6],temp[5],sum[6],temp[6]);
    adder_1 add8(a[7],b[7],temp[6],sum[7],temp[7]);
    adder_1 add9(a[8],b[8],temp[7],sum[8],temp[8]);
    adder_1 add10(a[9],b[9],temp[8],sum[9],temp[9]);
    adder_1 add11(a[10],b[10],temp[9],sum[10],temp[10]);
    adder_1 add12(a[11],b[11],temp[10],sum[11],temp[11]);
    adder_1 add13(a[12],b[12],temp[11],sum[12],temp[12]);
    adder_1 add14(a[13],b[13],temp[12],sum[13],temp[13]);
    adder_1 add15(a[14],b[14],temp[13],sum[14],temp[14]);
    adder_1 add16(a[15],b[15],temp[14],sum[15],temp[15]);
    adder_1 add17(a[16],b[16],temp[15],sum[16],temp[16]);
    adder_1 add18(a[17],b[17],temp[16],sum[17],temp[17]);
    adder_1 add19(a[18],b[18],temp[17],sum[18],temp[18]);
    adder_1 add20(a[19],b[19],temp[18],sum[19],temp[19]);
    adder_1 add21(a[20],b[20],temp[19],sum[20],temp[20]);
    adder_1 add22(a[21],b[21],temp[20],sum[21],temp[21]);
    adder_1 add23(a[22],b[22],temp[21],sum[22],temp[22]);
    adder_1 add24(a[23],b[23],temp[22],sum[23],temp[23]);
    adder_1 add25(a[24],b[24],temp[23],sum[24],temp[24]);
    adder_1 add26(a[25],b[25],temp[24],sum[25],temp[25]);
    adder_1 add27(a[26],b[26],temp[25],sum[26],temp[26]);
    adder_1 add28(a[27],b[27],temp[26],sum[27],temp[27]);
    adder_1 add29(a[28],b[28],temp[27],sum[28],temp[28]);
    adder_1 add30(a[29],b[29],temp[28],sum[29],temp[29]);
    adder_1 add31(a[30],b[30],temp[29],sum[30],temp[30]);
    adder_1 add32(a[31],b[31],temp[30],sum[31],temp[31]);
    assign carry = temp[31]&~control;
    assign over = temp[31]^temp[30];//temp[30]    ?   ¦Ë ? ¦Ë  temp[31] ?   ¦Ë ? ¦Ë
endmodule
