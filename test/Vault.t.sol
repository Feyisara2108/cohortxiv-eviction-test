eviction-vault/
├── .gitignore
├── foundry.toml              # Foundry configuration (compiler version, etc.)
├── remappings.txt            # Maps "@openzeppelin" to the lib folder
├── README.md                 # Documentation of fixes and setup
├── lib/                      # Dependencies (Installed via forge)
│   ├── openzeppelin-contracts/
│   └── forge-std/
├── src/                      # Smart Contract Source Code
│   ├── interfaces/
│   │   └── IEvictionVault.sol    # Interface definition (Decouples logic)
│   ├── EvictionVault.sol         # Main implementation (Logic + Security)
│   └── libraries/                # (Optional) Custom helpers if needed
├── test/                     # Test Suites
│   ├── mocks/                # Mock contracts for testing (e.g., ReentrancyAttacker)
│   │   └── MockAttacker.sol
│   └── EvictionVault.t.sol   # Main test file (4-6 positive tests)
└── script/                   # Deployment Scripts
    └── DeployVault.s.sol     # Handles deployment + Timelock setup