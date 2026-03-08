# Verilog HDL Modules

This repository contains my Verilog HDL practice work, including basic gates, combinational circuits, ALU design, and lab assignments with RTL, testbenches, and waveform outputs.

## Repository Structure

- `Basic_gates/`
	- AND, OR, NOT, NOR, NAND, XOR, XNOR implementations and testbenches.
- `Combinational_Circuits/`
	- Half Adder, Full Adder, Ripple Carry Adder, Subtractors, and derived designs.
- `ALU/`
	- ALU RTL and testbench.
- `Assignments/lab1/`
	- Full Adder (dataflow), 2:4 Decoder, Ripple Adder using 1-bit FA, 4:1 MUX, and 4:1 MUX using Decoder + Tri-state buffer.
- `Xilinx_simulations/`
	- Xilinx project-oriented simulation setup and files.

## Tools Used

- `iverilog` for compile/elaboration
- `vvp` for simulation
- `gtkwave` for waveform viewing (`.vcd` files)

## Quick Run Flow

1. Go to the target module folder.
2. Compile RTL and testbench:

```bash
iverilog -o sim.out <rtl_files>.v <testbench>.v
```

3. Run simulation:

```bash
vvp sim.out
```

4. Open waveform:

```bash
gtkwave <dumpfile>.vcd
```

## Notes

- Most modules include both RTL and testbench files in nearby `RTL/` and `tb/` folders.
- Some labs include self-checking testbenches with pass/fail summaries.
- File and folder names are kept lab-wise for easy tracking of learning progress.