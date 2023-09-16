/******************************************************************************
* Function: 指令存储器（Instr_Mem）模块
*
* 模块功能描述:
* - 此模块表示一个指令存储器。
* - 它根据输入的地址（addr）和读使能信号（IM_R）来输出相应地址处的指令（instruction）。
* - 指令存储器在上升沿时，可以加载初始指令数据。
*
* 设计方法:
* - 使用 reg 数组 RAM 来存储指令数据，大小为 256 个 32 位指令。
* - 在上升沿时，如果复位信号（rst）为低电平，则从文件 "E:/RTL/Single_CPU/data/inst_data.txt" 读取并加载指令数据到 RAM 中。
* - 使用 assign 语句根据读使能信号（IM_R）和输入地址（addr）来选择输出指令（instruction）。
*
******************************************************************************/

`timescale 1ns / 1ps

module instr_mem(
    input clk,                  // 时钟信号
    input [31:0] addr,          // 输入的地址
    input IM_R,                 // 读使能信号
    input rst,                  // 复位信号
    output [31:0] instruction   // 输出的指令
);

    reg [31:0] RAM [255:0];     // 存储指令数据的数组，共 256 个 32 位指令

    always @ (posedge clk) begin
        if (!rst) begin
            $readmemh("E:/RTL/Single_CPU/data/inst_data.txt", RAM);
        end
    end

    assign instruction = (IM_R) ? RAM[addr[7:2]] : 32'bx;   // 根据读使能信号和地址选择输出指令

endmodule
