`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 15:05:13
// Design Name: 
// Module Name: testbench_pulse_generator
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


`timescale 1ns / 1ps 

module testbench_pulse_generator;
    
    reg clk;        // 输入时钟信号
    reg rst;        // 输入复位信号
    wire [3:0] T;   // 输出脉冲生成器的输出信号

    // 实例化脉冲生成器模块
    pulse_generator pg (
        .clk(clk),
        .rst(rst),
        .T(T)
    );
    
    
    initial begin
        clk = 0;                // 初始化时钟信号为低电平
        forever #5 clk = ~clk;  // 以5ns为间隔翻转时钟信号
    end

    
    initial begin
        $dumpfile("pulse_generator.vcd");          //生成仿真波形文件
        $dumpvars(0, testbench_pulse_generator);     // 保存当前模块变量值

        rst = 1;        //激活复位信号
        #10;            // 等待10ns
        rst = 0;        // 取消复位信号

        
        #100;           // 继续仿真100ns

        $finish;        //结束仿真
    end

endmodule

