`timescale 1ns / 1ps

module regfile(
    input       clk,        // 时钟输入
    input       wen,        // 写使能信号
    input   [4:0] raddr1,  // 读地址1
    input   [4:0] raddr2,  // 读地址2
    input   [4:0] waddr,   // 写地址
    input   [31:0] wdata,  // 写数据
    output reg [31:0] rdata1, // 读数据1
    output reg [31:0] rdata2  // 读数据2
    );
    
    integer i = 0;
    reg [31:0] REG_Files[31:0]; // 寄存器堆，共有32个32位寄存器

    // 初始化寄存器堆，将所有寄存器的值初始化为0
    initial begin
        for (i = 0; i < 32; i = i + 1)
            REG_Files[i] <= 0;
    end
        
    // 在上升沿时，如果写使能信号为1，则将写数据写入指定地址的寄存器
    always @ (posedge clk) begin
        if (wen == 1)
            REG_Files[waddr] <= wdata;
    end
            
    // 始终监视读地址，将对应寄存器的值赋给读数据输出
    always @ (*) begin
        rdata1 = REG_Files[raddr1];
        rdata2 = REG_Files[raddr2];
    end
endmodule
