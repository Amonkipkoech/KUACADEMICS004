page 68010 "ACA-Admitted Applicants List"
{
    CardPageID = "ACA-Applications Card 3";
    DelayedInsert = false;
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 61372;
    SourceTableView = WHERE(Status = FILTER("Doc. Verification"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field("Faculty Admitted To"; Rec."Faculty Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Degree Admitted To"; Rec."Degree Admitted To")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
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

