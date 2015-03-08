# 程序来自《深入理解程序设计——使用Linux汇编语言
#
# 变量：寄存器有以下用途
#
# %edi - 保存正在检测的数据项索引
# %ebx - 当前已经找到的最大数据项
# %eax - 当前已经找到的最大数据项
# as maximum.s -o maximum.o
# ld maximum.o -o maximum
# ./maximum
# echo $?
# 你会发现返回值是222

.section .data

data_items:
	.long 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 0

.section .text

.globl _start

_start:
	# 索引为0
	movl $0, %edi 
	# 把data_items[0] 加载到 %eax
	movl data_items(, %edi, 4), %eax 
	movl %eax, %ebx # %eax 就是最大值, 保存到 %ebx

start_loop:
	# 0 是一个特殊的值，表示数据末尾
	cmpl $0, %eax
	# 结束循环，退出
	je loop_exit
	# 加载下一个值
	incl %edi
	movl data_items(, %edi, 4), %eax
	# 比较
	cmpl %ebx, %eax
	# 跳到循环起始处
	jle start_loop
	# 否则将新值移入最大值寄存器
	movl %eax, %ebx
	# 跳到循环起始处
	jmp start_loop



loop_exit:
	movl $1, %eax
	int $0x80

