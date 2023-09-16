`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 15:15:54
// Design Name: 
// Module Name: mux_2to1
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

// ģ�飺�������������selectΪѡ���źţ�outΪ����ź�
module mux_2to1(
    input [1:0] d0,
    input [1:0] d1,
    input select,
    output reg [1:0] out
);

// ����߼������selectΪ1�������d1��ֵ�����selectΪ0�������d0��ֵ
always @(select or d0 or d1)
begin
    if (select)
        out = d1;
    else
        out = d0;
end

endmodule
