`timescale 1ns / 1ps


module cosine_wave(input reg clk,
                   input reg ena,
                   input reg amplitude,        // act as lowerbound
                   input reg [15:0] prescaler, // act as upperbound
                   output reg [15:0] data);
    
    reg [15:0] counter = 0;
    reg [15:0] index   = 0;
    
    always @(posedge clk)
    begin
        if (ena)
        begin
            if (counter == prescaler) counter  < = amplitude;
            else counter <= counter + 1;
        end
        else counter <= amplitude;
    end
    
    cosine_rom sine_rom(
    
    .clka(clk),
    .addra(counter + 16'h3FFF), // shift pi/2
    .douta(data),
    .ena(ena)
    );
    
endmodule
