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
    input wire clk,         // ����ʱ���ź�
    input wire rst,         // ���븴λ�ź�
    output reg [3:0] T     // �������������������ź�
);


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            T <= 4'b1000;               // �����λ�źż�����������Ϊ��ʼֵ1000
        end else begin
            T <= {T[0], T[3:1]};        // ��clk�����ص���ʱ��������һ��״̬
        end
    end
endmodule


