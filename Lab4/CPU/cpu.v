/******************************************************************************
* Function: CPU模块
*
* 模块功能描述:
* - 此模块表示中央处理器（CPU）的顶层模块。
* - 包含一个指令存储器、指令解码器、程序计数器、寄存器文件、算术逻辑单元、数据存储器等模块，
*   以实现CPU的基本功能。
* - 此CPU执行给定的指令集，包括加载/存储、算术/逻辑运算等操作。
*
* 设计方法:
* - CPU顶层模块通过连接各个功能模块，实现基本的指令执行功能。
* - 指令从指令存储器读取，然后通过指令解码器译码，控制各个功能模块的操作。
* - 程序计数器用于指向下一条待执行的指令。
* - 寄存器文件存储CPU的寄存器状态，用于数据的读取和写入。
* - 算术逻辑单元（ALU）执行算术和逻辑运算，生成结果。
* - 数据存储器用于读取和写入数据。
*
******************************************************************************/

`timescale 1ns / 1ps


module cpu(
    input clk,
    input reset,


    output [31:0]   debug_wb_pc,  
    output          debug_wb_rf_wen,   
    output [4 :0]   debug_wb_rf_addr,   
    output [31:0]   debug_wb_rf_wdata    
    );
	
	// 模块内部信号声明
	(*mark_debug = "true"*) wire [31:0] inst;
    wire IM_R;
    wire [31:0] rdata;
    wire [31:0] wdata;
    wire DM_CS;
    wire DM_R;
    wire DM_W;
	wire stop;
    (*mark_debug = "true"*) wire [31:0] mrdata;
    wire [31:0] mwdata;
    wire [31:0] maddr;
    
    wire RF_W, M1, M2, M3, M4, M5, sign_ext, zero;
    wire [2:0] ALU_OP;
    wire [31:0] mux1_out, mux2_out, mux3_out, mux4_out, alu_out;
    wire [31:0] rf_rdata1, rf_rdata2;
    wire [31:0] s_ext16_out, s_ext18_out, s_ext28_out;
    wire [31:0] npc_out;
    wire [31:0] strcat_out;
    wire [27:0] J_temp;
    wire [17:0] BNE_temp;
    wire [4:0] rs, rt;
	wire [4:0] mux5_out;


    assign rs = inst[25:21];
    assign rt = inst[20:16]; 


    assign maddr = alu_out;
    assign mwdata = rf_rdata2;
    assign J_temp = inst[25:0] << 2;
    assign BNE_temp = inst[15:0] << 2;
	

	// 模块实例化
	instr_mem instr_mem(.clk(clk), .addr(debug_wb_pc), .IM_R(IM_R), .rst(reset), .instruction(inst));
	
	Decoder cup_decoder(.instruction(inst), .clk(clk), .zero(zero), .Dstop(stop),
                        .rs_data(rf_rdata1), .rt_data(rf_rdata2), .IM_R(IM_R), 
                        .RF_W(RF_W), .M1(M1), .M2(M2), .M3(M3), .M4(M4), .M5(M5), 
                        .DM_CS(DM_CS), .ALU_OP(ALU_OP), .DM_R(DM_R), .DM_W(DM_W), .sign_ext(sign_ext)
                        );
						
	PC cpu_pc(.clk(clk), .rst(reset), .data_in(mux1_out), .data_out(debug_wb_pc));
	NPC cpu_npc(.pc(debug_wb_pc), .npc(npc_out));
	
	Strcat cpu_strcat(.addr28(J_temp), .npc_high4(debug_wb_pc[31:28]), .jump2addr(strcat_out));
						
	assign debug_wb_rf_addr = M5 ? rt : inst[15:11];
    assign debug_wb_rf_wdata = mux2_out;
    assign debug_wb_rf_wen = RF_W;
	
	regfile cpu_regfile(.clk(clk), .rst(reset), .rf_w(RF_W), .raddr1(inst[25:21]), .raddr2(inst[20:16]),
     .waddr(debug_wb_rf_addr), .wdata(mux2_out), .rdata1(rf_rdata1), .rdata2(rf_rdata2));
	 
	alu cpu_alu(.a(rf_rdata1), .b(mux3_out), .alu_op(ALU_OP), .sa(inst[10:6]), .r(alu_out), .zero(zero), .Astop(stop));
	
	S_EXT16 cpu_s_ext16(.a(inst[15:0]), .sign_ext(sign_ext), .b(s_ext16_out));
	


	
	mux mux1(.a(mux4_out), .b(strcat_out), .select(M1), .r(mux1_out));
	mux mux2(.a(alu_out), .b(mrdata), .select(M2), .r(mux2_out));
    mux mux3(.a(s_ext16_out), .b(rf_rdata2), .select(M3), .r(mux3_out));
	mux mux4(.a(npc_out), .b((s_ext16_out<<2)+npc_out), .select(M4), .r(mux4_out));

	data_mem scDmem(.clk(clk), .rst(reset), .CS(DM_CS), .DM_W(DM_W), .DM_R(DM_R), 
                .addr(maddr), .wdata(mwdata), .rdata(mrdata));
	
	
endmodule