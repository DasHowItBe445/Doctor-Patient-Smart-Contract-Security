# Doctor–Patient Smart Contract Security

A Solidity-based research project investigating **cross-contract reentrancy and access-control vulnerabilities** in a blockchain-based patient–doctor medical-record system.

The project implements a patient-centric medical-record architecture, demonstrates vulnerable cross-contract interactions, and provides mitigated contract variants using defensive smart-contract design patterns.

**Research Paper:** [Smart Contracts in Healthcare: Practical Defences Against Cross-Contract Reentrancy Attacks](https://link.springer.com/chapter/10.1007/978-3-032-19675-0_46)

**Published in:** Springer Lecture Notes in Networks and Systems (LNNS), ICTCS 2025  
**Pages:** 481–492  
**Publication Date:** April 1, 2026

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
