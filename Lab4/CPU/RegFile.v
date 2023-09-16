/******************************************************************************
* Function: 寄存器文件（Register File）模块
*
* 模块功能描述:
* - 此模块表示一个简单的寄存器文件，用于存储 CPU 中的寄存器数据。
* - 支持寄存器读取和写入操作。
*
* 设计方法:
* - 使用一个 reg 数组来存储寄存器数据。
* - 在时钟上升沿处理写入操作，将数据写入指定寄存器。
* - 在时钟上升沿处理读取操作，将寄存器数据输出。
*
******************************************************************************/

`timescale 1ns / 1ps

module regfile(
    input clk,               // 时钟信号
    input rst,               // 复位信号
    input rf_w,              // 寄存器写使能信号
    input [4:0] raddr1,      // 读取寄存器的地址1
    input [4:0] raddr2,      // 读取寄存器的地址2
    input [4:0] waddr,       // 写入寄存器的地址
    input [31:0] wdata,      // 写入寄存器的数据
    output [31:0] rdata1,    // 读取的寄存器数据1
    output [31:0] rdata2     // 读取的寄存器数据2
);

    reg [31:0] array_reg[31:0]; // 寄存器文件数组，存储32个寄存器的数据

    integer i;

    always @ (posedge clk) begin
        if (!rst) begin
            i = 0;
            while (i < 32) begin
                array_reg[i] = 32'b0; // 复位时将所有寄存器清零
                i = i + 1;
            end
        end
        if (rf_w) begin
            if (waddr != 0)
                array_reg[waddr] = wdata; // 在写使能信号为真且写地址不为0时，将数据写入指定寄存器
        end
    end

    assign rdata1 = array_reg[raddr1]; // 输出读取的寄存器数据1
    assign rdata2 = array_reg[raddr2]; // 输出读取的寄存器数据2

endmodule
