module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0]led,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy, // AVR Rx buffer full

    //sm83 outside connections
    output [15:0] addr,
    output [7:0] r_data,
    output [7:0] w_data

    );

wire rst = ~rst_n; // make reset active high

// these signals should be high-z when not used
assign spi_miso = 1'bz;
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;

wire sm83_halt;
assign led[0] = sm83_halt;

wire sm83_wen;
assign led[7] = sm83_wen;

sm83_top sm83_top (
	.clk(clk),
	.rst_n(rst_n),
	.r_data_out(r_data),
	.w_data_out(w_data),
	.addr_out(addr),
	.w_wen(sm83_wen),
	.halt(sm83_halt)
);

endmodule