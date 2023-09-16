/******************************************************************************
* 数据存储模块
*
* 模块功能描述:
* - 此模块表示一个数据存储模块，包含一个只读存储器（ROM）和读写控制逻辑。
*
* 参数:
* - 无
*
* 设计方法:
* - 使用一个 always 块，在上升沿时加载只读存储器（ROM）的数据。
* - 使用一个 always 块，在上升沿时根据控制信号（CS、DM_R）从ROM中读取数据。
* - 使用一个 always 块，在上升沿时根据控制信号（CS、DM_W）向ROM中写入数据。
*
******************************************************************************/

`timescale 1ns / 1ps

module data_mem (
    input clk,                   // 时钟信号
    input rst,                   // 复位信号
    input CS,                    // 控制信号，表示数据存储器是否可用
    input DM_W,                  // 控制信号，表示写入使能
    input DM_R,                  // 控制信号，表示读取使能
    input [31:0] addr,           // 地址信号
    input [31:0] wdata,          // 待写入数据
    output [31:0] rdata          // 读取的数据
);

    reg [31:0] ROM [255:0];     // 只读存储器（ROM）

    always @(posedge clk) begin
        if (!rst) begin
            $readmemh("E:/RTL/Single_CPU/data/data_data.txt", ROM); // 在复位时从文件加载ROM数据
        end
    end

    assign rdata = (CS & DM_R) ? ROM[addr[7:2]] : 32'b0; // 根据控制信号读取数据

    always @(posedge clk) begin
        if (CS) begin
            if (DM_W) begin
                ROM[addr[7:2]] <= wdata; // 根据控制信号写入数据
            end
        end
    end

endmodule
