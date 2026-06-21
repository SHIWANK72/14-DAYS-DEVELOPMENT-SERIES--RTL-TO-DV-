# Day 12 (Part 1): Synchronous Single-Port SRAM Memory Controller 💾

## 📌 Project Overview
As part of the **14-Days RTL-to-DV Development Series**, this project bridges the gap between custom IC transistor-level design and digital system-level architecture. Building upon my previous experience of designing a full-custom 6T SRAM cell at the SPICE level, today's objective was to design the digital brain that manages these memory arrays: a **Synchronous SRAM Controller**.

## 🏗️ Hardware Architecture
Unlike sequential memory (FIFO), SRAM allows random access to any memory location using an address bus.
* **Memory Depth:** 16 Words
* **Data Width:** 8-bit
* **Address Bus:** 4-bit (`[3:0] addr`)
* **Control Signals:** Write Enable (`we`), Read Enable (`re`), Synchronous Clock (`clk`)

## 🛠️ Toolchain & Synthesis
* **RTL Design & Verification:** Verilog HDL, ModelSim
* **Synthesis & Mapping:** Intel Quartus Prime (Target: Altera Cyclone V `5CGXFC7C7F23C8`)
* **Hardware Inference:** Quartus successfully inferred the 2D register array and mapped it directly to the FPGA's native `altsyncram` block RAMs, highly optimizing the physical layout.

## 🔬 Design Verification (DV)
The testbench follows a strict directed stress-test methodology:
1. **System Reset:** Initialization to a safe state.
2. **Burst Write (Sweep):** Iterated through all 16 addresses, injecting random 8-bit hex data.
3. **Burst Read (Sweep):** Addressed all 16 locations to verify 100% data retention and accurate synchronous retrieval without corruption.

## 📸 RTL & Simulation Artifacts
*(Add your screenshots here)*
* `WAVEFORM-SRAM.png`
* `RTL-VIEWER.png`
* `TECH-MAP-altsyncram.png`
* `DV-TRANSCRIPT.png`