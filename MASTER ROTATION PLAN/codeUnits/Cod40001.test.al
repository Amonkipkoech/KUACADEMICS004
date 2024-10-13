codeunit 40001 "Rotation Management"
{
    procedure GenerateRotationSchedule()
    var
        StudentRec: Record "ACA-Course Registration";
        RotationGroupRec: Record "Rotation Group";
        GroupSize: Integer;
        TotalStudents: Integer;
        TotalLabs: Integer;
        LabID: Integer;
        GroupID: Integer;
        AcademicYear: Code[20];
        Semester: Code[10];
        StudentsProcessed: Integer;
        Week: Integer; // Week counter
        i: Integer; // Loop variable for student assignment
    begin
        GroupSize := 7; // Example group size
        AcademicYear := '2024'; // Example academic year
        Semester := 'SEP'; // Example semester

        // Initialize lab assignments before starting
        InitializeLabAssignments();

        // Count total number of students
        TotalStudents := StudentRec.Count();
        // Count total number of labs
        TotalLabs := 10; // Assuming there are 10 labs

        // Ensure there are no divisions by zero
        if (TotalStudents = 0) or (TotalLabs = 0) then begin
            Message('No students or labs found. Cannot generate rotation schedule.');
            exit;
        end;

        // Process students for each week
        for Week := 1 to 12 do begin
            GroupID := 1; // Reset GroupID for the new week
            StudentsProcessed := 0; // Reset for each week

            // Fetch students for the current week
            StudentRec.Reset(); // Ensure to reset the record
            if not StudentRec.FindSet() then
                exit; // Exit if no students are found

            // Process students for the current week
            repeat
                // Check if a new group needs to be created
                if StudentsProcessed MOD GroupSize = 0 then begin
                    // Assign a lab for this group
                    LabID := GetNextAvailableLab(Week, TotalLabs);
                    if LabID = 0 then begin
                        Message('No available labs for week %1.', Week);
                        exit;
                    end;

                    // Assign students to the current group
                    for i := 0 to GroupSize - 1 do begin
                        // Check if all students are processed
                        if StudentsProcessed + i >= TotalStudents then
                            break;

                        // Move to the next student
                        StudentRec.Next();
                        // Insert the current student into the rotation group
                        RotationGroupRec.Init();
                        RotationGroupRec."Group ID" := GroupID;
                        RotationGroupRec."Student No." := StudentRec."Student No."; // Use the current student number
                        RotationGroupRec."Lab ID" := LabID;
                        RotationGroupRec."Week" := Week;
                        RotationGroupRec."Academic Year" := AcademicYear;
                        RotationGroupRec."Semester" := Semester;
                        RotationGroupRec.Insert();

                        StudentsProcessed += 1; // Increment total students processed
                    end;

                    GroupID += 1; // Move to the next group after processing
                end;

            until StudentsProcessed >= TotalStudents; // Continue until all students are processed
        end;

        Message('Rotation schedule has been generated.');
    end;

    procedure InitializeLabAssignments()
    var
        LabAssignmentTemp: Record "Lab Assignment Temp";
        LabID: Integer;
        Week: Integer;
    begin
        // Clear existing records
        LabAssignmentTemp.DeleteAll();

        // Initialize records for weeks and labs
        for Week := 1 to 12 do begin
            for LabID := 1 to 10 do begin // Assuming there are 10 labs
                LabAssignmentTemp.Init();
                LabAssignmentTemp."Week" := Week;
                LabAssignmentTemp."Lab ID" := LabID;
                LabAssignmentTemp."Assigned" := false; // Set initial as not assigned
                LabAssignmentTemp.Insert();
            end;
        end;
    end;

    // Function to get the next available lab for the given week
    procedure GetNextAvailableLab(Week: Integer; TotalLabs: Integer): Integer
    var
        LabIndex: Integer;
        LabAssigned: Record "Lab Assignment Temp";
    begin
        // Iterate through the labs to find the next available one for the current week
        for LabIndex := 1 to TotalLabs do begin
            LabAssigned.SetRange("Week", Week);
            LabAssigned.SetRange("Lab ID", LabIndex);
            LabAssigned.SetRange("Assigned", false); // Check only unassigned labs

            if LabAssigned.FindFirst() then begin
                // Mark the lab as assigned after selecting it
                LabAssigned."Assigned" := true;
                LabAssigned.Modify();
                exit(LabIndex); // Return the lab index
            end;
        end;

        exit(0); // Return 0 if no available labs
    end;
}

