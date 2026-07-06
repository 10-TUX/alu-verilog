# 32-bit ALU in Verilog

## Overview
This project implements a 32-bit Arithmetic Logic Unit (ALU) in Verilog.

Currently implemented:
- Addition
- Zero flag generation

## Inputs
- A [31:0]
- B [31:0]
- alu_control [3:0]

## Outputs
- result [31:0]
- zero

## Simulation

Compile:

```bash
iverilog -o alu_sim alu.v alu_tb.v
```

Run:

```bash
vvp alu_sim
```

Example Output:

```
A = 15, B = 20, Result = 35, Zero = 0
```

## Project Status

Current version:
- ✅ Addition
- ✅ Subtraction
- ✅ AND
- ✅ OR
- ✅ XOR
- ✅ SLT (Set Less Than)

This project is part of my RTL Design portfolio.