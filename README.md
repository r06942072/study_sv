billy class, open note.pptx, sv code and waveform
billy todo, lab40 and after

# lab steps (with free simulator iverilog)
	cd lab01
	iverilog -g2012 src/*
	iverilog -g2012 -gsupported-assertions src/*
	vvp a.out
	gtkwave top.vcd
# tool notes
- Cadence Xcelium 20.09, used in lab20 after
	- https://edaplayground.com/
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
	- sv all, https://verificationguide.com/systemverilog/systemverilog-tutorial/
- 20240725
- 20240718
- 20240711
	- lab??
- 20240704
	- lab??
- 20240627
	- lab36
	- lab37
- 20240613
	- lab33, [->2] and [=2] on d5 and d6
	- lab34 
	- lab35 
- 20240606
	- lab32
	- lab33, [*0]
- 20240530
	- https://blog.csdn.net/bleauchat/article/details/90415146
	- lab31, sva_seq_delay, a3 to a6, infinity
	- bind a checker into a module dut
- 20240523
	- lab31, sva_seq_delay, waveform of design 
	- lab31, sva_seq_delay, strong weak sva 
- 20240516
	- lab31, sva_seq_delay
	- regex.txt
		- https://web.mit.edu/hackl/www/lab/turkshop/slides/regex-cheatsheet.pdf
- 20240509
	- sva introduction, by pptx	
- 20240502
	- lab24, soft constraint
	- sva introduction, by pptx
- 20240425
	- lab22, rand
	- lab23, rand_mode, constraint_mode
- 20240418
	- Xcelium Simulator, xrun. EDA playground
	- lab20, class
	- lab21, class constructor new
- 20240411
	- lab12, signed_unsigned, case4 ~ case5. extension
	- lab13, packed unpacked
	- synthesis
- 20240404
	- lab17, wait_fork
	- lab18, disable_fork
	- lab12, signed_unsigned, case1 ~ case3, digital signal processing DSP
- 20240328
	- lab14,15,16, fork-join, join_any, join_none
	- lab19, iff
	- lab11, parameter
- 20240321
	- lab09, comb udp
	- lab10, seq udp
- 20240314
	- lab08, genif genfor
	- lab07, star and interface for ips connection
- 20240307
	- lab06
	- lab07, top, dut, tb for op1 + op2
- 20240229
	- lab04_fsm, bit_sel, part_sel
	- lab05, ba nba
		- low power, upf
	- lab06, three initial begin end blocks
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

	