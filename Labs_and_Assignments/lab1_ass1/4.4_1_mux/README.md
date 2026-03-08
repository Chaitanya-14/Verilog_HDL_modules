
# 4-to-1 Multiplexer (4:1 MUX)

## Overview
This module implements a 4-to-1 multiplexer using 2-to-1 multiplexer (2:1 MUX) building blocks.

## Architecture

### 2-to-1 MUX as Building Block
A 2-to-1 multiplexer selects between two inputs based on a single select line:
```
output = (select == 0) ? input0 : input1;
```

### Building 4-to-1 MUX from 2-to-1 MUX
The 4:1 MUX uses a hierarchical approach:
- **First stage**: Two 2:1 MUXes select from inputs [0-1] and [2-3] using select bit `s[0]`
- **Second stage**: One 2:1 MUX selects between the two first-stage outputs using select bit `s[1]`

This creates a tree structure that efficiently routes one of four inputs to the output based on the 2-bit select signal.

## Testbenches

### Functional Testbench
Tests all 16 combinations (4 inputs × 4 select values) to verify correct input routing.

### Self-Checking Testbench
Includes built-in assertions and automatic result verification:
- Compares actual output against expected output for each test case
- Reports pass/fail status immediately
- No manual waveform inspection required
- Ideal for automated verification and continuous integration

## Files
- `mux_4to1.v` - Main module
- `mux_2to1.v` - Building block
- `tb_4to1_mux.v` - Functional testbench
- `tb_4to1_mux_selfcheck.v` - Self-checking testbench
