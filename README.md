# Doctor-Patient-Smart-Contract-Security
Patient-Doctor Medical Records Smart Contract System

This repository contains Solidity smart contracts for a secure patient-doctor medical data sharing system on Ethereum. The system enables patients to store, manage, and share their medical records with authorized doctors in a privacy-preserving and access-controlled manner. It is designed as an educational demonstration of secure smart contract development, authorization flows, and highlights potential attack surfaces—specifically showcasing and testing reentrancy vulnerabilities.
Features

    Patient-Centric Medical Records:
    Patients can create and update their own detailed medical profiles, including personal information, allergies, medications, surgeries, and physician notes.

    Doctor Authorization:
    Patients retain full control over data access and can individually authorize doctors to view or update their records.

    Access Control:
    Only patients and their authorized doctors can modify or access sensitive information, enforced at the contract level.

    Attack Simulation:
    The included Doctor contract demonstrates a simulated reentrancy attack and how improper contract design can be exploited, enhancing understanding of critical security issues.

    Comprehensive Event Logs:
    Emits events for all major actions: record creation, updates, doctor authorization, and potentially dangerous interactions, allowing for transparent off-chain monitoring.

Security Highlights

    Illustrates both vulnerable and secure patterns, including the use of authorization checks and the implications of call-based Ether transfers.

    Designed as a learning tool for understanding and mitigating smart contract vulnerabilities, with special focus on reentrancy and access control.

Getting Started

    Deploy the PatientInfo contract for patient record management.

    Deploy the Doctor contract with the address of the deployed PatientInfo contract.

    Interact with the system as patient or doctor, authorizing access and managing records.

    Use dangerousInteraction to simulate unsafe contract interactions and observe the outcome of reentrancy attacks.

Disclaimer

    For research and educational purposes only.
    This code intentionally exposes a vulnerable flow to demonstrate smart contract security concepts and should not be used as-is in production.
