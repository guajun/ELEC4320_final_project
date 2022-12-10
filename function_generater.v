`timescale 1ns / 1ps


module function_generater();
    
    wire [15:0] data;
    reg [7:0] control;
    reg [15:0] prescaler;
    reg [15:0] amplitude;
    wire clk;

    reg [7:0] mode;
    
    always @(posedge clk)
    begin
        case(control[3:1])
            3'b000: mode <= 8'b0000_0001;
            3'b001: mode <= 8'b0000_0010;
            3'b010: mode <= 8'b0000_0100;
            3'b011: mode <= 8'b0000_1000;
            3'b100: mode <= 8'b0001_0000;
            3'b101: mode <= 8'b0010_0000;
            3'b110: mode <= 8'b0100_0000;
            3'b111: mode <= 8'b1000_0000;
        endcase
    end
    
    trigonometric_wave trigonometric_wave(
    .clk(clk),
    .ena(mode[2:0]),
    .amplitude(amplitude),
    .prescaler(prescaler),
    .data(data)
    );
    
    triangular_wave triangular_wave(
    .clk(clk),
    .ena(mode[4]),
    .amplitude(amplitude),
    .prescaler(prescaler),
    .data(data)
    );
    
    saw_tooth_wave saw_tooth_wave(
    .clk(clk),
    .ena(mode[5]),
    .amplitude(amplitude),
    .prescaler(prescaler),
    .data(data)
    );
    
    clk_wiz_0 instance_name(
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
    // Status and control signals
    .reset(0), // input reset
    .locked(0),       // output locked
    // Clock in ports
    .clk_in1(clk_in1) // input clk_in1
    );
    
    // INST_TAG_END ------ End INSTANTIATION Template ---------
endmodule
