#!/usr/bin/env python3
"""
FIFO Batch Test Runner
Run multiple tests with different configurations
"""

import sys
import subprocess
from pathlib import Path
from datetime import datetime
import json

class BatchTestRunner:
    """Run multiple FIFO tests"""
    
    def __init__(self, simulator="mock"):
        self.simulator = simulator  # "mock" or "real"
        self.script_dir = Path(__file__).resolve().parent
        self.project_root = self.script_dir.parent
        self.results = []
        
        if simulator == "mock":
            self.sim_script = "mock_sim.py"
        else:
            self.sim_script = "quick_sim.py"
    
    def run_test(self, test_name, seed=None):
        """Run a single test"""
        cmd = ["python3", str(self.script_dir / self.sim_script), "-t", test_name]
        
        if seed:
            cmd.extend(["-s", str(seed)])
        
        print(f"\n{'='*70}")
        print(f"Running: {test_name}" + (f" (seed={seed})" if seed else ""))
        print('='*70)
        
        try:
            result = subprocess.run(
                cmd,
                cwd=self.project_root,
                capture_output=True,
                text=True,
                timeout=60
            )
            
            success = result.returncode == 0
            self.results.append({
                "test": test_name,
                "seed": seed,
                "status": "PASSED" if success else "FAILED",
                "returncode": result.returncode
            })
            
            # Print output
            if result.stdout:
                print(result.stdout)
            if result.stderr and not success:
                print("STDERR:", result.stderr)
            
            return success
            
        except subprocess.TimeoutExpired:
            print(f"✗ Test timeout (>60s)")
            self.results.append({
                "test": test_name,
                "seed": seed,
                "status": "TIMEOUT",
                "returncode": -1
            })
            return False
        except Exception as e:
            print(f"✗ Error: {e}")
            self.results.append({
                "test": test_name,
                "seed": seed,
                "status": "ERROR",
                "returncode": -1
            })
            return False
    
    def run_suite(self, tests, num_seeds=1):
        """Run multiple tests with different seeds"""
        print("\n" + "#"*70)
        print("# FIFO BATCH TEST RUNNER")
        print("#"*70)
        print(f"Simulator: {self.simulator.upper()}")
        print(f"Tests: {', '.join(tests)}")
        print(f"Seeds per test: {num_seeds}")
        print(f"Total runs: {len(tests) * num_seeds}")
        print("#"*70)
        
        for test in tests:
            if num_seeds == 1:
                self.run_test(test)
            else:
                for seed in range(num_seeds):
                    self.run_test(test, seed=seed)
        
        self.print_summary()
    
    def print_summary(self):
        """Print test summary"""
        print("\n" + "="*70)
        print("TEST SUMMARY")
        print("="*70)
        
        passed = sum(1 for r in self.results if r["status"] == "PASSED")
        failed = sum(1 for r in self.results if r["status"] == "FAILED")
        timeout = sum(1 for r in self.results if r["status"] == "TIMEOUT")
        error = sum(1 for r in self.results if r["status"] == "ERROR")
        
        for result in self.results:
            status_symbol = "✓" if result["status"] == "PASSED" else "✗"
            seed_str = f" (seed={result['seed']})" if result['seed'] else ""
            print(f"{status_symbol} {result['test']}{seed_str}: {result['status']}")
        
        print("\n" + "-"*70)
        print(f"Total: {len(self.results)}")
        print(f"Passed: {passed}")
        print(f"Failed: {failed}")
        print(f"Timeout: {timeout}")
        print(f"Error: {error}")
        print("-"*70)
        
        if failed == 0 and timeout == 0 and error == 0:
            print("\n✓ ALL TESTS PASSED!")
            return 0
        else:
            print("\n✗ SOME TESTS FAILED!")
            return 1

def main():
    """Main entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(
        description="FIFO Batch Test Runner",
        epilog="""
Examples:
  python3 batch_test.py                    # Run all tests once with mock sim
  python3 batch_test.py --tests seq_1_test seq_2_test
  python3 batch_test.py -s 3               # Run each test with 3 different seeds
  python3 batch_test.py --real             # Use actual simulator
        """
    )
    
    parser.add_argument(
        "--tests",
        nargs="+",
        default=["seq_1_test", "seq_2_test", "seq_3_test"],
        help="Tests to run"
    )
    
    parser.add_argument(
        "-s", "--seeds",
        type=int,
        default=1,
        help="Number of random seeds per test"
    )
    
    parser.add_argument(
        "--real",
        action="store_true",
        help="Use real simulator (default: mock)"
    )
    
    args = parser.parse_args()
    
    simulator = "real" if args.real else "mock"
    runner = BatchTestRunner(simulator=simulator)
    
    exit_code = runner.run_suite(args.tests, args.seeds)
    return exit_code

if __name__ == "__main__":
    sys.exit(main())
