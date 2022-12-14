# ELEC4320_final_project

## Interface Registers Description

### [7:0] control 
+ Bit 0

    0 - Disable the module

    1 - Enable the module

    Other registers can be only modified when this bit is reset

    Reset value: 0

+ Bit 3:1

    000 - cosine

    001 - sine

    010 - tangent

    011 - square wave

    100 - triangular wave

    101 - saw tooth wave

    110 - Users' wave(disable DMA)

    111 - Users' wave(Enable DMA)

    Reset value: 000


### [15:0] amplitude

+ Bit 15:0

    Amplitude of output when in **triangular wave**, and **saw tooth wave** mode

    Lowerbound of domain when in **trigonometric function wave** mode

### [15:0] prescaler 

+ Bit 15:0

    Prescaler of input clock when in **square wave**, **triangular wave**, **saw tooth wave**, and **Users' wave(Enable DMA)**

    Upperbound of domain when in **trigonometric function wave** mode

    The upperbound smaller than the lowerbound is supported because of the periodicity.


<!-- ## Look-Up Table

BRAM 1

+ Length: 65536

+ Width: 16

Store sine wave in $[0, \frac{\pi}{2}]$

BRAM 1

+ Length: 65536

+ Width: 16

Store tangent wave in $[0, \frac{\pi}{2}]$


`./table_gen` is the directory of the **matlab code** to generate the table -->

## Cordic

The **AXI-Stream** IP core for calculating sin and cos

Replace BRAM to save the resource

***Showoff understanding of AXI protocal***