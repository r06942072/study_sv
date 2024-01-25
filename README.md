# lab steps
	cd lab01
	iverilog -g2012 -o out src/*
	iverilog -g2012 -gsupported-assertions -o out src/*
	vvp out
	gtkwave top.vcd
---
# public resources
- iverilog
	- https://iverilog.fandom.com/wiki/Iverilog_Flags
- hdlbits
	- https://hdlbits.01xz.net/
- asic-world
	- https://www.asic-world.com/examples/systemverilog/index.html	
---
# note
## class_note, vicky

### 2024??

### 20240201
	lab03_counter
	ref/Basic Verilog RTL.pptx
	
### 20240125
	lab02_datatype_task_func
	sv_lrm_2017, ch6.18 User-defined types, typedef
	sv_lrm_2017, ch10.6.2 force release
	
### 20240118
	sv_lrm_2017, ch21.7 vcd files
	sv_lrm_2017, ch23 hdl hierarchy
	https://www.asic-world.com/systemverilog/hierarchy2.html
	sv_lrm_2017, ch13 function task

### 20240111
	env setup
		download icarus verilog for windows
			https://bleyer.org/icarus/
		download editor notepad++
			https://notepad-plus-plus.org/downloads/
	ref/icarus_verilog教學.pptx
	ref
		https://www.youtube.com/watch?v=5Kync4z5VOw
### 20240104
	logic design，python, future VLSI

	