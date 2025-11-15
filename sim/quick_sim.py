#!/usr/bin/env python3
"""
Simple FIFO Simulation Utility
Quick simulation runner for FIFO testbench
"""

import subprocess
import sys
from pathlib import Path

def run_simulation(test="seq_1_test", gui=False):
    """Run FIFO simulation"""
    
    # Get paths
    sim_dir = Path(__file__).resolve().parent
    project_root = sim_dir.parent
    rtl_dir = project_root / "rtl"
    tb_dir = project_root / "tb"
    test_dir = project_root / "test"
    
    # Build command
    cmd = [
        "irun",
        "-access", "rw",
        "-svseed", "random",
        "-uvmhome", "/cad/INCISIV131/tools/uvm/uvm_lib/uvm_sv",
        "+UVM_VERBOSITY=UVM_HIGH"
    ]
    
    if not gui:
        cmd.append("-quiet")
    else:
        cmd.append("-gui")
    
    # Add files
    cmd.extend([
        str(rtl_dir / "fifo.v"),
        str(rtl_dir / "fifo_if.sv"),
        str(test_dir / "test_pkg.sv"),
        str(tb_dir / "top.sv")
    ])
    
    print(f"Running test: {test}")
    print(f"GUI Mode: {gui}")
    print("-" * 50)
    
    try:
        result = subprocess.run(cmd, cwd=sim_dir)
        return result.returncode
    except Exception as e:
        print(f"Error: {e}")
        return 1

if __name__ == "__main__":
    test_name = sys.argv[1] if len(sys.argv) > 1 else "seq_1_test"
    gui_mode = "--gui" in sys.argv
    
    exit_code = run_simulation(test_name, gui_mode)
    sys.exit(exit_code)
