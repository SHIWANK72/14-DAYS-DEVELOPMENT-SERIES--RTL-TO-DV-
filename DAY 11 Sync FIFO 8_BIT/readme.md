# Day 11: Synchronous FIFO (First-In-First-Out) Buffer Design 🚀

## 📌 Objective
To design, implement, and verify an 8-bit wide, 8-word deep Synchronous FIFO Buffer. This project demonstrates how to safely pass data between digital blocks using elastic storage, preventing data loss (overrun) and garbage reads (underrun).

## 🧠 Hardware Architecture
The Synchronous FIFO is built using three primary architectural components:
1. **Memory Array:** An 8x8 Dual-Port RAM (Register File) for data storage.
2. **Read/Write Pointers:** 4-bit Up-Counters. The lower 3 bits act as the memory address, while the 4th bit (MSB) tracks the wrap-around condition.
3. **Status Comparators:** Combinational logic to assert `full` and `empty` flags by comparing the pointer values.

## 🐛 The Debugging Focus: The Wrap-Around Logic
The most critical bug in FIFO design is distinguishing between `full` and `empty` when the read and write pointers point to the exact same memory address. 
* **Solution Implemented:** Added an extra MSB to the pointers. 
  * `Empty`: All 4 bits of `wr_ptr` and `rd_ptr` match exactly.
  * `Full`: The lower 3 bits match, but the MSB is inverted (meaning the write pointer has wrapped around exactly one more time than the read pointer).

## 🛠️ Toolchain Used
* **RTL Design & Simulation:** ModelSim
* **Synthesis & RTL Viewer:** Intel Quartus Prime

## 📊 Verification Results
The testbench successfully validates:
- Sequential Write operations until the `full` flag is triggered.
- Sequential Read operations until the `empty` flag is triggered.
- Simultaneous Read/Write functionality ensuring data integrity without pointer collisions.