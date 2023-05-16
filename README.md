# Pipelined-processor

Microprocessors, EE309 - Course Project
Course Instructor- Virendra Singh 

This is a 6-stage pipelined processor, IITB-RISC-23 designed in VHDL. The IITB-RISC-23 is a 16-bit computer system with 8 registers. 
It follows the standard 6 stage pipelines (Instruction fetch, instruction decode, register read, execute, memory access, and write back). The architecture is optimized for performance, i.e., it includes hazard mitigation techniques.

IITB-RISC Instruction Set Architecture: 
This architecture uses condition code register which has two flags Carry flag ( C ) and Zero flag (Z). The IITB-RISC-23 is very simple, but it is general enough to solve complex problems. The architecture allows predicated instruction execution and multiple load and store execution. There are three machine code instruction formats (R, I, and J type) and a total of 25 instructions.
