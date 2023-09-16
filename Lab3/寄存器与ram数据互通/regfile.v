`timescale 1ns / 1ps

// 定义一个名为 regfile 的 Verilog 模块
module regfile(
    input clk,               // 时钟信号
    input [5:1] raddr1,      // 读端口1的寄存器地址
    output reg [32:1] rdata1, // 读端口1的数据输出
    input [5:1] raddr2,      // 读端口2的寄存器地址
    output reg [32:1] rdata2, // 读端口2的数据输出
    input we,                // 写使能信号，用于控制写操作
    input [5:1] waddr,       // 写入寄存器的地址
    input [32:1] wdata       // 写入寄存器的数据
);

    reg [32:1] regf[31:0]; // 定义一个包含32个32位寄存器的数组

    always @(posedge clk) begin
        // 在每个上升沿时，执行以下操作
        if (we) begin
            regf[waddr] <= wdata; // 如果写使能信号为1，则将数据写入指定寄存器地址
        end
    end

    always @(posedge clk) begin
        // 在每个上升沿时，执行以下操作
        rdata1 <= regf[raddr1]; // 将读端口1的数据设置为指定寄存器地址的数据
        rdata2 <= regf[raddr2]; // 将读端口2的数据设置为指定寄存器地址的数据
    end

endmodule
