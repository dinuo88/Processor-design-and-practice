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

// 模组：输入端有三个，select为选择信号，out为输出信号
module mux_2to1(
    input [1:0] d0,
    input [1:0] d1,
    input select,
    output reg [1:0] out
);

// 组合逻辑，如果select为1，则输出d1的值；如果select为0，则输出d0的值
always @(select or d0 or d1)
begin
    if (select)
        out = d1;
    else
        out = d0;
end

endmodule
