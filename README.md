# Hardware-Programming
 Hardware description Language
 # VHDL code for 4 bits ALU
 Here are sub designs you must create
1. a 4-bit adder
2. a 4-bit subtractor
3. a 2-to-1 mux (5 outputs 1-bit for carryout/borrow and 4-bit answer)
4. Each of the three sub designs should be a separate VHDL file
You will then make the final larger design called the ALU. The inputs and outputs for your design are
1. 2 4-bit inputs num1 and num2
2. 1-bit input called ALUop to select between the add and subtract. Add is option 0 and subtract is option 1
3. 4-bit output for the result
4. 1-bit output that is the carryout/borrow 
Once the ALU is design you must create a test bench file to simulate the result,
For the simulation you will be showing 4 examples of add and 4 examples of subtract. You do not need to show all the possible combinations. Make sure the examples you select show a 0 and a 1 for each bit of output over the 4 examples.
 # VHDL code for Moore FSM 
You will code up a Moore FSM that can detect the sequence 100 or 010. The output z=1 if the sequence is found.
You need the FSM, test bench, and screenshot of the simulation.Test using the following input 1, 0, 0, 0, 1, 0, 1, 0, 0.
# VHDL for QR code creation

In this project, you will be creating a QR Code like 2D barcode called QR-lite. The QR-lite is a 2D barcode that can encode numbers up to 8 digits long that produce a similar-looking image to a QR Code. To do this project you will be using the ARTY-S7 FPGA, the 7-segment led module, the extra 4 switch module, a PC to receive information, a terminal serial application, and Excel.
