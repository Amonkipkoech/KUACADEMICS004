page 86007 "Gown Issuance Register"
{
    Caption = 'Gown Issuance Register';
    PageType = Card;
    SourceTable = "Gown Issuance Register";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Issued; Rec.Issued)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issued field.', Comment = '%';
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Issued field.', Comment = '%';
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Return Date field.', Comment = '%';
                }
                field("Actual Return Date"; Rec."Actual Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Return Date field.', Comment = '%';
                }
                field(Returned; Rec.Returned)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Returned field.', Comment = '%';
                }
                field("Number of Gowns Left"; Rec."Number of Gowns Left")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Post Allocation")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;
                trigger OnAction()
                begin
                    Rec.CalcFields("Number of Gowns Left");
                    if Rec."Number of Gowns Left" <= 0 then
                        Error('No Gowns Left to Issue') else begin
                        postgown.postGowns(Rec."No.", Rec."Student No.", Rec."Date Issued");
                        Rec.Issued := true;
                        Rec.Modify();
                        Message('Gown Issued Successfully!');
                    end;

                end;
            }
        }
    }

    var
        postgown: Codeunit "Graduation Journals";

}
