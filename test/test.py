import cocotb
from cocotb.triggers import Timer


async def test_alu_operation(dut, A, B, opcode, expected_result, expected_carry):
    # Put A and B onto ui_in
    dut.ui_in.value = A | (B << 4)

    # Put opcode onto uio_in[2:0]
    dut.uio_in.value = opcode

    # Give the combinational logic time to settle
    await Timer(1, units="ns")

    # Read output
    output = int(dut.uo_out.value)

    actual_result = output & 0xF
    actual_carry = (output >> 4) & 1
    actual_zero = (output >> 5) & 1

    # Check result
    assert actual_result == expected_result, (
        f"Opcode {opcode:03b}: "
        f"A={A:04b}, B={B:04b}, "
        f"expected result={expected_result:04b}, "
        f"got={actual_result:04b}"
    )

    # Check carry
    assert actual_carry == expected_carry, (
        f"Opcode {opcode:03b}: "
        f"A={A:04b}, B={B:04b}, "
        f"expected carry={expected_carry}, "
        f"got={actual_carry}"
    )

    # Check zero flag
    expected_zero = 1 if expected_result == 0 else 0

    assert actual_zero == expected_zero, (
        f"Opcode {opcode:03b}: "
        f"expected zero={expected_zero}, "
        f"got={actual_zero}"
    )


@cocotb.test()
async def test_project(dut):

    # Test all 8 ALU operations
    for A in range(16):
        for B in range(16):

            # ADD
            total = A + B
            await test_alu_operation(
                dut, A, B, 0b000,
                total & 0xF,
                (total >> 4) & 1
            )

            # SUBTRACT
            result = (A - B) & 0xF
            await test_alu_operation(
                dut, A, B, 0b001,
                result,
                0
            )

            # AND
            result = A & B
            await test_alu_operation(
                dut, A, B, 0b010,
                result,
                0
            )

            # OR
            result = A | B
            await test_alu_operation(
                dut, A, B, 0b011,
                result,
                0
            )

            # XOR
            result = A ^ B
            await test_alu_operation(
                dut, A, B, 0b100,
                result,
                0
            )

            # NOT A
            result = (~A) & 0xF
            await test_alu_operation(
                dut, A, B, 0b101,
                result,
                0
            )

            # SHIFT LEFT
            result = (A << 1) & 0xF
            carry = (A >> 3) & 1
            await test_alu_operation(
                dut, A, B, 0b110,
                result,
                carry
            )

            # SHIFT RIGHT
            result = (A >> 1) & 0xF
            await test_alu_operation(
                dut, A, B, 0b111,
                result,
                0
            )
