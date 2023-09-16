/******************************************************************************
* Function: 多路选择器（Mux）模块
*
* 模块功能描述:
* - 此模块表示一个多路选择器，根据选择信号选择一个输入作为输出。
*
* 参数:
* - WIDTH: 输入宽度，默认为32位。
*
* 设计方法:
* - 使用一个 always 块，根据选择信号来选择输入a或输入b，并将结果输出到r。
*
******************************************************************************/

`timescale 1ns / 1ps

module mux #(parameter WIDTH = 32) (
    input [WIDTH - 1: 0] a,      // 输入a
    input [WIDTH - 1: 0] b,      // 输入b
    input select,                // 选择信号
    output reg [WIDTH - 1: 0] r  // 输出结果
);

    always @(*) begin
        if (select) begin
            r = a;                 // 当选择信号为1时，选择输入a
        end
        else begin
            r = b;                 // 当选择信号为0时，选择输入b
        end
    end

endmodule
