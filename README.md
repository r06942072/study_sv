# lab steps
	cd lab01
	iverilog -g2012 src/*
	iverilog -g2012 -gsupported-assertions src/*
	vvp a.out
	gtkwave top.vcd
# tool notes
- iverilog
	- sv clocking not supported
---
# public resources
- iverilog
	- https://iverilog.fandom.com/wiki/Iverilog_Flags
- hdlbits
	- https://hdlbits.01xz.net/
- asic-world
	- https://www.asic-world.com/examples/systemverilog/index.html	
---
# class note
## Vicky
- 2024????
- 2024????
- 20240229
	- lab04_fsm, bit_sel, part_sel
	- lab05
	- lab06
- 20240222
	- lab04_fsm
- 20240206
	- ref/Basic Verilog RTL.pptx
	- comb and seq logic
	- sync and async reset
- 20240201
	- lab03_counter
	- ref/Basic Verilog RTL.pptx
	- concatenation{}
	- ifelse priority
	- D-flipflop
- 20240125
	- lab02_datatype_task_func
	- sv_lrm_2017, ch6.18 User-defined types, typedef
	- sv_lrm_2017, ch10.6.2 force release
- 20240118
	- sv_lrm_2017, ch21.7 vcd files
	- sv_lrm_2017, ch23 hdl hierarchy
	- https://www.asic-world.com/systemverilog/hierarchy2.html
	- sv_lrm_2017, ch13 function task
- 20240111
	- env setup
		- download icarus verilog for windows
			- https://bleyer.org/icarus/
		- download editor notepad++
			- https://notepad-plus-plus.org/downloads/
	- ref/icarus_verilog教學.pptx
	- ref
		- https://www.youtube.com/watch?v=5Kync4z5VOw
- 20240104
	- logic design，python, future VLSI

	