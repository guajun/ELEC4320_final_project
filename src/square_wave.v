`timescale 1ns / 1ps


module square_wave(input clk,
                   input ena,
                   input [15:0] prescaler,
                   output reg [15:0]data);
    
    reg [15:0] counter = 0;
    
    always @(posedge clk)
    begin
        if (ena)
        begin
            if (counter == prescaler)
            begin
                counter <= 0;
                data    <= ~data;
            end
            else counter <= counter + 1;
        end
        else counter <= 0;
        
    end
    
endmodule
    
