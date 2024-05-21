// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Hospital {

    // Define a struct to hold patient information
    struct Patient {
        bool isAdmitted;
        uint256 bedspace;
    }

    // Address of the doctor who is allowed to set patient records
    address doctor;

    // Mapping to hold patient records
    mapping(string => Patient) patients;



    // Constructor to set the initial doctor
    constructor() {
        doctor = msg.sender;
    }

    // Function for the doctor to set a patient's record
    function setPatientRecord(string memory _patientName, bool _isAdmitted) public  {
         require(msg.sender == doctor, "you are not a doctor");
        
        patients[_patientName] = Patient({
            isAdmitted: _isAdmitted,
            bedspace: 0
        });
    }

    // Function to provide a bedspace to a patient
    function provideBedspace(string memory _patientName, uint256 _bedspace) public {
        Patient storage patient = patients[_patientName];

        // Ensure the patient exists and is admitted
        if (!patient.isAdmitted) {
            revert("Patient must be admitted before a bedspace can be provided");
        } 

        patient.bedspace = _bedspace;

        // Use assert to ensure bedspace is correctly assigned
        assert(patient.bedspace == _bedspace);
    }
};