`default_nettype none

module tt_um_combinational (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // --------------------------------------------------
    // 1. Unused bidirectional pins
    // --------------------------------------------------

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;


    // --------------------------------------------------
    // 2. Input mapping
    // --------------------------------------------------

    wire [3:0] A;
    wire [3:0] B;
    wire [2:0] opcode;

    assign A      = ui_in[3:0];
    assign B      = ui_in[7:4];
    assign opcode = uio_in[2:0];


    // --------------------------------------------------
    // 3. ALU outputs
    // --------------------------------------------------

    reg [3:0] result;
    reg       carry;


    // --------------------------------------------------
    // 4. Combinational ALU
    // --------------------------------------------------

    always @(*) begin

        // Default values
        result = 4'b0000;
        carry  = 1'b0;

        case (opcode)

            // 000: ADD
            3'b000: begin
                {carry, result} = A + B;
            end

            // 001: SUBTRACT
            3'b001: begin
                result = A - B;
            end

            // 010: AND
            3'b010: begin
                result = A & B;
            end

            // 011: OR
            3'b011: begin
                result = A | B;
            end

            // 100: XOR
            3'b100: begin
                result = A ^ B;
            end

            // 101: NOT A
            3'b101: begin
                result = ~A;
            end

            // 110: SHIFT LEFT
            3'b110: begin
                {carry, result} = A << 1;
            end

            // 111: SHIFT RIGHT
            3'b111: begin
                result = A >> 1;
            end

            // Safety default
            default: begin
                result = 4'b0000;
                carry  = 1'b0;
            end

        endcase
    end


    // --------------------------------------------------
    // 5. Output mapping
    // --------------------------------------------------

    assign uo_out[3:0] = result;
    assign uo_out[4]   = carry;

    // ZERO flag
    assign uo_out[5]   = (result == 4'b0000);

    // Unused output pins
    assign uo_out[7:6] = 2'b00;


    // --------------------------------------------------
    // 6. Unused Tiny Tapeout control signals
    // --------------------------------------------------

    // ena, clk and rst_n are intentionally unused because
    // this is a purely combinational circuit.

endmodule

`default_nettype wire
