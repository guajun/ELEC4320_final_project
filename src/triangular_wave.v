`timescale 1ns / 1ps


module triangular_wave(input clk,
                       input ena,
                       input [15:0] amplitude,
                       input [15:0] prescaler,
                       output reg [15:0] data);
    initial
    begin
        data = 0;
    end

    reg [15:0] counter = 0;
    reg inc            = 0;
    
    always @(posedge clk)
    begin
        if (ena)
        begin
            if (counter == prescaler)
            begin
                counter <= 0;
                
                if (data == amplitude) inc = 0;
                
                else if (data == 0)inc = 1;
                
                data <= inc ? (data + 1): (data - 1);
            end
            else counter <= counter + 1;
        end
        else begin
            data <= 0;
            counter <= 0;
        end
    end
    
endmodule
    
