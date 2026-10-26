# Parameterized Asynchronous FIFO in SystemVerilog & Verilog

A robust, parameterized Asynchronous First-In-First-Out (FIFO) buffer design tailored for reliable clock domain crossing (CDC) in digital systems and SoC interconnects.

## 🚀 Features
* **Parameterization**: Configurable data width (`DATA_WIDTH`) and FIFO depth (`FIFO_DEPTH`) to suit varying memory and throughput requirements.
* **Clock Domain Crossing (CDC)**: Implements 2-stage synchronizers and Gray-code pointer conversion to prevent metastability issues between asynchronous read and write clock domains.
* **Pointers & Status Flags**: Gray-code pointer arithmetic coupled with full, empty, almost-full, and almost-empty flag generation logic.
* **Verification**: Thoroughly verified with self-checking testbenches and simulation waveforms.

## 📂 Project Structure
```text
├── design.sv          # Top-level Asynchronous FIFO module
├── fifo_mem.v         # True dual-port RAM memory block
├── rptr_handler.v     # Read pointer & empty flag generation (Gray code)
├── wptr_handler.v     # Write pointer & full flag generation (Gray code)
├── synchronizer.v     # 2-stage CDC synchronizer logic
└── testbench.sv       # Testbench / verification environment
🛠️ Theory of Operation
Gray Code Pointers: Binary pointers are converted to Gray code before crossing clock domains to ensure only one bit changes at any given time, preventing multi-bit transition errors.

Two-Stage Synchronization: Synchronizer flip-flops mitigate metastability when pointers cross over into the alternate clock domain.

Full/Empty Generation: Full and empty conditions are detected by comparing the synchronized pointers with appropriate wrap-around and MSB logic.

💻 How to Simulate
You can run this project using EDA Playground or any standard HDL simulator (like ModelSim, QuestaSim, or Vivado):

Compile all design files (design.sv, fifo_mem.v, rptr_handler.v, wptr_handler.v, synchronizer.v).

Compile the testbench testbench.sv.

Run the simulation and observe assertion checks and waveform outputs.
