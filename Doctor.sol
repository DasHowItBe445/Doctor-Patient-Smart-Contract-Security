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

    function isDoctorAuthorized(address patient, address doctor) external view returns (bool);

    function getRecord(address patient, uint256 patientId)
        external
        view
        returns (MedicalRecord memory);

    // Modified function signature with doctorCaller
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
}

contract Doctor 
{
    IPatientInfo public patientContract;

    constructor(address _patientContract) 
    {
        patientContract = IPatientInfo(_patientContract);
    }

    modifier onlyAuthorized(address patient) 
    {
        require(
            patientContract.isDoctorAuthorized(patient, msg.sender),
            "Doctor not authorized by patient"
        );
        _;
    }

    event RecordUpdated(address indexed patient, uint256 indexed patientId);

    function viewPatientRecord(address patient, uint256 patientId)
        public
        view
        onlyAuthorized(patient)
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
        IPatientInfo.MedicalRecord memory record =
            patientContract.getRecord(patient, patientId);
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
        string memory newPhysicianNotes
    ) public onlyAuthorized(patient) 
    {
        IPatientInfo.MedicalRecord memory record =
            patientContract.getRecord(patient, patientId);

        patientContract.updateMedicalRecord(
            patient,
            patientId,
            record.name,
            record.age,
            record.bloodGroup,
            record.allergies,
            newMedications,
            record.surgeries,
            newPhysicianNotes,
            msg.sender // <-- Pass the doctor’s address here
        );

        emit RecordUpdated(patient, patientId);
    }

    function getMyAddress() public view returns (address) 
    {
        return msg.sender;
    }
}
