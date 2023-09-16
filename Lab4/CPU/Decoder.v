/******************************************************************************
* Function: 指令解码器（Decoder）模块
*
* 模块功能描述:
* - 此模块表示一个指令解码器，根据输入的指令（instruction）进行解码，输出控制信号。
* - 输出的控制信号用于控制 CPU 执行不同的操作。
*
* 设计方法:
* - 使用多个 wire 来解码指令，生成不同的控制信号。
* - 使用 assign 语句将指令解码结果与控制信号相连。
*
******************************************************************************/

`timescale 1ns / 1ps

module Decoder(
    input [31:0] instruction,   // 输入的指令
    input clk,                  // 时钟信号
    input zero,                 // 零标志位
	input Dstop,                // 停止信号
    input [31:0] rs_data,       // 寄存器 rs 数据
    input [31:0] rt_data,       // 寄存器 rt 数据
    output IM_R,                // 指令存储器读使能
    output RF_W,                // 寄存器文件写使能
    output M1,                  // 内存控制信号 M1
    output M2,                  // 内存控制信号 M2
    output M3,                  // 内存控制信号 M3
    output M4,                  // 内存控制信号 M4
    output M5,                  // 内存控制信号 M5
    output DM_CS,               // 数据存储器控制信号
    output [2:0] ALU_OP,        // ALU 操作码
    output DM_R,                // 数据存储器读使能
    output DM_W,                // 数据存储器写使能
    output sign_ext             // 符号扩展控制信号
);

    // 对输入指令进行位切割，生成相应的操作码和寄存器编号
    wire [5:0] func = instruction[5:0];
    wire [5:0] op = instruction[31:26];
    wire [4:0] rs = instruction[25:21];
    wire [4:0] rt = instruction[20:16];
    wire R_type = ~|op;

    // 根据不同的操作码和功能位生成控制信号
    wire ADD_, SUB_, AND_, OR_, XOR_, SLT_, MOVZ_, SLL_;
    wire LW_, SW_;
    wire BNE_, J_;

    // R-Type 操作码
    assign ADD_ = R_type & func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
    assign SUB_ = R_type & func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
    assign AND_ = R_type & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
    assign OR_ = R_type & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & func[0];
    assign XOR_ = R_type & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
    assign SLT_ = R_type & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0];
    assign MOVZ_ = R_type & ~func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0];
    assign SLL_ = R_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];

    // I-Type 操作码
    assign SW_ = ~R_type & op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
    assign LW_ = ~R_type & op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
    assign BNE_ = ~R_type & ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
    assign J_ = ~R_type & ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];

    // 指令存储器读使能信号始终为 1
    assign IM_R = 1;

    // 决定是否需要写寄存器文件
    assign RF_W = ADD_ | SUB_ | AND_ | OR_ | XOR_ | SLT_ | MOVZ_ | LW_ | SLL_;

    // 决定是否需要访问数据存储器
    assign DM_CS = LW_ | SW_;
    assign DM_R = LW_;
    assign DM_W = SW_;

    // 根据操作码生成 ALU 操作码
    assign ALU_OP[2] = XOR_ | SLT_ | MOVZ_ | SLL_;
    assign ALU_OP[1] = AND_ | OR_ | MOVZ_ | SLL_;
    assign ALU_OP[0] = SUB_ | OR_ | SLT_ | SLL_;

    // 决定内存控制信号
    assign M1 = ADD_ | SUB_ | AND_ | OR_ | XOR_ | SLT_ | MOVZ_ | LW_ | SW_ | BNE_ | SLL_ | !(ADD_ | SUB_ | AND_ | OR_ | XOR_ | SLT_ | MOVZ_ | LW_ | SW_ | BNE_ | SLL_ | J_);
    assign M2 = ADD_ | SUB_ | AND_ | OR_ | XOR_ | SLT_ | MOVZ_ | SLL_;
    assign M3 = LW_ | SW_;
    assign M4 = ADD_ | SUB_ | AND_ | OR_ | XOR_ | SLT_ | MOVZ_ | SLL_ | LW_ | SW_ | SLL_ | (BNE_ && rs_data == rt_data);
    assign M5 = LW_;

    // 决定是否进行符号扩展
    assign sign_ext = LW_ | SW_ | BNE_ | J_;

endmodule
