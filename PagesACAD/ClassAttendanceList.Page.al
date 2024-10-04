page 65801 "Class Attendance List"
{
    CardPageID = "Class Attendance Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 65800;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Attendance Date"; "Attendance Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Semester)
                {
                    ApplicationArea = All;
                }
                field("Lecturer Code"; "Lecturer Code")
                {
                    ApplicationArea = All;
                }
                field(LectName; LectName)
                {
                    Caption = 'Lecturer Name';
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Unit Code"; "Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Reg. No"; "Class Rep. Reg. No")
                {
                    ApplicationArea = All;
                }
                field("From Time"; "From Time")
                {
                    ApplicationArea = All;
                }
                field("To Time"; "To Time")
                {
                    ApplicationArea = All;
                }
                field("Class Type"; "Class Type")
                {
                    ApplicationArea = All;
                }
                field("Number Present"; "Number Present")
                {
                    ApplicationArea = All;
                }
                field("Number Absent"; "Number Absent")
                {
                    ApplicationArea = All;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Mail"; "Class Rep. Mail")
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Phone"; "Class Rep. Phone")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(UnitName);
        CLEAR(LectName);
        //ACAUnitsSubjects.RESET;
        //ACAUnitsSubjects.SETRANGE()

        IF HRMEmployeeC.GET("Lecturer Code") THEN BEGIN
            LectName := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
        END;
    end;

    var
        HRMEmployeeC: Record "HRM-Employee (D)";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        UnitName: Code[150];
        LectName: Code[150];
}

