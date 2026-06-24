# Day 14: Advanced SDRAM Controller with CAS Latency & Auto-Refresh

## Project Overview
This project delivers a high-performance, industry-standard **SDRAM Controller** designed and verified using **SystemVerilog**. The design accurately models the complex timing and command sequences required by physical DRAM architectures (like Micron standard protocols). It features fully synthesizable control logic, a background auto-refresh mechanism, and precise CAS Latency tracking.

The entire design flow—from RTL architectural design to simulation and physical FPGA synthesis—has been successfully executed and validated.

## Key Features
- **Modular RTL Architecture:** Separation of concerns between core FSM control and timing/refresh counters to guarantee 100% synthesizable code with zero inferred latches.
- **5-State Command FSM:** Implementation of `IDLE`, `ACT` (Activate Row), `READ`, `WRITE`, and `REFRESH` states.
- **CAS Latency Management:** Hardware tracking for a deterministic 2-cycle CAS Latency before asserting `data_valid` during read operations.
- **Autonomous Auto-Refresh Logic:** Integrated background counter that periodically forces the system into a safety `REFRESH` cycle every 100 clock periods to prevent data degradation.
- **Self-Checking Testbench Architecture:** Procedural testbench built in SystemVerilog using continuous monitoring and timeline checkers to catch timing violations during simulation.

## Design and Verification Flow

### 1. Functional Verification (ModelSim)
The simulation cleanly validates command tracking and the 2-cycle CAS Latency delay. When a `READ` command is sampled, the FSM moves instantly to the read state, pulls `cas_n` low, and activates the internal latency counter. Exactly after 2 clock cycles, the `data_valid` flag toggles high.
- **Simulator:** ModelSim / Questa Altera Edition
- **Result:** Functional coverage achieved with zero timing errors.

### 2. RTL & Technology Synthesis (Intel Quartus Prime)
The RTL code was synthesized targeting the Altera Cyclone FPGA architecture.
- **Analysis & Synthesis Status:** Successful (0 Errors, 0 Latch Warnings).
- **Resource Utilization:** 24 Logic Cells, 5 Input Pins, 4 Output Pins.
- **Fitter & Placer:** Successfully completed full place-and-route optimization and physical pin mapping.
- **Timing Analyzer:** Validated structural setup and hold slacks under multi-corner slow/fast models.

## Repository Structure
```text
├── sdram_controller.sv        # Synthesizable RTL Design (FSM & Logic)
├── tb_sdram.sv                # Self-Checking SystemVerilog Testbench
├── README.md                  # Project Documentation
└── documentation_images/      # Hardware Verification Evidence
    ├── WAVEFORM-SDRAM CON.png
    ├── STATE DIAGRAM - SDRAM CON.png
    ├── RTL VIEW - SDRAM CON.png
    ├── POST MAPPING VIEW-SDRAM CON.png
    └── CHIP PLANNER-SDRAM CON.png