`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/08 08:50:04
// Design Name: 
// Module Name: password_lock
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


module password_lock(data,clk,set_locked,btn,reset,pass,fail);
    input [7:0] data;
    input clk;
    input set_locked;
    input [3:0] btn;
    input reset;
    output pass;
    output fail;
    wire [7:0] password;
    wire btnn;
    wire dekey;
    reg [1:0] bn;
    always @(posedge clk) begin
        case (btn)
            4'b1000:bn<=2'b11;
            4'b0100:bn<=2'b10;
            4'b0010:bn<=2'b01;
            4'b0001:bn<=2'b00;
            default:bn<=2'b00;
        endcase
    end
    assign password = (set_locked==1)? data:password;
    assign btnn=btn[0]|btn[1]|btn[2]|btn[3];
    debkey w0(clk,reset,btnn,dekey);
    check_password w1(dekey,reset,password,bn,pass,fail);
endmodule
