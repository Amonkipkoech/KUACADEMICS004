table 65200 "Lect Load Batches"
{

    fields
    {
        field(1; "Semester Code"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;

            trigger OnValidate()
            begin
                "Created By" := USERID;
                "Created Time" := TIME;
                // Populate the HrEmployees Load Lines Here
                // Check if a prevous Load plan exists and adopt. If not, pick for all Lecturers
                IF CONFIRM('Populate Lecturers automatically?', TRUE) = FALSE THEN EXIT;
                HrEmployees.RESET;
                HrEmployees.SETFILTER(HrEmployees.Lecturer, '=%1', TRUE);
                IF HrEmployees.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        LectLoadBatchLines.RESET;
                        LectLoadBatchLines.SETRANGE(LectLoadBatchLines."Semester Code", "Semester Code");
                        LectLoadBatchLines.SETRANGE(LectLoadBatchLines."Lecturer Code", HrEmployees."No.");
                        IF NOT (LectLoadBatchLines.FIND('-')) THEN BEGIN
                            LectLoadBatchLines.INIT;
                            LectLoadBatchLines."Semester Code" := "Semester Code";
                            LectLoadBatchLines."Lecturer Code" := HrEmployees."No.";
                            LectLoadBatchLines.VALIDATE("Lecturer Code");
                            LectLoadBatchLines.INSERT;
                        END;
                    END;
                    UNTIL HrEmployees.NEXT = 0;
                END;
            end;
        }
        field(2; "Created Date"; Date)
        {
        }
        field(3; "Created Time"; Time)
        {
        }
        field(5; "Academic Year"; Code[20])
        {
        }
        field(6; "No of Lecturers"; Integer)
        {
            CalcFormula = Count("Lect Load Batch Lines" WHERE("Semester Code" = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Draft,Final,Posted';
            OptionMembers = Draft,Final,Posted;
        }
        field(9; "Created By"; Code[20])
        {
        }
        field(314; "Appointment Later Ref. No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(315; "Appointment Later Ref."; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(316; "Semester Range Descption"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(317; "Approval Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(318; "Approval Title"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Semester Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('Not Allowed!');
    end;

    trigger OnInsert()
    begin
        //IF LectLoadPermissions.GET(USERID) THEN
        // LectLoadPermissions.TESTFIELD("Create Batch") ELSE ERROR('Access Denied!');

        ACASemesters.RESET;
        ACASemesters.SETRANGE("Current Semester", TRUE);
        IF ACASemesters.FIND('-') THEN BEGIN
        END ELSE
            ERROR('No Current Semester Specified');

        IF "Semester Code" = '' THEN BEGIN
            IF NOT (LectLoadBatches.GET(ACASemesters.Code)) THEN Rec."Semester Code" := ACASemesters.Code;
            VALIDATE(Rec."Semester Code");
        END;
    end;

    trigger OnModify()
    begin
        //IF LectLoadPermissions.GET(USERID) THEN
        //LectLoadPermissions.TESTFIELD("Edit Batch") ELSE ERROR('Access Denied!');
    end;

    var
        LectLoadBatches: Record 65200;
        LectLoadBatchLines: Record 65201;
        HrEmployees: Record 61188;
        LectLoadBatchLines1: Record 65201;
        LectLoadPermissions: Record 65207;
        ACASemesters: Record 61692;
}

