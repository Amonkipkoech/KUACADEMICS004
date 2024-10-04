page 77737 "ACA-Student Irregularities"
{
    CardPageID = "ACA-Student Irregularities Crd";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Irregularities Register";

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
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date/Time"; Rec."Transaction Date/Time")
                {
                    ApplicationArea = All;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                }
                field("Irregularity Type"; Rec."Irregularity Type")
                {
                    ApplicationArea = All;
                }
                field(Essay; Rec.Essay)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

