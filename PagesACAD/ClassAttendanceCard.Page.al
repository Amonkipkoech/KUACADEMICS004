page 65800 "Class Attendance Card"
{
    PageType = Card;
    SourceTable = "Class Attendance Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Attendance Date"; "Attendance Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Semester)
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Reg. No"; "Class Rep. Reg. No")
                {
                    Caption = 'Class Representative';
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
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }

                // field("From Time"; "From Time")
                // {
                //     ApplicationArea = All;
                // }
                // field("To Time"; "To Time")
                // {
                //     ApplicationArea = All;
                // }
                field("Class Type"; "Class Type")
                {
                    ApplicationArea = All;
                }
            }
            group(ATtDet)
            {
                Caption = 'Attendance Details';
                part(Attendance; "Class Attendance Details Part")
                {
                    Caption = 'Attendance';
                    SubPageLink = Semester = FIELD(Semester),
                                  "Attendance Date" = FIELD("Attendance Date"),
                                  "Lecturer Code" = FIELD("Lecturer Code"),
                                  "Unit Code" = FIELD("Unit Code");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Comments)
            {
                Caption = 'Attendance Report';
                Image = Check;
                RunObject = report "Class Attendance";
                ApplicationArea = All;
            }
        }

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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Attendance Date" := TODAY;
        ACASemester.RESET;
        ACASemester.SETRANGE("Current Semester", TRUE);
        IF ACASemester.FIND('-') THEN BEGIN
            Semester := ACASemester.Code;
        END;
        "Captured By" := USERID;
    end;

    var
        HRMEmployeeC: Record "HRM-Employee (D)";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        UnitName: Code[150];
        LectName: Code[150];
        ACASemester: Record "ACA-Semesters";
}

