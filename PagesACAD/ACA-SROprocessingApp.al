page 84520 "SRO Processing"
{

    SourceTable = "ACA-Applic. Form Header";
    PageType = List;
    CardPageID = "ACA-Application Form";
    SourceTableView = WHERE(Status = FILTER(Open),returned = filter(false));
    InsertAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application No. field.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Surname field.';
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(programName; Rec.programName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the programName field.';
                }
                field("Programme Level"; Rec."Programme Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme Level field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetFilter("User ID", UserId);
    end;


}