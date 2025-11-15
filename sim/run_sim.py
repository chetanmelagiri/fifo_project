#!/usr/bin/env python3
"""
FIFO Simulation Runner Script
Automates compilation and simulation of the FIFO verification testbench
"""

import os
import sys
import subprocess
import argparse
from pathlib import Path
from datetime import datetime

class FIFOSimRunner:
    """Manages FIFO simulation execution"""
    
    def __init__(self, project_root=None):
        """Initialize simulator with project root path"""
        if project_root is None:
            # Get the project root (parent of sim directory)
            self.sim_dir = Path(__file__).parent
            self.project_root = self.sim_dir.parent
        else:
            self.project_root = Path(project_root)
            self.sim_dir = self.project_root / "sim"
        
        self.rtl_dir = self.project_root / "rtl"
        self.tb_dir = self.project_root / "tb"
        self.test_dir = self.project_root / "test"
        self.wr_agt_dir = self.project_root / "wr_agt_top"
        self.rd_agt_dir = self.project_root / "rd_agt_top"
        
        self.uvm_home = "/cad/INCISIV131/tools/uvm/uvm_lib/uvm_sv"
        self.log_file = self.sim_dir / "simulation.log"
        self.timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
    def validate_paths(self):
        """Verify all required paths exist"""
        paths = {
            "Project Root": self.project_root,
            "RTL Directory": self.rtl_dir,
            "TB Directory": self.tb_dir,
            "Test Directory": self.test_dir,
            "WR Agent Directory": self.wr_agt_dir,
            "RD Agent Directory": self.rd_agt_dir,
            "Sim Directory": self.sim_dir
        }
        
        print("\n" + "="*60)
        print("VALIDATING PROJECT STRUCTURE")
        print("="*60)
        
        all_valid = True
        for name, path in paths.items():
            exists = path.exists()
            status = "✓" if exists else "✗"
            print(f"{status} {name}: {path}")
            if not exists:
                all_valid = False
        
        return all_valid
    
    def get_source_files(self):
        """Collect all source files for compilation"""
        files = {
            "RTL Files": [
                self.rtl_dir / "fifo.v",
                self.rtl_dir / "fifo_if.sv"
            ],
            "Test Package": [
                self.test_dir / "test_pkg.sv"
            ],
            "Testbench": [
                self.tb_dir / "top.sv"
            ]
        }
        
        print("\n" + "="*60)
        print("SOURCE FILES")
        print("="*60)
        
        all_files = []
        for category, file_list in files.items():
            print(f"\n{category}:")
            for file_path in file_list:
                exists = file_path.exists()
                status = "✓" if exists else "✗"
                print(f"  {status} {file_path.name}")
                if exists:
                    all_files.append(str(file_path))
        
        return all_files
    
    def compile_and_simulate(self, test_name="seq_1_test", gui=False, seed=None):
        """Execute compilation and simulation"""
        source_files = self.get_source_files()
        
        if not source_files:
            print("\n✗ ERROR: No source files found!")
            return False
        
        # Build irun command
        cmd = [
            "irun",
            "-access", "rw",
            "-uvmhome", self.uvm_home,
            "+UVM_VERBOSITY=UVM_HIGH"
        ]
        
        # Add seed if specified
        if seed:
            cmd.extend(["-svseed", str(seed)])
        else:
            cmd.extend(["-svseed", "random"])
        
        # Add GUI flag if requested
        if gui:
            cmd.append("-gui")
        else:
            cmd.append("-quiet")
        
        # Add source files
        cmd.extend(source_files)
        
        # Add test name
        cmd.extend(["+UVM_TESTNAME=" + test_name])
        
        # Add output log
        cmd.extend(["-logfile", str(self.log_file)])
        
        print("\n" + "="*60)
        print("SIMULATION COMMAND")
        print("="*60)
        print(" ".join(cmd))
        
        print("\n" + "="*60)
        print("RUNNING SIMULATION")
        print("="*60)
        print(f"Test: {test_name}")
        print(f"Seed: {seed if seed else 'Random'}")
        print(f"GUI: {gui}")
        print(f"Log File: {self.log_file}")
        
        try:
            # Change to sim directory for execution
            os.chdir(self.sim_dir)
            result = subprocess.run(cmd, capture_output=False, text=True)
            
            if result.returncode == 0:
                print("\n✓ Simulation completed successfully!")
                return True
            else:
                print(f"\n✗ Simulation failed with return code {result.returncode}")
                return False
                
        except FileNotFoundError:
            print("\n✗ ERROR: 'irun' command not found!")
            print("  Make sure Cadence tools are properly installed and in PATH")
            return False
        except Exception as e:
            print(f"\n✗ ERROR: {str(e)}")
            return False
    
    def clean(self):
        """Clean simulation artifacts"""
        print("\n" + "="*60)
        print("CLEANING SIMULATION FILES")
        print("="*60)
        
        patterns = [
            "*.log", "*.key", "*.shm", "*.wdb",
            "work", "WORK", "xcelium.d", "xsim.dir",
            "csrc", "simv*", "vc_hdrs.h", "INCA_libs",
            ".simvision", ".xsim_state.log", "*~"
        ]
        
        os.chdir(self.sim_dir)
        
        for pattern in patterns:
            try:
                if "*" in pattern:
                    import glob
                    for file in glob.glob(pattern):
                        Path(file).unlink()
                        print(f"  ✓ Removed: {file}")
                else:
                    path = Path(pattern)
                    if path.exists():
                        if path.is_dir():
                            import shutil
                            shutil.rmtree(path)
                        else:
                            path.unlink()
                        print(f"  ✓ Removed: {pattern}")
            except Exception as e:
                print(f"  ⚠ Could not remove {pattern}: {str(e)}")
        
        print("\n✓ Cleanup complete!")
    
    def print_help(self):
        """Print available tests"""
        tests = [
            "seq_1_test  - Write 10 items, then read 8 items",
            "seq_2_test  - Sequential write/read operations",
            "seq_3_test  - Back-to-back operations",
            "seq_4_test  - Stress test pattern",
            "seq_5_test  - Extended operations"
        ]
        
        print("\n" + "="*60)
        print("AVAILABLE TESTS")
        print("="*60)
        for test in tests:
            print(f"  • {test}")

def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description="FIFO Verification Testbench Simulator",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 run_sim.py                    # Run default test
  python3 run_sim.py -t seq_2_test      # Run specific test
  python3 run_sim.py -g                 # Run with GUI
  python3 run_sim.py -s 12345           # Run with specific seed
  python3 run_sim.py --clean            # Clean artifacts
        """
    )
    
    parser.add_argument(
        "-t", "--test",
        default="seq_1_test",
        help="Test name to run (default: seq_1_test)"
    )
    parser.add_argument(
        "-g", "--gui",
        action="store_true",
        help="Run with GUI (default: quiet mode)"
    )
    parser.add_argument(
        "-s", "--seed",
        type=int,
        help="Random seed for simulation"
    )
    parser.add_argument(
        "--clean",
        action="store_true",
        help="Clean simulation artifacts and exit"
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Validate project structure and exit"
    )
    
    args = parser.parse_args()
    
    # Create simulator instance
    runner = FIFOSimRunner()
    
    # Handle clean operation
    if args.clean:
        runner.clean()
        return 0
    
    # Validate project structure
    if not runner.validate_paths():
        print("\n✗ ERROR: Invalid project structure!")
        return 1
    
    if args.check:
        runner.print_help()
        return 0
    
    # Run simulation
    print("\n" + "="*60)
    print("FIFO VERIFICATION TESTBENCH")
    print("="*60)
    
    runner.print_help()
    
    success = runner.compile_and_simulate(
        test_name=args.test,
        gui=args.gui,
        seed=args.seed
    )
    
    return 0 if success else 1

if __name__ == "__main__":
    sys.exit(main())
