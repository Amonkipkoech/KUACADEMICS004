page 70087 "ACA-Exam Results Buffer 3"
{
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "ACA-Exam Results Buffer 2";
    //SourceTableView = WHERE(exist=FILTER(true));
    SourceTableView = where("exist" = filter(true));
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
                field("Course Reg. Created"; Rec."Course Reg. Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Units Reg. Created"; Rec."Units Reg. Created")
                {
                    Editable = false;
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
                Caption = 'Post Marks';
                Image = ViewCheck;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    REPORT.RUN(51148,FALSE,FALSE);
                    // REPORT.RUN(51149,FALSE,FALSE);
                    // REPORT.RUN(52017852,FALSE,FALSE);
                    // REPORT.RUN(51094,FALSE,FALSE);
                    //PAGE.RUN(77713);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        HRMEmployeeC: Record "HRM-Employee (D)";
    begin
        //SETFILTER("User Name",USERID);
        //UserSetup.RESET;
        //UserSetup.SETRANGE("User ID",USERID);
        //IF UserSetup.FIND('-') THEN BEGIN
        // IF UserSetup."Employee No."='' THEN ERROR('Access Denied!');
        // HRMEmployeeC.RESET;
        //HRMEmployeeC.SETRANGE("No.",UserSetup."Employee No.");
        // IF NOT HRMEmployeeC.FIND('-') THEN  ERROR('Access Denied!');
        // IF NOT  HRMEmployeeC."Is HOD" THEN ERROR('Access Denied!');
        // END ELSE ERROR('Access Denied!');
        //END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"User Name":=USERID;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"User Name":=USERID;
    end;

    trigger OnOpenPage()
    var
        HRMEmployeeC: Record "HRM-Employee (D)";
    begin
        //SETFILTER("User Name",USERID);
        //UserSetup.RESET;
        //UserSetup.SETRANGE("User ID",USERID);
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

