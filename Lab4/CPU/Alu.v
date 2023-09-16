/******************************************************************************
* Function: 算术逻辑单元（ALU）模块
*
* 模块功能描述:
* - 此模块表示一个简单的算术逻辑单元，用于执行各种算术和逻辑操作。
*
* 设计方法:
* - 使用一个 case 语句来根据指定的操作码执行相应的操作。
* - 输出运算结果和零标志。
*
******************************************************************************/

`timescale 1ns / 1ps

`define ADD     3'b000
`define SUB     3'b001
`define AND     3'b010
`define OR      3'b011
`define XOR     3'b100
`define SLT     3'b101
`define MOVZ    3'b110
`define SLL    3'b111

module alu(
    input [31:0] a,        // 输入操作数a
    input [31:0] b,        // 输入操作数b
    input [2:0]  alu_op,   // ALU操作码
	input [4:0] sa,        // 移位操作时的移位位数
    output [31:0] r,       // 运算结果
    output zero,           // 零标志，当r为零时为1
	output reg Astop       // 停机信号
);

    reg [31:0] result;     // 存储运算结果

    always @ (*) begin
        case (alu_op)
            `ADD:          // 加法操作
                result = a + b;
            `SUB:          // 减法操作
                result = a - b;
            `AND:          // 与操作
                result = a & b;
            `OR:           // 或操作
                result = a | b;
            `XOR:          // 异或操作
                result = a ^ b;
            `SLT:          // 设置小于操作
                if (a < b) result = 1;
                else result = 0;
            `MOVZ:         // 移动零操作
                if (b == 0) result = a;
                else Astop = 0; // 如果b非零，停机信号置零
            `SLL:          // 逻辑左移操作
                result = b << sa;
            default: ;     // 默认情况，不执行操作
        endcase
    end

    assign r = result;      // 输出运算结果
    assign zero = (r == 0) ? 1'b1 : 1'b0; // 判断是否为零
endmodule
