# HardenedEvictionVault

Secure, modular smart contract for managing eviction deposits with multi-signature governance, timelock protection, and emergency controls.

---

### Security Features

| Feature | Protection |
|---|---|
| Multi-Sig Owners | Sensitive actions require threshold of owners to confirm |
| Timelock Delay | Admin transactions execute only after a mandatory delay |
| Emergency Pause | Owners can halt withdrawals via `PauseModule` |
| Safe Transfers | Uses `.call{value: }()` — no 2300 gas limit |
| Reentrancy Guard | Inherited guards prevent reentrancy attacks |
| No `tx.origin` | Uses `msg.sender` exclusively (phishing-resistant) |

---

### Installation
```bash
git clone <repo> && cd eviction-vault

forge install OpenZeppelin/openzeppelin-contracts --no-commit
forge install foundry-rs/forge-std --no-commit

forge build
```

### Deployment
```bash
forge script script/DeployVault.s.sol:DeployVault \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast
```

**Constructor params:**
- `owners` — array of authorized multi-sig addresses
- `threshold` — minimum confirmations required (e.g. `2` for 2-of-3)

---

### Key Functions

| Function | Access | Description |
|---|---|---|
| `deposit()` | Public | Deposit ETH |
| `withdraw(uint256)` | Public | Withdraw balance (pausable) |
| `pause() / unpause()` | Owner | Emergency control |
| `submitTransaction()` | Owner | Propose admin action |
| `confirmTransaction()` | Owner | Approve proposed action |
| `executeTransaction()` | Public | Execute after delay + confirmations |

---

### Testing
```bash
forge test -vvv
forge test --gas-report
forge coverage
```

---

### Project Structure
```
src/
├── HardenedEvictionVault.sol
├── modules/
│   ├── TimelockExecutor.sol
│   ├── MerkleAirdrop.sol
│   ├── PauseModule.sol
│   └── SignatureUtils.sol
└── interfaces/
    └── IVault.sol
```
### Test suites
![vault test](https://github.com/user-attachments/assets/7d0e503e-1ac8-4d80-94bc-989e0cf528b6)

### Deployment (on anvil)
![vaultscript](https://github.com/user-attachments/assets/700d3ac7-ce85-4fbc-926f-efb47a927126)



---

### Notes

- Set `threshold ≥ 2` in production
- Recommended timelock delay: 1–48 hours
- Audit before mainnet deployment



---

### License
MIT
