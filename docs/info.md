# 4-bit Combinational ALU

## How it works

This project implements a 4-bit Arithmetic Logic Unit (ALU) using purely combinational logic.

The ALU takes two 4-bit operands, `A` and `B`, and a 3-bit operation code (`opcode`). The opcode selects which operation the ALU performs.

There is no clock, memory, or sequential logic in this design. The output changes according to the current inputs and opcode.

### Inputs

The two 4-bit operands are connected to the Tiny Tapeout input pins as follows:

| Pin | Function |
|---|---|
| `ui_in[0]` | A[0] |
| `ui_in[1]` | A[1] |
| `ui_in[2]` | A[2] |
| `ui_in[3]` | A[3] |
| `ui_in[4]` | B[0] |
| `ui_in[5]` | B[1] |
| `ui_in[6]` | B[2] |
| `ui_in[7]` | B[3] |

The operation is selected using the first three bidirectional input pins:

| Pin | Function |
|---|---|
| `uio_in[0]` | Opcode[0] |
| `uio_in[1]` | Opcode[1] |
| `uio_in[2]` | Opcode[2] |

The remaining bidirectional input pins are unused.

### Operations

The 3-bit opcode selects one of eight operations:

| Opcode | Operation | Description |
|---|---|---|
| `000` | ADD | A + B |
| `001` | SUBTRACT | A - B |
| `010` | AND | A AND B |
| `011` | OR | A OR B |
| `100` | XOR | A XOR B |
| `101` | NOT | NOT A |
| `110` | SHIFT LEFT | A shifted left by 1 bit |
| `111` | SHIFT RIGHT | A shifted right by 1 bit |

### Outputs

The ALU output is connected to the Tiny Tapeout output pins:

| Pin | Function |
|---|---|
| `uo_out[0]` | Result[0] |
| `uo_out[1]` | Result[1] |
| `uo_out[2]` | Result[2] |
| `uo_out[3]` | Result[3] |
| `uo_out[4]` | Carry |
| `uo_out[5]` | Zero flag |
| `uo_out[6]` | Unused |
| `uo_out[7]` | Unused |

The `Carry` output is used for arithmetic operations and the left-shift operation.

The `Zero` flag is set to `1` whenever the 4-bit result is `0000`.

### Arithmetic operations

For addition:

```text
Result = A + B
