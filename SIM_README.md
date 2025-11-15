# FIFO Simulation Scripts

This directory contains Python scripts to automate FIFO verification testbench simulation.

## Scripts Overview

### 1. `run_sim.py` - Full-Featured Simulator
Comprehensive simulation runner with extensive options and error checking.

**Usage:**
```bash
python3 run_sim.py [options]
```

**Options:**
- `-t, --test TEST_NAME` : Specify test to run (default: seq_1_test)
- `-g, --gui` : Run with graphical interface
- `-s, --seed SEED` : Set random seed for reproducibility
- `--clean` : Remove all simulation artifacts
- `--check` : Validate project structure

**Examples:**
```bash
# Run default test (seq_1_test)
python3 run_sim.py

# Run with GUI
python3 run_sim.py -g

# Run specific test with seed
python3 run_sim.py -t seq_2_test -s 12345

# Clean simulation files
python3 run_sim.py --clean

# Validate project structure
python3 run_sim.py --check
```

### 2. `quick_sim.py` - Quick Simulation
Lightweight script for rapid simulation runs.

**Usage:**
```bash
python3 quick_sim.py [test_name] [--gui]
```

**Examples:**
```bash
# Run default test
python3 quick_sim.py

# Run specific test
python3 quick_sim.py seq_1_test

# Run with GUI
python3 quick_sim.py seq_2_test --gui
```

## Available Tests

| Test | Description |
|------|-------------|
| `seq_1_test` | Write 10 items, then read 8 items |
| `seq_2_test` | Sequential write/read operations |
| `seq_3_test` | Back-to-back operations |
| `seq_4_test` | Stress test pattern |
| `seq_5_test` | Extended operations |

## Features of run_sim.py

1. **Project Validation**: Checks all directories and files exist
2. **Source File Detection**: Automatically locates all source files
3. **Flexible Test Selection**: Run any defined test
4. **Seed Control**: Reproducible simulations with specific seeds
5. **GUI Mode**: Optional graphical waveform viewer
6. **Cleanup**: Removes simulation artifacts
7. **Logging**: Detailed simulation logs with timestamps
8. **Error Handling**: Comprehensive error detection and reporting

## Requirements

- Python 3.6+
- Cadence IUS/Xcelium simulator with irun installed
- UVM library installed
- Project files properly organized in subdirectories

## Installation

Make scripts executable:
```bash
chmod +x run_sim.py quick_sim.py
```

## Running from Project Root

```bash
cd fifo_project
python3 sim/run_sim.py
```

## Simulation Artifacts

The following files are generated during simulation:
- `simulation.log` - Detailed simulation log
- `work/` - Compiled design library
- `*.shm` - Waveform database
- `.simvision/` - Waveform viewer data

## Cleaning Up

Remove all simulation artifacts:
```bash
python3 run_sim.py --clean
```

Or use the Makefile:
```bash
make -C sim clean
```

## Troubleshooting

### "irun" command not found
- Ensure Cadence tools are installed and in PATH
- Check that `$UVM_HOME` environment variable is set

### Project structure validation fails
- Verify all subdirectories exist: rtl/, tb/, test/, wr_agt_top/, rd_agt_top/
- Run `python3 run_sim.py --check` to validate

### Simulation fails
- Check `simulation.log` for errors
- Verify all source files are present
- Try running with a specific seed for reproducibility

## Tips

1. **For Development**: Use `quick_sim.py` for fast iteration
2. **For Regression**: Use `run_sim.py` with different seeds
3. **For Debugging**: Run with `--gui` to view waveforms
4. **For Automation**: Call `run_sim.py` from CI/CD scripts

## Environment Variables

Optional environment variables:
- `UVM_HOME` - Path to UVM library (overrides default)
- `SEED` - Default random seed for simulations

Example:
```bash
export UVM_HOME=/path/to/uvm
export SEED=42
python3 run_sim.py
```
