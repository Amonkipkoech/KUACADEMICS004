page 68789 "ACA-Imported Receipts Buffer"
{
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    SourceTable = 61552;
    SourceTableView = WHERE(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Account No.';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt No"; Rec."Receipt No")
                {
                    ApplicationArea = All;
                }
                field(IDNo; Rec.IDNo)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                }
                field("Stud Exist"; Rec."Stud Exist")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Receipting)
            {
                Caption = 'Receipting';
                action("Import Receipts")
                {
                    Caption = 'Import Receipts';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Arrange your CSV File to have fields in the following order:\' +
                        'Serial\' +
                        'Transaction Code\' +
                        'Cheque No\' +
                        'F Name\' +
                        'M Name\' +
                        'L Name\' +
                        'ID No\' +
                        'Student No.\' +
                        'Amount\' +
                        'Description\' +
                        'Semester\' +
                        '************************************************************\' +
                        'Continue?', TRUE) = FALSE THEN
                            ERROR('Cancelled By User: ' + USERID);

                        XMLPORT.RUN(50152, TRUE, TRUE);
                    end;
                }
                action("Post Receipts")
                {
                    Caption = 'Post Receipts';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Generate Receipts";
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */
        //Rec.SetFilter("User ID", UserId);

    end;

    var
        StudPayments: Record "ACA-Std Payments";
        RcptBuffer: Integer;
}

