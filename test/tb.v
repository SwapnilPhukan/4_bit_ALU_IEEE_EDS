`default_nettype none

module tb;

    // Tiny Tapeout inputs
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;

    // Tiny Tapeout outputs
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Tiny Tapeout control signals
    reg  ena;
    reg  clk;
    reg  rst_n;

    // Instantiate the ALU
    tt_um_combinational user_project (
        .ui_in   (ui_in),
        .uo_out  (uo_out),
        .uio_in  (uio_in),
        .uio_out (uio_out),
        .uio_oe  (uio_oe),
        .ena     (ena),
        .clk     (clk),
        .rst_n   (rst_n)
    );

    initial begin
        // Default values
        ui_in  = 8'b0;
        uio_in = 8'b0;
        ena    = 1'b1;
        clk    = 1'b0;
        rst_n  = 1'b1;

        // Run simulation for a short time
        #100;

        $finish;
    end

endmodule

`default_nettype wire
