#!/usr/bin/env python3
"""
FIFO Simulation Test & Validation Script
Validates setup and provides simulation reporting
"""

import subprocess
import sys
from pathlib import Path
import json
from datetime import datetime

class FIFOSimTester:
    """Test and validate FIFO simulation setup"""
    
    def __init__(self):
        self.script_dir = Path(__file__).resolve().parent
        self.project_root = self.script_dir.parent
        self.rtl_dir = self.project_root / "rtl"
        self.tb_dir = self.project_root / "tb"
        self.test_dir = self.project_root / "test"
        self.wr_agt_dir = self.project_root / "wr_agt_top"
        self.rd_agt_dir = self.project_root / "rd_agt_top"
        
    def check_files(self):
        """Check if all required files exist"""
        files = {
            "RTL": [
                self.rtl_dir / "fifo.v",
                self.rtl_dir / "fifo_if.sv",
            ],
            "Testbench": [
                self.tb_dir / "top.sv",
                self.tb_dir / "tb.sv",
                self.tb_dir / "env_config.sv",
                self.tb_dir / "scoreboard.sv",
                self.tb_dir / "virtual_sequencer.sv",
                self.tb_dir / "virtual_seqs.sv",
            ],
            "Test": [
                self.test_dir / "test_pkg.sv",
                self.test_dir / "test.sv",
            ],
            "Write Agent": [
                self.wr_agt_dir / "wr_agent.sv",
                self.wr_agt_dir / "wr_driver.sv",
                self.wr_agt_dir / "wr_monitor.sv",
                self.wr_agt_dir / "wr_seqs.sv",
                self.wr_agt_dir / "write_xtn.sv",
            ],
            "Read Agent": [
                self.rd_agt_dir / "rd_agent.sv",
                self.rd_agt_dir / "rd_driver.sv",
                self.rd_agt_dir / "rd_monitor.sv",
                self.rd_agt_dir / "rd_seqs.sv",
                self.rd_agt_dir / "read_xtn.sv",
            ]
        }
        
        print("\n" + "="*70)
        print("FILE STRUCTURE VALIDATION")
        print("="*70)
        
        results = {}
        total = 0
        found = 0
        
        for category, file_list in files.items():
            print(f"\n{category}:")
            category_found = 0
            for file_path in file_list:
                exists = file_path.exists()
                status = "✓" if exists else "✗"
                print(f"  {status} {file_path.name}")
                total += 1
                if exists:
                    found += 1
                    category_found += 1
            results[category] = f"{category_found}/{len(file_list)}"
        
        print(f"\n{'='*70}")
        print(f"Total Files: {found}/{total} found")
        print(f"{'='*70}")
        
        return found == total, results
    
    def check_simulator(self):
        """Check if simulator is available"""
        print("\n" + "="*70)
        print("SIMULATOR CHECK")
        print("="*70)
        
        try:
            result = subprocess.run(
                ["which", "irun"],
                capture_output=True,
                text=True
            )
            if result.returncode == 0:
                print(f"✓ irun found: {result.stdout.strip()}")
                return True
            else:
                print("✗ irun not found in PATH")
                print("  Install Cadence IUS/Xcelium or add to PATH")
                return False
        except Exception as e:
            print(f"✗ Error checking simulator: {e}")
            return False
    
    def check_uvm(self):
        """Check if UVM is available"""
        print("\n" + "="*70)
        print("UVM LIBRARY CHECK")
        print("="*70)
        
        uvm_home = "/cad/INCISIV131/tools/uvm/uvm_lib/uvm_sv"
        if Path(uvm_home).exists():
            print(f"✓ UVM found at: {uvm_home}")
            return True
        else:
            print(f"✗ UVM not found at default location: {uvm_home}")
            print("  Set UVM_HOME environment variable to correct path")
            return False
    
    def generate_report(self):
        """Generate validation report"""
        print("\n" + "="*70)
        print("PROJECT SUMMARY")
        print("="*70)
        
        print(f"Project Root: {self.project_root}")
        print(f"Script Directory: {self.script_dir}")
        print(f"Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
        # Count files
        sv_files = list(self.project_root.rglob("*.sv"))
        v_files = list(self.project_root.rglob("*.v"))
        py_files = list(self.project_root.rglob("*.py"))
        
        print(f"\nFile Statistics:")
        print(f"  SystemVerilog (.sv): {len(sv_files)}")
        print(f"  Verilog (.v): {len(v_files)}")
        print(f"  Python (.py): {len(py_files)}")
        print(f"  Total: {len(sv_files) + len(v_files) + len(py_files)}")

def main():
    """Main entry point"""
    tester = FIFOSimTester()
    
    print("\n" + "#"*70)
    print("# FIFO VERIFICATION TESTBENCH - SETUP VALIDATION")
    print("#"*70)
    
    # Check files
    files_ok, file_results = tester.check_files()
    
    # Check simulator
    sim_ok = tester.check_simulator()
    
    # Check UVM
    uvm_ok = tester.check_uvm()
    
    # Generate report
    tester.generate_report()
    
    # Final status
    print("\n" + "="*70)
    print("VALIDATION SUMMARY")
    print("="*70)
    print(f"Files:     {'✓ PASS' if files_ok else '✗ FAIL'}")
    print(f"Simulator: {'✓ PASS' if sim_ok else '⚠ WARNING'}")
    print(f"UVM:       {'✓ PASS' if uvm_ok else '⚠ WARNING'}")
    
    if files_ok:
        print("\n✓ Project structure is valid!")
        print("\nNext steps:")
        print("  1. Run simulation: python3 sim/quick_sim.py")
        print("  2. View detailed help: python3 sim/run_sim.py --help")
        print("  3. Validate again: python3 sim/validate.py")
    else:
        print("\n✗ Project structure has issues. Please fix before simulating.")
        return 1
    
    if not sim_ok or not uvm_ok:
        print("\n⚠ Simulator or UVM not found. Simulation will not work.")
        print("  Please install Cadence tools and set UVM_HOME environment variable.")
        return 1
    
    print("\n" + "="*70)
    return 0

if __name__ == "__main__":
    sys.exit(main())
