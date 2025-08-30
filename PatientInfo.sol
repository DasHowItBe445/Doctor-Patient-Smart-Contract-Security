// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PatientInfo 
{
    address public owner;
    address public doctorContractAddress;

    constructor() 
    {
        owner = msg.sender;
    }

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

    mapping(address => mapping(uint256 => MedicalRecord)) private records;
    mapping(address => address[]) private authorizedDoctors;

    event MedicalRecordAdded(address indexed patient, uint256 indexed patientId);
    event MedicalRecordUpdated(address indexed patient, uint256 indexed patientId);
    event DoctorAuthorized(address indexed patient, address indexed doctor);
    event DangerousInteractionInvoked(address indexed doctor, uint256 value);

    modifier onlyOwner() 
    {
        require(msg.sender == owner, "Only owner can call");
        _;
    }

    function setDoctorContract(address _doctorContract) external onlyOwner 
    {
        doctorContractAddress = _doctorContract;
    }

    function addMedicalRecord(
        uint256 patientId,
        string memory name,
        uint256 age,
        string memory bloodGroup,
        string memory allergies,
        string memory medications,
        string memory surgeries,
        string memory physicianNotes
    ) public 
    {
        records[msg.sender][patientId] = MedicalRecord(
            name, age, bloodGroup, allergies, medications, surgeries, physicianNotes
        );
        emit MedicalRecordAdded(msg.sender, patientId);
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
        address /* doctorCaller */
    ) public {
        if (msg.sender == patient) 
        {
            // Patient: only update fields that are non-empty/non-zero
            MedicalRecord storage record = records[patient][patientId];

            if (bytes(name).length > 0) 
            {
                record.name = name;
            }
            if (age > 0) 
            {
                record.age = age;
            }
            if (bytes(bloodGroup).length > 0) 
            {
                record.bloodGroup = bloodGroup;
            }
            if (bytes(allergies).length > 0) 
            {
                record.allergies = allergies;
            }
            if (bytes(medications).length > 0) 
            {
                record.medications = medications;
            }
            if (bytes(surgeries).length > 0) 
            {
                record.surgeries = surgeries;
            }
            if (bytes(physicianNotes).length > 0) 
            {
                record.physicianNotes = physicianNotes;
            }
        } else if (msg.sender == doctorContractAddress) 
        {
            require(isDoctorAuthorized(patient, tx.origin), "Doctor not authorized by patient");

            records[patient][patientId] = MedicalRecord(
                name,
                age,
                bloodGroup,
                allergies,
                medications,
                surgeries,
                physicianNotes
            );
        } else {
            revert("Not authorized to update this record");
        }

        emit MedicalRecordUpdated(patient, patientId);
    }

    function authorizeDoctor(address doctor) public 
    {
        authorizedDoctors[msg.sender].push(doctor);
        emit DoctorAuthorized(msg.sender, doctor);
    }

    function isDoctorAuthorized(address patient, address doctor) public view returns (bool) 
    {
        address[] memory doctors = authorizedDoctors[patient];
        for (uint i = 0; i < doctors.length; i++) 
        {
            if (doctors[i] == doctor) 
            {
                return true;
            }
        }
        return false;
    }

    function getRecord(address patient, uint256 patientId)
        external
        view
        returns (MedicalRecord memory)
    {
        return records[patient][patientId];
    }

    function getRecordLineWise(address patient, uint256 patientId)
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
        MedicalRecord storage record = records[patient][patientId];
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

    function dangerousInteraction(address payable doctor) external payable 
    {
        emit DangerousInteractionInvoked(doctor, msg.value);
        (bool success, ) = doctor.call{value: msg.value}("");
        require(success, "Send failed");
    }

    receive() external payable {}
}


