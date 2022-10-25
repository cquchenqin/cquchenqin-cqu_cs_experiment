`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 15:08:13
// Design Name: 
// Module Name: seg_7
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

//七段数码管控制模块,此时需要显示的数据为a,b,sum
module seg_7(clk,a,b,sum,flag_end,segs,AN,symbol);
    parameter n=3;
    input clk;
    input [n:0] a;
    input [n:0] b;
    input [n:0] sum;
    input flag_end;
    output reg[7:0] segs=8'b0000_0010;
    output reg[3:0] AN=4'b0111;
    input symbol;
    always@(posedge clk) begin //段控制
            if (AN==4'b0111) begin
            AN=4'b1011; end
            else if (AN==4'b1011) begin
            AN=4'b1110;  end
            else if (AN==4'b1110) begin
            AN=4'b0111;   end
    end
    always@(*)  begin     //位控制
        if (flag_end) begin
            if (symbol==1) begin  //有符号数
                if (AN==4'b0111) begin
                case(a[n:0])
                4'h0:segs=8'b0000_0011;
                4'h1:segs=8'b1001_1111;
                4'h2:segs=8'b0010_0101;
                4'h3:segs=8'b0000_1101;
                4'h4:segs=8'b1001_1001;
                4'h5:segs=8'b0100_1001;
                4'h6:segs=8'b0100_0001;
                4'h7:segs=8'b0001_1111;
                4'h8:segs=8'b0000_0000;
                4'h9:segs=8'b0001_1110;
                4'hA:segs=8'b0100_0000;
                4'hB:segs=8'b0100_1000;
                4'hC:segs=8'b1001_1000;
                4'hD:segs=8'b0000_1100;
                4'hE:segs=8'b0010_0100;
                4'hF:segs=8'b1001_1110;
                default:segs=8'b1111_11111;
                endcase
                end
            else if (AN==4'b1011) begin
            case(b[n:0])
            4'h0:segs=8'b0000_0011;
            4'h1:segs=8'b1001_1111;
            4'h2:segs=8'b0010_0101;
            4'h3:segs=8'b0000_1101;
            4'h4:segs=8'b1001_1001;
            4'h5:segs=8'b0100_1001;
            4'h6:segs=8'b0100_0001;
            4'h7:segs=8'b0001_1111;
            4'h8:segs=8'b0000_0000;
            4'h9:segs=8'b0001_1110;
            4'hA:segs=8'b0100_0000;
            4'hB:segs=8'b0100_1000;
            4'hC:segs=8'b1001_1000;
            4'hD:segs=8'b0000_1100;
            4'hE:segs=8'b0010_0100;
            4'hF:segs=8'b1001_1110;
            default:segs=8'b1111_11111;
            endcase           
            end
            else if (AN==4'b1110) begin
            case(sum[n:0])
            4'h0:segs=8'b0000_0011;
            4'h1:segs=8'b1001_1111;
            4'h2:segs=8'b0010_0101;
            4'h3:segs=8'b0000_1101;
            4'h4:segs=8'b1001_1001;
            4'h5:segs=8'b0100_1001;
            4'h6:segs=8'b0100_0001;
            4'h7:segs=8'b0001_1111;
            4'h8:segs=8'b0000_0000;
            4'h9:segs=8'b0001_1110;
            4'hA:segs=8'b0100_0000;
            4'hB:segs=8'b0100_1000;
            4'hC:segs=8'b1001_1000;
            4'hD:segs=8'b0000_1100;
            4'hE:segs=8'b0010_0100;
            4'hF:segs=8'b1001_1110;
            default: segs=8'b1111_1111;
            endcase
            end
        end
        else if (symbol==0) begin
            if (AN==4'b0111) begin
            case(a[n:0])
            4'h0:segs=8'b0000_0011;
            4'h1:segs=8'b1001_1111;
            4'h2:segs=8'b0010_0101;
            4'h3:segs=8'b0000_1101;
            4'h4:segs=8'b1001_1001;
            4'h5:segs=8'b0100_1001;
            4'h6:segs=8'b0100_0001;
            4'h7:segs=8'b0001_1111;
            4'h8:segs=8'b0000_0001;
            4'h9:segs=8'b0000_1001;
            4'hA:segs=8'b0001_0001;
            4'hB:segs=8'b1100_0001;
            4'hC:segs=8'b0110_0011;
            4'hD:segs=8'b1000_0101;
            4'hE:segs=8'b0110_0001;
            4'hF:segs=8'b0111_0001;
            default:segs=8'b1111_1111;
            endcase
            end
            else if (AN==4'b1011) begin
            case(b[n:0])
            4'h0:segs=8'b0000_0011;
            4'h1:segs=8'b1001_1111;
            4'h2:segs=8'b0010_0101;
            4'h3:segs=8'b0000_1101;
            4'h4:segs=8'b1001_1001;
            4'h5:segs=8'b0100_1001;
            4'h6:segs=8'b0100_0001;
            4'h7:segs=8'b0001_1111;
            4'h8:segs=8'b0000_0001;
            4'h9:segs=8'b0000_1001;
            4'hA:segs=8'b0001_0001;
            4'hB:segs=8'b1100_0001;
            4'hC:segs=8'b0110_0011;
            4'hD:segs=8'b1000_0101;
            4'hE:segs=8'b0110_0001;
            4'hF:segs=8'b0111_0001;
            default:segs=8'b1111_1111;
            endcase           
            end
            else if (AN==4'b1110) begin
            case(sum[n:0])
            4'h0:segs=8'b0000_0011;
            4'h1:segs=8'b1001_1111;
            4'h2:segs=8'b0010_0101;
            4'h3:segs=8'b0000_1101;
            4'h4:segs=8'b1001_1001;
            4'h5:segs=8'b0100_1001;
            4'h6:segs=8'b0100_0001;
            4'h7:segs=8'b0001_1111;
            4'h8:segs=8'b0000_0001;
            4'h9:segs=8'b0000_1001;
            4'hA:segs=8'b0001_0001;
            4'hB:segs=8'b1100_0001;
            4'hC:segs=8'b0110_0011;
            4'hD:segs=8'b1000_0101;
            4'hE:segs=8'b0110_0001;
            4'hF:segs=8'b0111_0001;
            default:segs=8'b1111_1111;
            endcase
            end
        end
    end        
end     
endmodule
