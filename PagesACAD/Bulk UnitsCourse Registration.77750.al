page 77750 "Bulk Units/Course Registration"
{
    DeleteAllowed = true;
    PageType = List;
    SourceTable = 61746;
    SourceTableView = WHERE("Course Reg. Created" = FILTER(false),
                            "Units Reg. Created" = FILTER(false),
                            "Failure Reason" = FILTER(''),
                            "Exam Score" = FILTER(0),
                            "CAT Score" = FILTER(0));

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
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    Enabled = false;
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
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Failure Reason"; Rec."Failure Reason")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Units Reg. Created"; Rec."Units Reg. Created")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Course Reg. Created"; Rec."Course Reg. Created")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(exist; Rec.exist)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(PostMks)
            {
                Caption = 'Register Students';
                Image = ViewCheck;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Register Units?', TRUE) = FALSE THEN ERROR('Cancelled');
                    ACAExamResultsBuffer2.COPYFILTERS(Rec);
                    IF ACAExamResultsBuffer2.FIND('-') THEN
                        REPORT.RUN(77750, FALSE, FALSE, ACAExamResultsBuffer2);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        HRMEmployeeC: Record 61188;
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
        HRMEmployeeC: Record 61188;
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
        UserSetup: Record 91;
        ACAExamResultsBuffer2: Record 61746;
}

