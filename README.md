
# 🔧 Parameterized ALU in Verilog

A parameterized Arithmetic Logic Unit (ALU) implemented in Verilog HDL featuring 14 operations, status flags, and a reusable self-checking testbench.

## Features

- Parameterized data width (default 32-bit)
- 14 ALU operations
- Zero flag
- Carry flag
- Overflow flag
- Negative flag
- Self-checking testbench
- GTKWave waveform generation
- Modular opcode definitions using `alu_defines.vh`

---

## Supported Operations

| Category | Operations |
|----------|------------|
| Arithmetic | ADD, SUB |
| Logic | AND, OR, XOR, NOR, XNOR, NOT |
| Shift | SLL, SRL, SRA |
| Misc | SLT, PASS A, PASS B |

---

## Status Flags

| Flag | Description |
|------|-------------|
| Zero | Result equals zero |
| Carry | Carry generated during addition |
| Overflow | Signed arithmetic overflow |
| Negative | Most significant bit of the result |

---

## Project Structure

```text
alu-verilog/
│── alu.v
│── alu_tb.v
│── alu_defines.vh
│── README.md
```

---

## Simulation

Compile:

```bash
iverilog -o alu_sim alu.v alu_tb.v
```

Run:

```bash
vvp alu_sim
```

View waveform:

```bash
gtkwave alu.vcd
```
![alt text](image.png) // add
![alt text](image-1.png)//shift
![alt text](image-2.png)//overflow
---

## Sample Output

```text
ADD : PASS
SUB : PASS
AND : PASS
OR : PASS
...
Simulation Complete
Passed 17 / 17 tests
```

---

## Future Improvements

- Signed/Unsigned SLT mode
- Randomized testbench
- SystemVerilog assertions
- Functional coverage

---

## Author

**10-TUX**