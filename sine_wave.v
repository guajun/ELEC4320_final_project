`timescale 1ns / 1ps


module sine_wave(input reg clk,
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
    
    sine_rom sine_rom(
    
    .clka(clk),
    .addra(counter),
    .douta(data),
    .ena(ena)
    );
    
endmodule
