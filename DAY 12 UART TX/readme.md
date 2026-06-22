# Day 12 (Part 2): UART Transmitter (TX) FSM 📡

## 📌 Project Overview
As part of the **14-Days RTL-to-DV Development Series**, this project implements an Asynchronous Serializer—the UART Transmitter. Moving from parallel memory systems (SRAM/FIFO) to serial communication, this IP block allows the FPGA to transmit 8-bit parallel data over a single wire (`tx`) to the outside world.

## 🏗️ Hardware Architecture
* **System Clock:** 50 MHz
* **Baud Rate:** 9600 bps
* **Data Frame:** 1 Start Bit (LOW), 8 Data Bits (LSB First), 1 Stop Bit (HIGH)
* **Baud Rate Generator:** A 13-bit counter (`baud_cnt`) divides the 50MHz system clock by 5208 to generate the precise 104us bit-period.
* **FSM Control Engine:** A 4-state Moore/Mealy State Machine (`IDLE` $\rightarrow$ `START` $\rightarrow$ `DATA` $\rightarrow$ `STOP`).

## 🛠️ Toolchain & Synthesis
* **RTL Design & Verification:** Verilog HDL, ModelSim
* **Synthesis & Mapping:** Intel Quartus Prime (Target: Altera Cyclone IV E `EP4CE6E22C6`)
* **Hardware Inference:** Successfully mapped FSM logic, shift registers, and baud counters down to pure Logic Elements (LUTs and Flip-Flops).

## 🔬 Design Verification (DV)
The testbench validates the asynchronous transmission physics:
1. **Clock Division Proof:** Verified the 104us time delta between wire transitions.
2. **Data Integrity:** Injected Hex `0xA5` (Binary `10100101`). Monitored the `tx` wire to ensure accurate LSB-first spatial mapping (`1 -> 0 -> 1 -> 0 -> 0 -> 1 -> 0 -> 1`).
3. **State Transition:** Monitored the synchronous `tx_done` pulse indicating successful frame termination.

## 📸 RTL & Simulation Artifacts
*(Add your screenshots here)*
* `WAVEFORM-UART-ZOOM.png`
* `WAVEFORM-UART-FULL.jpg`
* `TRANSCRIPT.png`
* `RTL-TECH-MAP.png`
* `CHIP-PLANNER.png`