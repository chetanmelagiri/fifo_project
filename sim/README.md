# FIFO Simulation Scripts Guide

Complete guide for running FIFO verification simulations using Python scripts.

## Quick Start

```bash
# Navigate to project root
cd fifo_project

# Validate setup
python3 sim/validate.py

# Run mock simulation (no hardware required)
python3 sim/mock_sim.py

# Run actual simulation (requires Cadence tools)
python3 sim/quick_sim.py
```

## Available Scripts

### 1. **validate.py** - Setup Validation
Checks project structure and simulator availability without running simulations.

```bash
python3 sim/validate.py
```

**Output:**
- ✓ Validates all 20+ required source files
- ✓ Checks for Cadence simulator (`irun`)
- ✓ Verifies UVM library installation
- Provides file statistics and project summary

### 2. **mock_sim.py** - Mock Simulator
Simulates FIFO operation without requiring actual simulator (useful for testing, CI/CD, demos).

```bash
# Run default test
python3 sim/mock_sim.py

# Run specific test
python3 sim/mock_sim.py -t seq_2_test

# Run with specific seed
python3 sim/mock_sim.py -t seq_1_test -s 12345
```

**Features:**
- No hardware dependencies
- Simulates all test patterns
- Generates mock waveforms and logs
- Provides simulation reports
- Perfect for testing script infrastructure

### 3. **quick_sim.py** - Quick Simulator
Lightweight wrapper for actual Cadence simulator.

```bash
# Run from project root
cd fifo_project
python3 sim/quick_sim.py

# Run specific test
python3 sim/quick_sim.py seq_2_test

# Run with GUI
python3 sim/quick_sim.py seq_1_test --gui
```

**Usage:**
```
python3 quick_sim.py [test_name] [--gui]
```

### 4. **run_sim.py** - Full-Featured Simulator
Comprehensive simulator with extensive options and reporting.

```bash
# Basic usage
python3 sim/run_sim.py

# With options
python3 sim/run_sim.py -t seq_2_test -g -s 12345

# Clean artifacts
python3 sim/run_sim.py --clean

# Validate project
python3 sim/run_sim.py --check
```

**Options:**
| Option | Description |
|--------|-------------|
| `-t, --test` | Test name (default: seq_1_test) |
| `-g, --gui` | Run with GUI |
| `-s, --seed` | Random seed |
| `--clean` | Clean artifacts |
| `--check` | Validate project |

## Available Tests

| Test | Description | Write | Read |
|------|-------------|-------|------|
| seq_1_test | Basic write/read | 10 items | 8 items |
| seq_2_test | Sequential operations | Mixed | Mixed |
| seq_3_test | Back-to-back | Continuous | Continuous |
| seq_4_test | Stress pattern | Heavy | Heavy |
| seq_5_test | Extended operations | 20+ items | 20+ items |

## Usage Examples

### Development Workflow
```bash
# 1. Validate setup
python3 sim/validate.py

# 2. Test with mock simulator
python3 sim/mock_sim.py -t seq_1_test

# 3. Try different test
python3 sim/mock_sim.py -t seq_3_test -s 42

# 4. View detailed options
python3 sim/run_sim.py --help
```

### Regression Testing
```bash
# Run multiple tests with different seeds
for seed in {1..5}; do
  python3 sim/quick_sim.py seq_1_test --seed $seed
done
```

### CI/CD Pipeline
```bash
# Validate structure
python3 sim/validate.py || exit 1

# Run tests
python3 sim/mock_sim.py -t seq_1_test || exit 1
python3 sim/mock_sim.py -t seq_2_test || exit 1
python3 sim/mock_sim.py -t seq_3_test || exit 1

echo "All tests passed!"
```

### Debugging with GUI
```bash
# Run with graphical waveform viewer
python3 sim/run_sim.py -g -t seq_1_test

# Keep waveform for analysis
# (files saved in sim/ directory)
```

## Script Features Summary

| Feature | validate.py | mock_sim.py | quick_sim.py | run_sim.py |
|---------|------------|------------|-------------|-----------|
| File validation | ✓ | - | - | ✓ |
| Simulator check | ✓ | - | - | ✓ |
| UVM check | ✓ | - | - | ✓ |
| Mock simulation | - | ✓ | - | - |
| Real simulation | - | - | ✓ | ✓ |
| GUI support | - | - | ✓ | ✓ |
| Seed control | - | ✓ | - | ✓ |
| Cleanup | - | - | - | ✓ |
| Detailed logging | - | - | - | ✓ |
| Project summary | ✓ | ✓ | - | ✓ |

## Environment Variables

Optional configuration:

```bash
# Set custom UVM path
export UVM_HOME=/path/to/uvm

# Set Cadence install path
export CDS_ROOT=/path/to/cadence

# Run script
python3 sim/run_sim.py
```

## Directory Structure

```
fifo_project/
├── sim/
│   ├── validate.py          # Setup validator
│   ├── mock_sim.py          # Mock simulator
│   ├── quick_sim.py         # Quick runner
│   ├── run_sim.py           # Full-featured runner
│   ├── Makefile             # Traditional make build
│   └── simulation.log       # Generated log
├── rtl/
│   ├── fifo.v
│   └── fifo_if.sv
├── tb/
│   ├── top.sv
│   ├── tb.sv
│   └── ...
├── test/
│   ├── test_pkg.sv
│   └── test.sv
├── wr_agt_top/
│   └── (write agent files)
├── rd_agt_top/
│   └── (read agent files)
└── SIM_README.md            # This file
```

## Troubleshooting

### Script not found
```bash
# Make sure you're in project root
cd /home/chetanmelagiri/fifo_project

# Run from correct path
python3 sim/validate.py
```

### "irun" command not found
```bash
# Install Cadence tools or add to PATH
export PATH=$PATH:/path/to/cadence/bin

# Or use mock simulator (no tools needed)
python3 sim/mock_sim.py
```

### UVM library not found
```bash
# Set UVM_HOME
export UVM_HOME=/path/to/uvm

# Or update path in scripts
# Edit run_sim.py and quick_sim.py: self.uvm_home = "..."
```

### Permission denied
```bash
# Make scripts executable
chmod +x sim/*.py

# Or run with python3
python3 sim/validate.py
```

## Logging and Output

### Simulation Log
- Location: `sim/simulation.log`
- Contains: All UVM messages and test results
- View: `cat sim/simulation.log`

### Waveform Files
Generated during actual simulation (Cadence only):
- `.shm` - Waveform database
- `.vcd` - Value change dump (if configured)

### Mock Simulator Output
- Printed to console
- Shows simulated operations
- No files generated

## Advanced Usage

### Run with Custom Configuration
Edit `run_sim.py` before running:
```python
self.uvm_home = "/custom/path/to/uvm"
```

### Batch Testing
```bash
#!/bin/bash
for test in seq_1_test seq_2_test seq_3_test; do
    echo "Running $test..."
    python3 sim/mock_sim.py -t $test
done
```

### Integration with Make
```bash
# Traditional make (if preferred)
cd sim
make cmdrun

# Or use Python scripts
python3 run_sim.py
```

## Performance Notes

- **mock_sim.py**: < 1 second per test
- **quick_sim.py**: Seconds to minutes (depends on simulator)
- **run_sim.py**: Similar to quick_sim.py with additional overhead

## Support

For issues or improvements:
1. Check error messages in `simulation.log`
2. Run `python3 sim/validate.py` to diagnose
3. Review script comments for detailed documentation
4. Check project README.md for UVM/testbench specifics

---

**Last Updated:** November 15, 2025
**Python Version:** 3.6+
**Supported Simulators:** Cadence IUS/Xcelium with UVM
