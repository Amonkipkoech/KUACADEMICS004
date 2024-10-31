table 61692 "ACA-Semesters"
{
    DrillDownPageID = 68744;
    LookupPageID = 68744;

    fields
    {
        field(1; "Code"; Code[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                progs.RESET;
                IF progs.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ProgSems.RESET;
                        ProgSems.SETRANGE(ProgSems."Programme Code", progs.Code);
                        ProgSems.SETRANGE(ProgSems.Semester, Code);
                        IF NOT ProgSems.FIND('-') THEN BEGIN
                            ProgSems.INIT;
                            ProgSems."Programme Code" := progs.Code;
                            ProgSems.Semester := Code;
                        END;
                    END;
                    UNTIL progs.NEXT = 0;
                END;
            end;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; From; Date)
        {
        }
        field(4; "To"; Date)
        {
        }
        field(5; Remarks; Text[150])
        {
        }
        field(6; "Current Semester"; Boolean)
        {

            trigger OnValidate()
            begin
                progs.RESET;
                IF progs.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ProgSems.RESET;
                        ProgSems.SETRANGE(ProgSems."Programme Code", progs.Code);
                        ProgSems.SETRANGE(ProgSems.Current, TRUE);
                        IF ProgSems.FIND('-') THEN BEGIN
                            ProgSems.Current := FALSE;
                            ProgSems.MODIFY;
                        END;

                        ProgSems.RESET;
                        ProgSems.SETRANGE(ProgSems."Programme Code", progs.Code);
                        ProgSems.SETRANGE(ProgSems.Semester, Code);
                        IF NOT ProgSems.FIND('-') THEN BEGIN
                            ProgSems.INIT;
                            ProgSems."Programme Code" := progs.Code;
                            ProgSems.Semester := Code;
                            ProgSems.Current := TRUE;
                            ProgSems.INSERT;
                        END ELSE BEGIN
                            ProgSems.Current := TRUE;
                            ProgSems.MODIFY;
                        END;
                    END;
                    UNTIL progs.NEXT = 0;
                END;
            end;
        }
        field(7; "Academic Year"; Text[9])
        {
        }
        field(8; "SMS Results Semester"; Boolean)
        {
        }
        field(9; "Lock Exam Editting"; Boolean)
        {
        }
        field(10; "Lock CAT Editting"; Boolean)
        {
        }
        field(12; "Released Results"; Boolean)
        {
        }
        field(13; "Lock Lecturer Editing"; Boolean)
        {
        }
        field(14; "Mark entry Dealine"; Date)
        {
        }
        field(15; "Registration Deadline"; Date)
        {
        }
        field(16; "Ignore Editing Rule"; Boolean)
        {
        }
        field(17; "BackLog Marks"; Boolean)
        {
        }
        field(18; AllowDeanEditing; Boolean)
        {
        }
        field(19; "Marks Changeable"; Boolean)
        {
        }
        field(20; "Unit Registration Deadline"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "DownLoad Exam Card"; Boolean)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     sems.Reset();
            //     sems.SetRange("DownLoad Exam Card", true);
            //     if sems.Find('-') then
            //         repeat
            //             sems."DownLoad Exam Card" := false;
            //             sems.Modify();
            //         until sems.Next = 0;
            //     Rec."DownLoad Exam Card" := true;
            //     Rec.Modify();
            // end;
        }
        field(22; "Evaluate Lecture"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Release CAT Marks"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Apply For Supp"; Date)
        {

        }
        field(25; "Semester Fee Percentage"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /* CReg.RESET;
         CReg.SETRANGE(CReg.Semester,Code);
         IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Semester');*/
        //webportals.PermissionsManagement('SEMSETUP', USERID);

    end;

    trigger OnInsert()
    begin
        // webportals.PermissionsManagement('SEMSETUP', USERID);
    end;

    trigger OnModify()
    begin
        // webportals.PermissionsManagement('SEMSETUP', USERID);
    end;

    trigger OnRename()
    begin
        /*IF xRec.Code<>Code THEN BEGIN
        CReg.RESET;
        CReg.SETRANGE(CReg.Semester,xRec.Code);
        IF CReg.FIND('-') THEN ERROR('Please note that you can not edit used Semester');
        END; */
        //webportals.PermissionsManagement('SEMSETUP', USERID);

    end;

    var
        CReg: Record "ACA-Course Registration";
        progs: Record "ACA-Programme";
        ProgSems: Record "ACA-Programme semesters";
        sems: Record "ACA-Semesters";
    //webportals: Codeunit "61106";
}

