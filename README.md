# Doctor–Patient Smart Contract Security

A Solidity-based research project investigating **cross-contract reentrancy and access-control vulnerabilities** in a blockchain-based patient–doctor medical-record system.

The project implements a patient-centric medical-record architecture, demonstrates vulnerable cross-contract interactions, and provides mitigated contract variants using defensive smart-contract design patterns.

**Research Paper:** [Smart Contracts in Healthcare: Practical Defences Against Cross-Contract Reentrancy Attacks](https://link.springer.com/chapter/10.1007/978-3-032-19675-0_46)

**Published in:** Springer Lecture Notes in Networks and Systems (LNNS), ICTCS 2025  
**Pages:** 481–492  
**Published:** April 1, 2026  
**DOI:** [10.1007/978-3-032-19675-0_46](https://doi.org/10.1007/978-3-032-19675-0_46)

---

## Overview

Blockchain-based healthcare systems can provide tamper-resistant records and decentralized access control. However, interactions between multiple smart contracts can introduce security vulnerabilities that may not be apparent when contracts are considered independently.

This project studies one such class of vulnerability: **cross-contract reentrancy**.

The system consists of separate Patient and Doctor smart contracts. Patients maintain control over their medical records and can authorize individual doctors to access or update their information.

The repository contains:

- Patient medical-record management
- Doctor authorization and access control
- Cross-contract interactions
- Vulnerable contract implementations
- Reentrancy attack contracts
- Mitigated contract implementations
- Supporting security-testing documentation

The vulnerable implementations are intentionally retained to demonstrate how unsafe contract interactions can be exploited and how defensive patterns can be applied.

---

## System Architecture

The project uses two primary smart contracts:

```text
                    ┌────────────────────────┐
                    │        Patient         │
                    │                        │
                    │  • Medical Records     │
                    │  • Authorization       │
                    │  • Patient Information │
                    └────────────┬───────────┘
                                 │
                                 │ Cross-contract
                                 │ interaction
                                 ▼
                    ┌────────────────────────┐
                    │         Doctor         │
                    │                        │
                    │  • Access Records      │
                    │  • Update Records      │
                    │  • Authorization Check │
                    └────────────┬───────────┘
                                 │
                                 │ Vulnerable
                                 │ interaction
                                 ▼
                    ┌────────────────────────┐
                    │   Reentrancy Attack    │
                    │       Contract         │
                    └────────────────────────┘
```

The Doctor contract communicates with the Patient contract through contract interfaces. This cross-contract interaction creates the execution path used to study reentrancy and authorization-related security issues.

---

## Core Functionality

### Patient Medical Records

Patients can create and manage medical information such as:

- Name
- Age
- Blood group
- Allergies
- Medications
- Surgeries
- Physician notes

Patients retain control over their records and can manage which doctors are authorized to interact with their information.

### Doctor Authorization

Patients can authorize individual doctor addresses.

Authorization is enforced at the smart-contract level before sensitive record operations are performed.

### Cross-Contract Interaction

The Doctor contract interacts with the Patient contract through a defined interface.

This architecture allows the project to demonstrate how security assumptions can break down when multiple contracts interact with one another.

---

## Security Focus

The primary security focus of this project is **cross-contract reentrancy**.

Unlike a simple single-contract reentrancy scenario, cross-contract reentrancy can occur when an external call causes execution to move between multiple contracts before the original operation has completed.

The repository therefore contains both vulnerable and mitigated versions of the relevant contracts.

### Vulnerable Implementation

The vulnerable contracts demonstrate unsafe interaction patterns and are intentionally included for security research and educational purposes.

Relevant files include:

```text
Patient.sol
Doctor.sol
DoctorReentrancyAttack.sol
PatientReentrancyAttack.sol
```

The attack contracts model malicious contract behavior and are used to study how the vulnerable interaction can be exploited.

### Mitigated Implementation

The repository also contains modified implementations that demonstrate defensive approaches:

```text
MitigatedDoctor.sol
MitigatedPatientInfo.sol
```

These implementations incorporate stronger authorization and reentrancy defenses intended to reduce the attack surface created by unsafe cross-contract interactions.

---

## Security Concepts Demonstrated

This project focuses on the following smart-contract security concepts:

- Cross-contract reentrancy
- Smart-contract authorization
- Access-control validation
- External contract calls
- Contract composition
- Checks-Effects-Interactions
- Reentrancy protection
- Secure smart-contract design

---

## Repository Structure

```text
Doctor-Patient-Smart-Contract-Security/
│
├── Doctor.sol
├── Patient.sol
│
├── DoctorReentrancyAttack.sol
├── PatientReentrancyAttack.sol
│
├── MitigatedDoctor.sol
├── MitigatedPatientInfo.sol
│
├── Documentation of Testing Tools for Blockchain Application.pdf
│
└── README.md
```

---

## Getting Started

### Prerequisites

You can use an Ethereum development environment such as:

- [Remix IDE](https://remix.ethereum.org/)
- Foundry
- Hardhat
- A local Ethereum development network
- An Ethereum testnet

### Basic Deployment Flow

1. Deploy the Patient contract.
2. Deploy the Doctor contract using the deployed Patient contract address.
3. Create and manage patient records.
4. Authorize a doctor address.
5. Interact with the Doctor contract.
6. Reproduce the vulnerable interaction using the attack contract.
7. Compare the vulnerable and mitigated implementations.

---

## Example Interaction Flow

A simplified interaction sequence is:

```text
Patient
   │
   ├── Creates medical record
   │
   ├── Authorizes Doctor
   │
   ▼
Doctor Contract
   │
   ├── Requests patient information
   │
   ├── Performs cross-contract call
   │
   ▼
Patient Contract
   │
   └── Executes requested operation
```

The vulnerable implementation allows the project to examine what can happen when external calls and state changes are not handled safely.

---

## Research Context

This repository is associated with the research paper:

### Smart Contracts in Healthcare: Practical Defences Against Cross-Contract Reentrancy Attacks

The research investigates cross-contract reentrancy vulnerabilities in a blockchain-based healthcare data-management architecture and explores defensive mechanisms for improving smart-contract security.

The published work describes an interoperable Patient–Doctor smart-contract system and discusses mitigation strategies including:

- OpenZeppelin's `ReentrancyGuard`
- Mutex-based state management
- Checks-Effects-Interactions
- Authorization controls

---

## Publication

**Authors:**

Yogita Borse, Purnima Ahirao, Deepti Patole, Sanjana Das, Anjali Bhat, and Shubra Mukherjee

**Conference:** ICTCS 2025

**Publisher:** Springer

**Series:** Lecture Notes in Networks and Systems (LNNS)

**Pages:** 481–492

**Published:** April 1, 2026

**Paper:** [Read the published paper on Springer](https://link.springer.com/chapter/10.1007/978-3-032-19675-0_46)

**DOI:** [10.1007/978-3-032-19675-0_46](https://doi.org/10.1007/978-3-032-19675-0_46)

---

## Research and Educational Purpose

This repository is intended for:

- Smart-contract security research
- Blockchain security education
- Understanding cross-contract interactions
- Studying reentrancy vulnerabilities
- Demonstrating defensive smart-contract patterns

The vulnerable contracts are intentionally retained so that the security issue can be reproduced and studied.

---

## Disclaimer

This project is provided **for research and educational purposes only**.

Some contracts intentionally contain vulnerable patterns. They should **not** be deployed to production or used to manage real medical information.

The project does not constitute a production-ready healthcare system.

---

## Technologies

- Solidity
- Ethereum
- Smart Contracts
- Blockchain Security
- Cross-Contract Interaction
- Reentrancy Analysis
- Access Control
- Web3

---

## Author

**Sanjana Das**

Blockchain Developer | Smart Contract Security

- GitHub: [@DasHowItBe445](https://github.com/DasHowItBe445)
- LinkedIn: [Sanjana Das](https://linkedin.com/in/dassanjana)
