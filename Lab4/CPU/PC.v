/******************************************************************************
* Function: 程序计数器（PC）模块
*
* 模块功能描述:
* - 此模块表示一个简单的程序计数器。
* - 通过时钟信号（clk）驱动，根据复位信号（rst）和输入数据（data_in）来更新输出数据（data_out）。
* - 复位时将输出数据清零，否则将输入数据传递到输出数据。
*
* 设计方法:
* - 通过时钟边沿检测，以确定何时更新输出数据。
* - 当复位信号（rst）为真时，将输出数据（data_out）清零。
* - 否则，在时钟上升沿时将输入数据（data_in）传递到输出数据。
*
******************************************************************************/

`timescale 1ns / 1ps

module PC(
    input clk,      // 时钟信号
    input rst,      // 复位信号
    input [31:0] data_in,  // 输入数据
    
    output reg [31:0] data_out  // 输出数据
);

    always @ (posedge clk) begin
        if (!rst) begin
            data_out <= 32'b0;  // 复位时，清零输出数据
        end
        else begin
            data_out <= data_in;  // 否则将输入数据传递到输出数据
        end
    end

endmodule
