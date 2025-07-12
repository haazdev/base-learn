# Base Learn Exercises – Personal Solutions

This repository tracks my step-by-step work while completing the **[Base Learn](https://docs.base.org/learn)** curriculum (Solidity + on-chain development).  Each exercise is implemented with an emphasis on **best practices**:

* gas-efficient storage layouts
* clear function / error naming
* SPDX & pragma hygiene
* concise yet thorough inline documentation
* organized folder structure (`exercises/` for finished solutions, `scripts/` for deployment helpers, etc.)

| Folder | Purpose |
| ------ | ------- |
| `exercises/` | Final, passing contracts for each Base Learn challenge |
| `scripts/`   | Hardhat / Foundry deployment or utility scripts (optional) |
| `docs/`      | Any notes or supplemental write-ups I create while learning |

## Current progress

- [x] Storage Exercise – `EmployeeStorage.sol`
- [ ] More exercises coming soon…

## How to compile & test

```bash
# with Foundry
yarn global add forge          # or follow Foundry install guide
forge build

# with Hardhat
npm install
npx hardhat compile
```

## Public visibility

These exercises—and the reference solutions supplied by Base Docs—are **publicly available**. Publishing your own implementations on GitHub is generally fine and can help others learn.  If you include any proprietary code (e.g., production secrets or company IP), be sure to remove/redact it before pushing.

If Base ever updates the exercises with non-permissive licensing or requests takedowns, I’ll comply accordingly.

---

Happy building on Base! 🚀
