page 66669 "ACA-My Uploaded Marks"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 61746;
    SourceTableView = WHERE("Course Reg. Created" = FILTER(true),
                            "Units Reg. Created" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("CAT Score"; Rec."CAT Score")
                {
                    ApplicationArea = All;
                }
                field("Exam Score"; Rec."Exam Score")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Failure Reason"; Rec."Failure Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Units Reg. Created"; Rec."Units Reg. Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Course Reg. Created"; Rec."Course Reg. Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        HRMEmployeeC: Record "HRM-Employee (D)";
    begin
        Rec.SETFILTER("User Name", USERID);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FIND('-') THEN BEGIN
            // IF UserSetup."Employee No."='' THEN ERROR('Access Denied!');
            // HRMEmployeeC.RESET;
            //HRMEmployeeC.SETRANGE("No.",UserSetup."Employee No.");
            // IF NOT HRMEmployeeC.FIND('-') THEN  ERROR('Access Denied!');
            // IF NOT  HRMEmployeeC."Is HOD" THEN ERROR('Access Denied!');
            // END ELSE ERROR('Access Denied!');
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User Name" := USERID;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."User Name" := USERID;
    end;

    trigger OnOpenPage()
    var
        HRMEmployeeC: Record "HRM-Employee (D)";
    begin
        Rec.SETFILTER("User Name", USERID);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        // IF UserSetup.FIND('-') THEN BEGIN
        //  IF UserSetup."Employee No."='' THEN ERROR('Access Denied!');
        //  HRMEmployeeC.RESET;
        //  HRMEmployeeC.SETRANGE("No.",UserSetup."Employee No.");
        //  IF NOT HRMEmployeeC.FIND('-') THEN  ERROR('Access Denied!');
        //  IF NOT  HRMEmployeeC."Is HOD" THEN ERROR('Access Denied!');
        //  END ELSE ERROR('Access Denied!');
    end;

    var
        UserSetup: Record "User Setup";
}

