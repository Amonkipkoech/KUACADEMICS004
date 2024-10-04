page 78032 "ACA-Scholarship Allocation"
{
    Caption = 'Scholarship Allocation Disbursement';
    DeleteAllowed = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "ACA-Imp. Receipts Buffer";
   // SourceTableView = WHERE(Posted = filter(false));

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

                    trigger OnValidate()
                    var
                        cust: Record Customer;
                    begin
                        cust.Get(Rec."Student No.");
                        Name := cust.Name;
                    end;
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
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
            
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
                    Visible = false;
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
                    
                    
                    RunObject = Report 51526;
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        StudPayments: Record "ACA-Std Payments";
        RcptBuffer: Integer;
}

