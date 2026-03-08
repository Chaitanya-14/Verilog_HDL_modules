# Ripple Carry Adder Using 1-bit Full Adder

In this experiment, I first designed a **1-bit Full Adder** module (`one_b_fa.v`).
The module takes three inputs (`a`, `b`, `cin`) and produces two outputs (`sum`, `cout`).

After verifying the 1-bit design, I used it as a building block to create a **4-bit Ripple Carry Adder** (`rp_adder.v`).
In the 4-bit adder, four 1-bit full adders are connected in series.
The carry output from each stage is connected to the carry input of the next stage, which forms the ripple-carry structure.

I also wrote a testbench (`rp_adder_tb.v`) to verify the design.
The testbench uses:

- `for` loops to iterate through all possible input combinations
- `task` blocks to simplify repeated stimulus/check operations

This verifies the adder behavior for all input possibilities and confirms correct `sum` and `carry` outputs.
