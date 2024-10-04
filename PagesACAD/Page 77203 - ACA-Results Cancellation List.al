page 77203 "ACA-Results Cancellation List"
{
    CardPageID = "ACA-Results Cancellation Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Aca-Result Cancelation Req. Hd";
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Program Code"; Rec."Program Code")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field("Cancelllation Notes"; Rec."Cancelllation Notes")
                {
                    ApplicationArea = All;
                }
                field("No. of Units Cancelled"; Rec."No. of Units Cancelled")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Initiated Date"; Rec."Initiated Date")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Initiated Time"; Rec."Initiated Time")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    IF UserSetup.FIND('-') THEN
                        UserSetup.TESTFIELD("Initiate Results Cancellation")
                    ELSE
                        ERROR('Access denied!');
                    Rec.TESTFIELD("Cancelllation Notes");
                    Rec.TESTFIELD("Student No.");
                    Rec.TESTFIELD("Academic Year");
                    Rec.TESTFIELD("Semester Code");
                    Rec.TESTFIELD("Program Code");
                    Rec.CALCFIELDS("No. of Units Cancelled");
                    IF CONFIRM('Send for Approval?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                    IF Rec.Scope = Rec.Scope::Unit THEN
                        IF Rec."No. of Units Cancelled" = 0 THEN
                            ERROR('Unit Cancellation requires that the unit/s be specified!');
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.MODIFY;
                    CurrPage.UPDATE;
                    MESSAGE('Request sent successfully');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Initiated By", '%1', USERID);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FIND('-') THEN
            UserSetup.TESTFIELD("Initiate Results Cancellation")
        ELSE
            ERROR('Access denied!');
    end;

    var
        UserSetup: Record "User Setup";
}

