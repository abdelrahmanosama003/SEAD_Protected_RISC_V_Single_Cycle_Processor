# SEAD_Protected_RISC_V_Single_Cycle_Processor

This project implements a single-cycle RISC-V processor with protection against soft errors using **interleaved Hamming codes**. The primary goal is to safeguard critical user-visible data — particularly the Program Counter (`count` register) and general-purpose registers — from transient bit flips without interrupting program execution.

## 📁 Directory Structure

```
SEAD_Protected_RISC_V_Single_Cycle_Processor/
├── RTL/
│   ├── <RISC-V design modules>
│   └── protection/
│       └── <Hamming code modules>
├── SIM/
│   ├── run.do
│   ├── wave.do
│   └── Single_Cycle_TB.sv
├── instructions.txt
└── Questasim Fig.png
```

### Folder Descriptions

- **RTL/**: Contains the Verilog RTL for the RISC-V processor. The `protection/` subfolder holds all modules related to Hamming encoding, decoding, and correction logic.
- **SIM/**: Contains simulation artifacts including:
  - `run.do`: TCL script for running the simulation in QuestaSim.
  - `wave.do`: Waveform configuration for signal visualization.
  - `Single_Cycle_TB.sv`: A testbench adapted from an open-source GitHub project.
- **instructions.txt**: Instructions for the processor to execute during simulation.
- **questasim_result.png**: Screenshot showing successful correction of flipped bits during simulation.

## 🛠️ How to Use

1. **Clone the repository**:
   ```bash
   git clone https://github.com/abdelrahmanosama003/SEAD_Protected_RISC_V_Single_Cycle_Processor
   cd SEAD_Protected_RISC_V_Single_Cycle_Processor
   ```

2. **Launch QuestaSim (version 2023.3 recommended)**

3. **Run simulation**:
   ```tcl
   cd SIM
   do run.do
   ```

4. **Observe output and waveform**:
   - At **60 ns**: The 3 MSBs of the `count` register (program counter) are forcibly flipped, but the corrected `count` shows the correct address.
   - At **90 ns**: The 3 MSBs of `registers[3]` are flipped, but `RD1_corrected` still provides the correct value to the datapath.

## 🧪 Testbench Notes

- The testbench was obtained from a public GitHub project and was **not developed from scratch** as part of this repository.
- Its primary function is to validate instruction execution by checking memory contents.
- We **added `force` and `release` statements** in the testbench to simulate fault injection in the PC and register file. Despite these faults, instruction execution remains correct due to Hamming protection.

## ✅ Results

The simulation demonstrates that the processor continues correct execution even after targeted soft errors are injected into critical state elements, thanks to the integrated interleaved Hamming code correction logic.
