codeunit 40001 "Rotation Management"
{
    procedure GenerateRotationSchedule()
    var
        StudentRec: Record "ACA-Course Registration";
        RotationGroupRec: Record "Rotation Group";
        LabRec: Record "Lab";
        LabAssignmentTemp: Record "Lab Assignment Temp";
        GroupSize: Integer;
        TotalStudents: Integer;
        TotalLabs: Integer;
        TotalGroups: Integer;
        Week: Integer;
        LabID: Integer;
        GroupID: Integer;
        AcademicYear: Code[20];
        Semester: Code[10];
        StudentsProcessed: Integer;
    begin
        GroupSize := 7; // Example group size
        AcademicYear := '2024'; // Example academic year
        Semester := 'SEP'; // Example semester

        // Initialize the temporary table
        LabAssignmentTemp.DeleteAll(); // Clear existing records if needed

        // Initialize records for weeks and labs
        for Week := 1 to 12 do begin
            for LabID := 1 to 10 do begin
                LabAssignmentTemp.Init();
                LabAssignmentTemp."Week" := Week;
                LabAssignmentTemp."Lab ID" := LabID;
                LabAssignmentTemp."Assigned" := false; // Set initial as not assigned

                // Check if the record already exists
                if not LabAssignmentTemp.Insert() then begin
                    // Handle existing record (optional)
                    // You could use an update logic or simply skip
                end;
            end;
        end;

        // Count total number of students
        TotalStudents := StudentRec.Count();
        // Count total number of labs
        TotalLabs := LabRec.Count();

        // Ensure there are no divisions by zero
        if (TotalStudents = 0) or (TotalLabs = 0) then begin
            Message('No students or labs found. Cannot generate rotation schedule.');
            exit;
        end;

        // Calculate total number of groups
        TotalGroups := (TotalStudents + GroupSize - 1) DIV GroupSize;

        // Assign students to groups and rotate them through labs
        GroupID := 1;
        Week := 1;
        StudentsProcessed := 0;

        StudentRec.FindSet();
        repeat
            // Get the next available lab for the week
            LabID := GetNextAvailableLab(Week, TotalLabs);
            if LabID = 0 then begin
                Message('No available labs for week %1.', Week);
                exit;
            end;

            // Assign all students in a group to the same lab and week
            RotationGroupRec.Init();
            RotationGroupRec."Group ID" := GroupID;
            RotationGroupRec."Student No." := StudentRec."Student No.";
            RotationGroupRec."Lab ID" := LabID;
            RotationGroupRec."Week" := Week;
            RotationGroupRec."Academic Year" := AcademicYear;
            RotationGroupRec."Semester" := Semester;
            RotationGroupRec.Insert();

            StudentsProcessed += 1;

            // Move to the next group or week after processing a full group
            if (StudentsProcessed MOD GroupSize = 0) or (StudentRec.Next() = 0) then begin
                if GroupID >= TotalGroups then begin
                    GroupID := 1;
                    Week += 1;
                    if Week > 12 then
                        Week := 1; // Reset week counter if needed
                end else begin
                    GroupID += 1;
                end;
            end;

        until StudentRec.Next() = 0;
    end;

    // Function to get the next available lab for the given week
    procedure GetNextAvailableLab(Week: Integer; TotalLabs: Integer): Integer
    var
        LabIndex: Integer;
        LabAssigned: Record "Lab Assignment Temp";
    begin
        // Iterate through the labs to find the next available one
        for LabIndex := 1 to TotalLabs do begin
            // Check if this lab is assigned for the current week
            LabAssigned.SetRange("Week", Week);
            LabAssigned.SetRange("Lab ID", LabIndex);
            if not LabAssigned.FindFirst() then begin
                exit(LabIndex); // Return the lab index (or ID if necessary)
            end;
        end;

        exit(0); // Return 0 if no available labs
    end;
}
