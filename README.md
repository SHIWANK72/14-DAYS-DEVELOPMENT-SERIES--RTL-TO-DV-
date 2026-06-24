# 🚀 14-Day RTL-to-DV Architecture Portfolio

Welcome to my **14-Day Digital Design and Verification Challenge**. 

This repository documents my intensive journey of architecting, designing, and verifying 14+ industry-standard hardware IPs from scratch. Over the course of two weeks, I progressed from fundamental combinational logic to designing complex, fully synthesizable systems like a **16-bit RISC Processor** and a **Micron-Standard SDRAM Controller** with CAS Latency and Auto-Refresh logic.

## 🛠️ Tech Stack & Tools
* **Languages:** SystemVerilog, Verilog HDL
* **Design & Synthesis:** Intel Quartus Prime, Xilinx Vivado (RTL Viewer, Technology Map Viewer, Chip Planner)
* **Verification:** ModelSim / Questa Altera Edition (Self-checking testbenches, SVA alternative procedural checking, Waveform analysis)
* **Methodology:** FSM Design, Constrained Datapath Optimization, Timing Closure, Custom IP Development.

---

## 📂 Project Directory (Day 1 to Day 14)

### Phase 1: Foundational Combinational & Sequential Logic
* **[Day 1: Basic Gates](./DAY%201%20basic%20gates)** - Universal gates and logical operations.
* **[Day 2: MUX & DEMUX](./DAY%202%20mux%20and%20demux)** - Data routing architectures.
* **[Day 3: Adder Implementations](./DAY%203%20Adder-implementation)** - Half/Full adders and ripple carry adders.
* **[Day 4: Decoder & Encoder](./DAY%204%20Decoder-Encoder)** - Logic translation and priority encoding.
* **[Day 5: Flip-Flops (Sync & Async)](./DAY%205%20PART%201%20D-flip%20flop%20sync-Async)** - `D` and `T` flip-flops with synchronous and asynchronous reset strategies.
* **[Day 6: Shift Registers & Counters](./DAY%206%20PART%201%20siso_sipo_bit_up_counter)** - SISO, SIPO, PIPO configurations, Ring Counters, and Up-Counters.

### Phase 2: Control Logic & State Machines
* **[Day 7: Finite State Machines (FSM)](./DAY%207%20Finite%20state%20machine(FSM))** - Mealy and Moore machine implementations.
* **[Day 8: 8-Bit ALU](./DAY%208%208_bit%20ALU)** - Arithmetic Logic Unit supporting arithmetic, logical, and shift operations.
* **[Day 9: Traffic Light Controller](./DAY%209%20Traffic%20Light)** - Multi-state timing control system.
* **[Day 10: Vending Machine](./DAY%2010%20Vending%20Machine)** - Complex FSM handling transaction logic and change dispensing.

### Phase 3: Advanced Protocols, Memory & Processing (The Climax)
* **[Day 11: Memory & FIFOs](./DAY%2011%20PART%202%20SRAM%20CONTROLLER)** - 8-Bit Synchronous FIFO and Custom SRAM Controller.
* **[Day 12: UART Transmitter](./DAY%2012%20UART%20TX)** - Serial communication protocol implementation (Baud rate generation, Start/Stop bits).
* **[Day 13: 16-Bit RISC Processor](./DAY%2013%2016%20BIT%20RISC)** - Full custom RISC architecture. Integrated ALU, Control Unit, and Program Counter logic. Synthesized and verified.
* **[Day 14: Advanced SDRAM Controller](./DAY%2014%20SDRAM%20(SPL%20PJT))** - **(Special Project)** Micron-standard memory interface featuring automated background refresh timers, precise 2-cycle CAS Latency tracking, and robust functional verification.

---

## 🎯 Objective
This portfolio is a testament to my hands-on expertise in the complete **RTL-to-Bitstream** flow. My focus is consistently on writing clean, modular, and 100% synthesizable code (zero latches), paired with rigorous verification environments that catch timing violations and logic bugs early in the cycle. 

## 📫 Let's Connect
I am an FPGA Developer and RTL Design & Verification Engineer open to immediate hardware engineering roles.
* **Email:** gupta.shiwank09@gmail.com
* **LinkedIn:** [Shiwank Gupta](https://linkedin.com/in/guptashiwank)