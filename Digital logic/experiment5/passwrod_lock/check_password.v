`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/08 08:56:50
// Design Name: 
// Module Name: check_password
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

//Moore有限状态机
module check_password(clk,reset,password,bn,pass,fail);
    input clk;
    input reset;
    input [7:0] password;  //正确的密码
    input [1:0] bn;    //每次输入的密码
    output reg pass;   //成功
    output reg fail;   //失败
    reg [3:0] currentstate;
    reg [3:0] nextstate;
    parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=44'b0100;
    parameter e1=4'b0101,e2=4'b0110,e3=4'b0111,e4=4'b1000;
    always @(posedge clk or negedge reset) begin
        if (!reset)
            currentstate<=s0;
        else
            currentstate<=nextstate;
    end
    always @(*) begin
        if (!reset) begin
            nextstate<=s0;
        end
        else begin
            case (currentstate)
            s0: begin
                if (bn==password[7:6])
                    nextstate<=s1;
                else
                    nextstate<=e1;
            end
            s1: begin
                if (bn==password[5:4])
                    nextstate<=s2;
                else
                    nextstate<=e2;
            end
            s2: begin
                if (bn==password[3:2])
                    nextstate<=s3;
                else
                    nextstate<=e3;
            end
            s3: begin
                if (bn==password[1:0])
                    nextstate<=s4;
                 else
                    nextstate<=e4;
            end
            s4: begin
                if (bn==password[7:6])
                    nextstate<=s1;
                 else
                    nextstate<=e1;
            end
            e1: begin
                nextstate<=e2;
            end
            e2: begin
                nextstate<=e3;
            end
            e3: begin
                nextstate<=e4;
            end
            e4: begin
                if (bn==password[7:6])
                    nextstate<=s1;
                else 
                    nextstate<=e1;
            end
            default:nextstate<=s0;
            endcase
        end
    end
    //输出模块，在s4状态则pass=1，在e4则fail=1；
    always @(*) begin
        if (currentstate==s4)
            pass<=1;
        else if (currentstate==e4)
            fail<=1;
        else begin
            pass<=0;
            fail<=0;
        end
    end
endmodule
