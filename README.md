[class_note]
*
20240125

*
20240118
	ref/Basic Verilog RTL.pptx

*
20240111
	env setup
		download icarus verilog for windows
			https://bleyer.org/icarus/
		download editor notepad++
			https://notepad-plus-plus.org/downloads/
	ref/icarus_verilog教學.pptx
	ref
		https://www.youtube.com/watch?v=5Kync4z5VOw
--------------------------------------------------------------
[lab]
*
steps
	cd lab01
	iverilog -g2012 -o out src/top.sv
		IEEE1800-2012
	iverilog -o out src/top.sv
	vvp out
	gtkwave top.vcd
	
--------------------------------------------------------------
[resources]
*
hdlbits
	https://hdlbits.01xz.net/

--------------------------------------------------------------
[archive below]
	邏輯設計，python
	未來課程VLSI