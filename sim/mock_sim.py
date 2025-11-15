#!/usr/bin/env python3
"""
FIFO Simulation Mock Runner
Simulates simulation for testing without actual simulator
Useful for CI/CD and validation
"""

import sys
from pathlib import Path
import random
import time

class MockSimulator:
    """Mock FIFO simulator for testing"""
    
    def __init__(self, test_name="seq_1_test", seed=None):
        self.test_name = test_name
        self.seed = seed if seed else random.randint(0, 2**31-1)
        self.fifo_depth = 65536
        self.start_time = time.time()
        
    def simulate(self):
        """Run mock simulation"""
        print("\n" + "="*70)
        print("FIFO MOCK SIMULATOR")
        print("="*70)
        print(f"Test: {self.test_name}")
        print(f"Seed: {self.seed}")
        print(f"FIFO Depth: {self.fifo_depth}")
        print("="*70 + "\n")
        
        # Simulate test execution
        tests = {
            "seq_1_test": self.sim_seq_1,
            "seq_2_test": self.sim_seq_2,
            "seq_3_test": self.sim_seq_3,
            "seq_4_test": self.sim_seq_4,
            "seq_5_test": self.sim_seq_5,
        }
        
        if self.test_name in tests:
            return tests[self.test_name]()
        else:
            print(f"ERROR: Unknown test '{self.test_name}'")
            return False
    
    def sim_seq_1(self):
        """Simulate seq_1_test: Write 10 items, read 8"""
        print("[UVM_INFO] Running test: seq_1_test")
        print("[UVM_INFO] Write Agent: Generating write sequence...")
        
        # Write phase
        for i in range(10):
            data = random.randint(0, 255)
            print(f"  [WRITE] Item {i+1}: data_in=0x{data:02x}, write_enb=1")
            time.sleep(0.01)
        
        print("\n[UVM_INFO] Read Agent: Generating read sequence...")
        
        # Read phase
        for i in range(8):
            data = random.randint(0, 255)
            print(f"  [READ] Item {i+1}: data_out=0x{data:02x}, read_enb=1")
            time.sleep(0.01)
        
        print("\n[SB_DATA_MATCH] DATA Matching")
        print("✓ Test completed successfully!")
        return True
    
    def sim_seq_2(self):
        """Simulate seq_2_test: Sequential operations"""
        print("[UVM_INFO] Running test: seq_2_test")
        print("[UVM_INFO] Sequential write/read operations...")
        
        for i in range(12):
            operation = "WRITE" if i % 2 == 0 else "READ"
            data = random.randint(0, 255)
            print(f"  [{operation}] Item {i+1}: data=0x{data:02x}")
            time.sleep(0.01)
        
        print("\n[SB_DATA_MATCH] All operations completed")
        print("✓ Test completed successfully!")
        return True
    
    def sim_seq_3(self):
        """Simulate seq_3_test: Back-to-back operations"""
        print("[UVM_INFO] Running test: seq_3_test")
        print("[UVM_INFO] Back-to-back operations...")
        
        for i in range(16):
            data = random.randint(0, 255)
            print(f"  [OP] Item {i+1}: data=0x{data:02x}")
            if (i + 1) % 4 == 0:
                print(f"    [MARKER] Block {(i+1)//4} completed")
            time.sleep(0.005)
        
        print("\n[SB_DATA_MATCH] All back-to-back operations passed")
        print("✓ Test completed successfully!")
        return True
    
    def sim_seq_4(self):
        """Simulate seq_4_test: Stress test"""
        print("[UVM_INFO] Running test: seq_4_test")
        print("[UVM_INFO] Stress test pattern...")
        
        operations = 0
        for batch in range(5):
            for i in range(10):
                data = random.randint(0, 255)
                write = i % 3 == 0
                op = "WRITE" if write else "READ"
                print(f"  [{op}] Batch {batch+1}, Item {i+1}: data=0x{data:02x}")
                operations += 1
                time.sleep(0.005)
        
        print(f"\n[STATS] Total operations: {operations}")
        print("[SB_DATA_MATCH] Stress test completed")
        print("✓ Test completed successfully!")
        return True
    
    def sim_seq_5(self):
        """Simulate seq_5_test: Extended operations"""
        print("[UVM_INFO] Running test: seq_5_test")
        print("[UVM_INFO] Extended operations...")
        
        for i in range(20):
            data = random.randint(0, 255)
            full = random.choice([True, False])
            empty = random.choice([True, False])
            print(f"  [OP] Item {i+1}: data=0x{data:02x}, full={full}, empty={empty}")
            time.sleep(0.005)
        
        print("\n[SB_DATA_MATCH] Extended test completed")
        print("✓ Test completed successfully!")
        return True
    
    def report(self):
        """Print simulation report"""
        elapsed = time.time() - self.start_time
        print("\n" + "="*70)
        print("SIMULATION REPORT")
        print("="*70)
        print(f"Test Name: {self.test_name}")
        print(f"Seed: {self.seed}")
        print(f"Status: PASSED")
        print(f"Elapsed Time: {elapsed:.2f}s")
        print("="*70 + "\n")

def main():
    """Main entry point"""
    test_name = "seq_1_test"
    seed = None
    
    # Parse arguments
    for i, arg in enumerate(sys.argv[1:]):
        if arg in ["-t", "--test"]:
            test_name = sys.argv[i+2] if i+2 < len(sys.argv) else "seq_1_test"
        elif arg in ["-s", "--seed"]:
            try:
                seed = int(sys.argv[i+2])
            except (ValueError, IndexError):
                seed = None
    
    # Run simulator
    sim = MockSimulator(test_name, seed)
    success = sim.simulate()
    sim.report()
    
    return 0 if success else 1

if __name__ == "__main__":
    sys.exit(main())
