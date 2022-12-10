`timescale 1ns / 1ps


module trigonometric_wave(input clk,
                          input [2:0] ena,
                          input [15:0] amplitude,        // act as lowerbound
                          input [15:0] prescaler, // act as upperbound
                          output reg [15:0] data);
    // reg clk;
    // reg [2:0] ena;
    // reg [15:0] amplitude;
    // reg [15:0] prescaler;
    // reg [15:0] data;
    
    wire [15:0] data_w;
    reg [15:0] counter = 0;
    reg [15:0] index   = 0;
    
    always @(posedge clk)
    begin
        
        if (counter == prescaler) counter <= amplitude;
        else counter <= counter + 1;
        data <= data_w;
    end

    
    sine_rom sine_rom(
    
    .clka(clk),
    .addra((ena[1:0] == 2'b10)? counter :counter + 16'h3FFF),
    .douta(data_w),
    .ena(|(ena[1:0]))
    );
    
endmodule
