module keyboard(
    input             clk,
    input             rst,
    
    // UART port
    inout             USB_CLOCK,
    inout             USB_DATA,
    
    // UART port
    input             RXD,
    output reg        TXD,
    output reg        CTS,
    input             RTS,
    output reg        bt_W,
    output reg        bt_S,
    output reg        bt_J
);

// USB ports control
wire   USB_CLOCK_OE;
wire   USB_DATA_OE;
wire   USB_CLOCK_out;
wire   USB_CLOCK_in;
wire   USB_DATA_out;
wire   USB_DATA_in;
assign USB_CLOCK = (USB_CLOCK_OE) ? USB_CLOCK_out : 1'bz;
assign USB_DATA = (USB_DATA_OE) ? USB_DATA_out : 1'bz;
assign USB_CLOCK_in = USB_CLOCK;
assign USB_DATA_in = USB_DATA;

wire       PS2_valid;
wire [7:0] PS2_data_in;
reg  [7:0] PS2_data_in_;
wire       PS2_busy;
wire       PS2_error;
wire       PS2_complete;
reg        PS2_enable;
(* dont_touch = "true" *)reg  [7:0] PS2_data_out;

// Controller for the PS2 port
// Transfer parallel 8-bit data into serial, or receive serial to parallel
ps2_transmitter ps2_transmitter(
    .clk(clk),
    .rst(rst),
    
    .clock_in(USB_CLOCK_in),
    .serial_data_in(USB_DATA_in),
    .parallel_data_in(PS2_data_in),
    .parallel_data_valid(PS2_valid),
    .busy(PS2_busy),
    .data_in_error(PS2_error),
    
    .clock_out(USB_CLOCK_out),
    .serial_data_out(USB_DATA_out),
    .parallel_data_out(PS2_data_out),
    .parallel_data_enable(PS2_enable),
    .data_out_complete(PS2_complete),
    
    .clock_output_oe(USB_CLOCK_OE),
    .data_output_oe(USB_DATA_OE)
);

// Output the data to uart
reg [15:0] tx_count;
reg [19:0] tx_shift;
reg [19:0] CTS_delay;
// Input from uart
(* dont_touch = "true" *)reg [7:0]  RXD_delay;
reg [15:0] rx_count;
(* dont_touch = "true" *)reg [3:0]  rx_bit_count;
reg        rx_start;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        tx_count <= 16'd0;
        TXD <= 1'b1;
		tx_shift <= 20'd0;
        CTS <= 1'b1;
        CTS_delay <= 20'hFFFFF;
    end
    // When get data from PS2, transfer and buffer it into register
    else if(PS2_valid) begin
        case(PS2_data_in[3:0])
        4'h0: begin tx_shift[9:0] <= 10'b0000011001; end
        4'h1: begin tx_shift[9:0] <= 10'b0100011001; end
        4'h2: begin tx_shift[9:0] <= 10'b0010011001; end
        4'h3: begin tx_shift[9:0] <= 10'b0110011001; end
        4'h4: begin tx_shift[9:0] <= 10'b0001011001; end
        4'h5: begin tx_shift[9:0] <= 10'b0101011001; end
        4'h6: begin tx_shift[9:0] <= 10'b0011011001; end
        4'h7: begin tx_shift[9:0] <= 10'b0111011001; end
        4'h8: begin tx_shift[9:0] <= 10'b0000111001; end
        4'h9: begin tx_shift[9:0] <= 10'b0100111001; end
        4'hA: begin tx_shift[9:0] <= 10'b0100000101; end
        4'hB: begin tx_shift[9:0] <= 10'b0010000101; end
        4'hC: begin tx_shift[9:0] <= 10'b0110000101; end
        4'hD: begin tx_shift[9:0] <= 10'b0001000101; end
        4'hE: begin tx_shift[9:0] <= 10'b0101000101; end
        4'hF: begin tx_shift[9:0] <= 10'b0011000101; end
        endcase
        
        case(PS2_data_in[7:4])
        4'h0: begin tx_shift[19:10] <= 10'b0000011001; end
        4'h1: begin tx_shift[19:10] <= 10'b0100011001; end
        4'h2: begin tx_shift[19:10] <= 10'b0010011001; end
        4'h3: begin tx_shift[19:10] <= 10'b0110011001; end
        4'h4: begin tx_shift[19:10] <= 10'b0001011001; end
        4'h5: begin tx_shift[19:10] <= 10'b0101011001; end
        4'h6: begin tx_shift[19:10] <= 10'b0011011001; end
        4'h7: begin tx_shift[19:10] <= 10'b0111011001; end
        4'h8: begin tx_shift[19:10] <= 10'b0000111001; end
        4'h9: begin tx_shift[19:10] <= 10'b0100111001; end
        4'hA: begin tx_shift[19:10] <= 10'b0100000101; end
        4'hB: begin tx_shift[19:10] <= 10'b0010000101; end
        4'hC: begin tx_shift[19:10] <= 10'b0110000101; end
        4'hD: begin tx_shift[19:10] <= 10'b0001000101; end
        4'hE: begin tx_shift[19:10] <= 10'b0101000101; end
        4'hF: begin tx_shift[19:10] <= 10'b0011000101; end
        endcase
        
        CTS_delay <= 20'h00000;
    end
    // When receiving data, output the same thing in the meantime
    else if((~RXD) || rx_start) begin
        TXD <= RXD;
        CTS <= 1'b0;
    end
    // Shift out the received data
    else begin
		if(tx_count < 16'd867) begin
			tx_count <= tx_count + 16'd1;
		end
		else begin
			tx_count <= 16'd0;
		end
		
		if(tx_count == 16'd0) begin
			TXD <= tx_shift[19];
			tx_shift <= {tx_shift[18:0], 1'b1};
            CTS <= CTS_delay[19];
            CTS_delay <= {CTS_delay[18:0], 1'b1};
		end
    end
end


always @(posedge clk or posedge rst) begin
    if(rst) begin
        RXD_delay <= 8'h00;
        rx_count <= 16'd0;
        rx_bit_count <= 4'd0;
        PS2_enable <= 1'b0;
        rx_start <= 1'b0;
    end
    else if(~RTS) begin
        if(rx_count < 16'd867) begin
			rx_count <= rx_count + 16'd1;
		end
		else begin
			rx_count <= 16'd0;
		end
        
        if( (rx_count == 16'd0) && (~RXD) && (~rx_start) ) begin
            RXD_delay <= 8'h00;
            rx_bit_count <= 4'd0;
            rx_start <= 1'b1;
        end
        else if( (rx_count == 16'd0) && rx_start && (rx_bit_count != 4'd8)) begin
            rx_bit_count <= rx_bit_count + 4'd1;
            RXD_delay <= {RXD_delay[6:0], RXD};
        end
        else if( (rx_count == 16'd0) && rx_start) begin
            rx_start <= 1'b0;
            rx_bit_count <= 4'd0;
            PS2_enable <= 1'b1;
        end
        else begin
            PS2_enable <= 1'b0;
        end
    end
end

always @(posedge clk) begin
    if(!PS2_valid) begin
        bt_W <= 1'b0;
        bt_S <= 1'b0;
        bt_J <= 1'b0;
    end
    else if(PS2_valid) begin 
        PS2_data_in_ <= PS2_data_in;
        bt_W <= (PS2_data_in == 8'h1D && PS2_data_in_ == 8'hF0) ? 1'b1 : 1'b0;
        bt_S <= (PS2_data_in == 8'h1B && PS2_data_in_ == 8'hF0) ? 1'b1 : 1'b0;
        bt_J <= (PS2_data_in == 8'h3B && PS2_data_in_ == 8'hF0) ? 1'b1 : 1'b0;
    end
end
endmodule

module ps2_transmitter(
    input            clk,
    input            rst,
    
    // ports for input data
    input            clock_in,           // connected to usb clock input signal
    input            serial_data_in,     // connected to usb data input signal
    output reg [7:0] parallel_data_in,   // 8-bit input data buffer, from the USB interface
    output reg       parallel_data_valid,// indicate the input data is ready or not
    output reg       data_in_error,      // reading error when the odd parity is not matched
    
    // ports for output date
    output reg       clock_out,           // connected to usb clock output signal
    output reg       serial_data_out,     // connected to usb data output signal
    input      [7:0] parallel_data_out,   // 8-bit output data buffer, to the USB interface
    input            parallel_data_enable,// control signal to start a writing process
    output reg       data_out_complete,
    
    output reg       busy,                // indicate the transmitter is busy
    output reg       clock_output_oe,     // clock output enable
    output reg       data_output_oe       // data output enable
);

// State machine
parameter [3:0] IDLE = 4'd0;
parameter [3:0] WAIT_IO = 4'd1;
parameter [3:0] DATA_IN = 4'd2;
parameter [3:0] DATA_OUT = 4'd3;
parameter [3:0] INITIALIZE = 4'd4;

reg  [3:0]  state;
reg  [3:0]  next_state;

// Parallel data buffer
reg  [10:0] data_out_buf;
reg  [10:0] data_in_buf;
reg  [3:0]  data_count;

// Counter for clock and data output
reg  [15:0] clock_count;

// Used to detect the falling edge of clock_in, to see if there is anything coming in
// If data coming in, then we cannot start writing data out
reg  [1:0]  clock_in_delay;
wire        clock_in_negedge;
always @(posedge clk) begin
    clock_in_delay <= {clock_in_delay[0], clock_in};
end
assign clock_in_negedge = (clock_in_delay == 2'b10) ? 1'b1 : 1'b0;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(posedge clk) begin
    case(state)
    IDLE: begin
        next_state <= WAIT_IO;
        clock_output_oe <= 1'b0;
        data_output_oe <= 1'b0;
        data_in_error <= 1'b0;
        data_count <= 4'd0;
        busy <= 1'b0;
        parallel_data_valid <= 1'b0;
        clock_count <= 16'd0;
        data_in_buf <= 11'h0;
        data_out_buf <= 11'h0;
        clock_out <= 1'b1;
        serial_data_out <= 1'b1;
        data_out_complete <= 1'b0;
        parallel_data_in <= 8'h00;
    end
    // If the clock is driven low by mouse, then start reading
    // If need to send data, and not in data reading mode, then start sending
    // Indicate busy when leaving this state
    WAIT_IO: begin
        if(clock_in_negedge) begin  // input data detected, and the start bit is ignored
            next_state <= DATA_IN;
            busy <= 1'b1;
            data_count <= 4'd0;
        end
        else if(parallel_data_enable) begin // output data enable detected, and send out the start bit right here
            next_state <= INITIALIZE;
            busy <= 1'b1;
            data_count <= 4'd0;
            clock_output_oe <= 1'b1;
            clock_out <= 1'b0;  // drive low for about 60us to initialize output
            data_out_buf <= {parallel_data_out[0],parallel_data_out[1],parallel_data_out[2],parallel_data_out[3],
                             parallel_data_out[4],parallel_data_out[5],parallel_data_out[6],parallel_data_out[7],
                             ~^(parallel_data_out), 2'b11};
            data_output_oe <= 1'b1;
            serial_data_out <= 1'b0;
        end
    end
    // After the start bit, detect 10 falling edge on clock pin, and shift record the data
    // When finish, invert the byte and send out parallel data
    DATA_IN: begin
        if(clock_in_negedge && (data_count < 4'd10)) begin
            data_in_buf <= {data_in_buf[9:0], serial_data_in};
            data_count <= data_count + 4'd1;
        end
        else if(data_count == 4'd10) begin
            next_state <= IDLE;
            data_count <= 4'd0;
            busy <= 1'b0;
            parallel_data_valid <= 1'b1;
            parallel_data_in <= {data_in_buf[2],data_in_buf[3],data_in_buf[4],data_in_buf[5],
                                 data_in_buf[6],data_in_buf[7],data_in_buf[8],data_in_buf[9]};
            if(data_in_buf[1] == ^(data_in_buf[9:2])) begin
                data_in_error <= 1'b1;
            end
        end
    end
    // Before sending, need to drive the clock and data low for about 60us, clock will go back to high after 60us
    INITIALIZE : begin
        if(clock_count < 16'd6000) begin
            clock_count <= clock_count + 16'd1;
            clock_output_oe <= 1'b1;
            clock_out <= 1'b0;
        end
        else begin
            next_state <= DATA_OUT;
            clock_output_oe <= 1'b0;
            clock_out <= 1'b1;
        end
    end
    // Mouse will drive the clock again, wait and detect 10 falling edge clock to send out the reset data
    DATA_OUT : begin
        if(clock_in_negedge) begin
            if(data_count < 4'd10) begin
                data_count <= data_count + 4'd1;
                serial_data_out <= data_out_buf[10];
                data_out_buf <= {data_out_buf[9:0], 1'b0};
            end
            else if(data_count == 4'd10) begin
                data_out_complete <= 1'b1;
                next_state <= IDLE;
                busy <= 1'b0;
            end
        end
    end
    endcase
end

endmodule