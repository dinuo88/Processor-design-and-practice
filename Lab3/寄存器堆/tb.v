`timescale 1ns / 1ps

module tb;

    reg clk;               // 时钟信号
    reg wen;               // 写使能信号
    reg [4:0] raddr1;      // 读地址1
    reg [4:0] raddr2;      // 读地址2
    reg [4:0] waddr;       // 写地址
    reg [31:0] wdata;      // 写数据
    reg [4:0] test_addr;   // 测试地址

    wire [31:0] rdata1;    // 读数据1
    wire [31:0] rdata2;    // 读数据2
    wire [31:0] test_data; // 测试数据

    regfile uut(
        .clk(clk),
        .wen(wen),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .waddr(waddr),
        .wdata(wdata),
        .test_addr(test_addr),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .test_data(test_data)
    );

    // 时钟生成，每5个时间单位翻转一次
    always begin
        #5 clk = ~clk;
    end

    // 初始化信号
    initial begin
        clk = 0;
        wen = 0;
        raddr1 = 0;
        raddr2 = 0;
        waddr = 0;
        wdata = 0;
        test_addr = 0;

        #100; // 等待一段时间

        // 写入数据到地址5
        waddr = 5'h05;
        wdata = 32'h3F;

        #400; // 等待一段时间

        wen = 1'b1; // 写使能置1

        raddr1 = 5'h05; // 读取地址5
        raddr2 = 5'h05; // 读取地址5
        test_addr = 5'h05; // 测试地址5

        #100; // 等待一段时间

        // 显示读取的数据
        $display("rdata1: %h", rdata1);
        $display("rdata2: %h", rdata2);
        $display("test_data: %h", test_data);

        $finish; // 结束仿真
    end
endmodule
