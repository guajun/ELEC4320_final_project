`timescale 1ns / 1ps


module function_generater(output reg [15:0] data,
                          input [7:0] control,
                          input [15:0] prescaler,
                          input [15:0] amplitude,
                          input clk);

reg [7:0] mode;

wire square_wave_data;
wire [15:0] triangular_wave_data;
wire [15:0] saw_tooth_wave_data;

always @(posedge control[0])
begin
    case(control[3:1])
        3'b000: mode <= 8'b0000_0001;
        3'b001: mode <= 8'b0000_0010;
        3'b010: mode <= 8'b0000_0100;
        3'b011: mode <= 8'b0000_1000; // square wave
        3'b100: mode <= 8'b0001_0000; // triangular wave
        3'b101: mode <= 8'b0010_0000; // saw tooth wave
        3'b110: mode <= 8'b0100_0000;
        3'b111: mode <= 8'b1000_0000;
    endcase
end

always @(negedge control[0])
begin
    mode <= 0;
    data <= 0;
end

always @(posedge clk)

case(mode)
    8'b0000_0001:;
    8'b0000_0010:;
    8'b0000_0100:;
    8'b0000_1000:data <= square_wave_data?16'hFFFF:16'h0000;
    8'b0001_0000:data <= triangular_wave_data;
    8'b0010_0000:data <= saw_tooth_wave_data;
    8'b0100_0000:;
    8'b1000_0000:;
    
    default: data <= 0;
    
endcase

begin


end

//    trigonometric_wave trigonometric_wave(
//    .clk(clk),
//    .ena(mode[2:0]),
//    .amplitude(amplitude),
//    .prescaler(prescaler),
//    .data(data)
//    );

square_wave square_wave(
.clk(clk),
.ena(mode[3]),
.prescaler(prescaler),
.data(square_wave_data)
);

triangular_wave triangular_wave(
.clk(clk),
.ena(mode[4]),
.amplitude(amplitude),
.prescaler(prescaler),
.data(triangular_wave_data)
);

saw_tooth_wave saw_tooth_wave(
.clk(clk),
.ena(mode[5]),
.amplitude(amplitude),
.prescaler(prescaler),
.data(saw_tooth_wave_data)
);

endmodule
