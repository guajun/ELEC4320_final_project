`timescale 1ns / 1ps

module test();
    
    wire [15:0] data_out;
    reg [7:0] control    = 8'h00;
    reg [15:0] prescaler = 16'h0000;
    reg [15:0] amplitude = 16'h0000;
    reg clk              = 0;
    
    function_generater function_generater(
    .data(data_out),
    .control(control),
    .prescaler(prescaler),
    .amplitude(amplitude),
    .clk(clk)
    );
    
    always
    begin
    clk <= ~clk;
    #1;
    end
    
    initial
    begin
        
        control[3:1] <= 3'b011; // square wave
        control[0]   <= 1'b1;
        
        #5000 control[0] <= 1'b0;
        #1 prescaler     <= 16'h02;
        control[0]       <= 1'b1;
        
        #5000 control[0] <= 1'b0;
        #1 prescaler     <= 16'h1F;
        control[0]       <= 1'b1;
        
        
        #5000 control[0] <= 1'b0;
        #1 control[3:1]  <= 3'b100; // triangular wave
        amplitude        <= 16'h00FF; // amplitude = 0xff
        prescaler  <= 16'h00;
        control[0] <= 1'b1;
        
        #5000 control[0] <= 1'b0;
        #1 prescaler     <= 16'h01;
        control[0]       <= 1'b1;
        
        #5000 control[0] <= 1'b0;
        #1 control[3:1]     <= 3'b101; // saw tooth wave, amplitude = 0xff
        prescaler     <= 16'h00;
        control[0] <= 1'b1;
        
        
        #5000 control[0] <= 1'b0;
        prescaler        <= 16'h01;
        #2 control[0]    <= 1'b1;
        
        #5000 $finish;
        
        
    end
    
    // clk_wiz_0 clk_wiz_0(
    // // Clock out ports
    // .clk_out1(clk),     // output clk_out1
    // // Status and control signals
    // .reset(0), // input reset
    // .locked(0),       // output locked
    // // Clock in ports
    // .clk_in1(clk_in1) // input clk_in1
    // );
    // INST_TAG_END ------ End INSTANTIATION Template ---------
endmodule
