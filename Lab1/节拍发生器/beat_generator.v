`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 14:54:27
// Design Name: 
// Module Name: beat_generator
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


module pulse_generator(
    input wire clk,         // 输入时钟信号
    input wire rst,         // 输入复位信号
    output reg [3:0] T     // 输出脉冲生成器的输出信号
);


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            T <= 4'b1000;               // 如果复位信号激活，则将输出设置为初始值1000
        end else begin
            T <= {T[0], T[3:1]};        // 在clk上升沿到来时，生成下一个状态
        end
    end
endmodule


