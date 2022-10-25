`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 07:53:10
// Design Name: 
// Module Name: display
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


module display_32_7se
    (input clk,input en,input [31:0]data,
    output [3:0] sw_wei,output [6:0] sw_duan);
    parameter FREQ = 10**5/2;  //FREQ控制数码管频率，为1/FREQ Hz
    parameter INTERVAL = 10**8; //INTERVAL控制高低16位之间变化的间隔，默认为1s
    reg[1:0] sel[0:1];
    integer clk_cnt = 0;
    reg clk_500hz = 0;
    reg flgupper = 1'b0;
    
    initial
    begin
        sel[0]=2'b00;
        sel[1]=2'b00;
    end
    //分频
    always@(posedge  clk) begin 
        if(en) begin
            if(clk_cnt==32'd100000)
            begin
                clk_cnt <= 1'b0;
                clk_500hz = ~clk_500hz;
            end
            else begin
                clk_cnt <= clk_cnt+1'b1;
            end
        end else 
            clk_cnt <= 0;
    end
    
    //控制显示高位还是低位
    integer counter2 = 0;
    always @(posedge clk) begin
        if (en) begin
            if (counter2 == INTERVAL) begin
                flgupper <= ~flgupper;//是否高位
                counter2<=0;
            end else
                counter2 <= counter2 + 1;
        end else
            counter2<=0;
    end
     
    always@(posedge clk_500hz) begin
        if(en) begin
        if(sel[flgupper] == 3)
            sel[flgupper] <= 0;
        else
            sel[flgupper] <= sel[flgupper] + 1;
        end
    end

//位控制
    reg[3:0]wei_ctrl = 4'b0;
    always@(posedge clk)begin
        case(sel[flgupper])
            0: wei_ctrl <= 4'b1110;
            1: wei_ctrl <= 4'b1101;
            2: wei_ctrl <= 4'b1011;
            3: wei_ctrl <= 4'b0111;
            default: wei_ctrl <= 4'b0;
        endcase
    end
    
    //段控制
    reg [3:0] duan_ctrl;
    always@(wei_ctrl)
    begin
        if(flgupper == 0)begin
            case(wei_ctrl)
                4'b1110:duan_ctrl=data[3:0];
                4'b1101:duan_ctrl=data[7:4];
                4'b1011:duan_ctrl=data[11:8]; 
                4'b0111:duan_ctrl=data[15:12]; 
                default:duan_ctrl=4'hf; 
            endcase
        end
        else if(flgupper == 1)begin
            case(wei_ctrl)
                4'b1110:duan_ctrl=data[19:16];
                4'b1101:duan_ctrl=data[23:20];
                4'b1011:duan_ctrl=data[27:24]; 
                4'b0111:duan_ctrl=data[31:28]; 
                default:duan_ctrl=4'hf; 
            endcase
        end
    end
    
    //解码
    reg [6:0]duan;
    always @(duan_ctrl)
    begin
        case(duan_ctrl)
            4'h0:duan=7'b0000001;//0 
            4'h1:duan=7'b1001111;//1 
            4'h2:duan=7'b0010010;//2 
            4'h3:duan=7'b0000110;//3 
            4'h4:duan=7'b1001100;//4 
            4'h5:duan=7'b0100100;//5 
            4'h6:duan=7'b0100000;//6 
            4'h7:duan=7'b0001111;//7 
            4'h8:duan=7'b0000000;//8 
            4'h9:duan=7'b0000100;//9
            4'ha:duan=7'b0001000;//a 
            4'hb:duan=7'b1100000;//b 
            4'hc:duan=7'b0110001;//c 
            4'hd:duan=7'b1000010;//d 
            4'he:duan=7'b0110000;//e 
            4'hf:duan=7'b0111000;//f
            default : duan = 7'b0000001;//0 
        endcase
    end
    assign sw_wei = wei_ctrl;
    assign sw_duan = duan;
endmodule
