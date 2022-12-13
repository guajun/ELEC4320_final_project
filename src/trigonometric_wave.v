`timescale 1ns / 1ps


module trigonometric_wave(input clk,
                          input [2:0] ena,
                          input [15:0] amplitude,  // act as lowerbound
                          input [15:0] prescaler,  // act as upperbound
                          output reg [31:0] data);
    initial
    begin
        data = 0;
    end
    
    wire [47:0] sin_cos_data = 0;
    wire [31:0] tan_data     = 0;
    reg [17:0] phase         = 0;
    reg [15:0] counter       = 0;
    
    
    reg [15:0] cos_data = 0;
    reg [15:0] sin_data = 0;
    
    always @(posedge clk)
    begin
        if (|ena)
        begin
            if (counter == prescaler) counter <= amplitude;
            else counter <= counter + 1;
            
            phase <= {counter[15], counter[15], counter[15], counter[14:0]};
            
            if (~^sin_cos_data[16:15]) // output overflow check due to rounding
                cos_data <= {sin_cos_data[16], sin_cos_data[14:0]} + 16'h8000; // cos
            
            if (~^sin_cos_data[40:39]) // output overflow check due to rounding
                sin_data <= {sin_cos_data[40], sin_cos_data[38:24]} + 16'h8000;// sin
            
            case(ena)
                3'b001: data  <= cos_data;
                3'b010: data  <= sin_data;
                3'b100: data  <= tan_data;
                default: data <= 0;
            endcase
        end
        else
        begin
            phase   <= 0;
            counter <= 0;
        end
    end
    
    
    cordic sin_cos (
    .aclk(clk),                                // input wire aclk
    .s_axis_phase_tvalid(|ena),  // input wire s_axis_phase_tvalid
    .s_axis_phase_tdata(phase),    // input wire [23 : 0] s_axis_phase_tdata
    .m_axis_dout_tvalid(),    // output wire m_axis_dout_tvalid
    .m_axis_dout_tdata(sin_cos_data)      // output wire [47 : 0] m_axis_dout_tdata
    );
    
    tan tan (
    .M_AXIS_RESULT_tdata(tan_data),
    .M_AXIS_RESULT_tvalid(),
    .clk(clk),
    .s_axis_a_tdata(sin_cos_data[16:0]),
    .s_axis_a_tvalid(1),
    .s_axis_b_tdata(sin_cos_data[40:24]),
    .s_axis_b_tvalid(1)
    );
    
    
endmodule
