`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 15:16:59
// Design Name: 
// Module Name: testbench_mux_2to1
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

module testbench_mux_2to1;
    reg [1:0] d0;     // 输入
    reg [1:0] d1;     // 输入
    reg select;       // 选择信号
    wire [1:0] out;   // 输出信号

   // 例化
    mux_2to1 my_mux (
        .d0(d0),
        .d1(d1),
        .select(select),
        .out(out)
    );

   
    initial begin
        d0 = 2'b00;            // 输入d0为2位二进制数00
        d1 = 2'b11;            // 输入d1为2位二进制数11
        select = 1'b0;         // 输入select为1位二进制数0

        #10;            // 等待10ns

        $finish;        // 结束仿真
    end

   
    always begin
        #5 select = ~select; // 每 5 个时间单位切换一次选择信号
    end

endmodule   
