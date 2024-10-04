page 65217 "Lect Posted Batches List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 65200;
    SourceTableView = WHERE(Status = FILTER(<> Draft));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("No of Lecturers"; Rec."No of Lecturers")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        lineNo: Integer;
        DateFilter: Date;

}

