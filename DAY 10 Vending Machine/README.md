# 🛒 Day 10: Vending Machine Controller (FSM + Datapath)

## 📝 Objective
Design, synthesize, and verify a **Vending Machine Controller** using Verilog. This project marks a significant milestone in the 14-Days RTL-to-DV series by integrating a **Control Path (Finite State Machine)** with a **Datapath (Mathematical Addition)** to create a functional hardware controller.

## ⚙️ Specifications
* **Product Price:** ₹15
* **Accepted Coins (Inputs):** * ₹5 (Binary: `01`)
  * ₹10 (Binary: `10`)
* **Outputs:** * `dispense`: Triggers when accumulated amount reaches or exceeds ₹15.
  * `change`: Returns the excess amount (₹5) if ₹20 is inserted.

## 🧠 FSM Architecture (Moore Machine)
The controller navigates through 5 states representing the accumulated money:
1. `S_0` (₹0) - Initial State / Standby
2. `S_5` (₹5)
3. `S_10` (₹10)
4. `S_15` (₹15) - **Target Reached:** Triggers `dispense = 1`, `change = 0`.
5. `S_20` (₹20) - **Overflow:** Triggers `dispense = 1`, `change = 5`.

## 🛠️ Tools & Technologies Used
* **Verilog HDL:** RTL coding and Testbench creation.
* **ModelSim:** RTL Simulation and Design Verification (DV).
* **Intel Quartus Prime (MAX 10 Device):** * Gate-level Synthesis
  * RTL Viewer & State Machine Viewer
  * **Pin Planner & Chip Planner:** Explored physical silicon mapping, IC pinouts, and logic element (LE) floorplanning.

## 🔬 Verification (Test Cases Passed)
1. **Exact Change:** Inserted ₹5 + ₹5 + ₹5 ➡️ Dispensed (Change: ₹0).
2. **Fast Exact Change:** Inserted ₹10 + ₹5 ➡️ Dispensed (Change: ₹0).
3. **Overflow Condition:** Inserted ₹10 + ₹10 ➡️ Dispensed (Change: ₹5).

---
*This project is part of the 14-Days RTL-to-DV Challenge. Exploring the intersection of Control Logic and Digital Datapaths.*