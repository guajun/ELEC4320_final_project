`timescale 1ns / 1ps

module saw_tooth_wave(input clk,
                      input ena,
                      input [15:0] amplitude,
                      input [15:0] prescaler,
                      output reg [15:0]data);
    // reg clk;
    // reg ena;
    // reg amplitude;
    // reg [15:0] prescaler;
    // reg [15:0]data;

    reg [15:0] counter = 0;
    
    always @(posedge clk)
    begin
        if (ena)
        begin
            if (counter == prescaler)
            begin
                counter <= 0;
                
                if (data == amplitude)data <= 0;
                
                else data <= data + 1;
                
            end
            else counter <= counter + 1;
        end
        else
        begin
            counter <= 0;
        end
    end
    
endmodule
