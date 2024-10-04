page 65210 "Lect Load Batch List"
{
    CardPageID = "Lect Load Batch Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 65200;
    SourceTableView = WHERE(Status = FILTER(Draft));

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
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
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
            action("Mark as Closed")
            {
                Caption = 'Mark as Closed';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Draft THEN ERROR('Already Closed!');


                    IF CONFIRM('CONFIRM:\Mark as Final?', FALSE) = FALSE THEN EXIT;
                    IF CONFIRM('******WARNING!!!!!!!:\You will not post into an already posted Batch. \Continue?', FALSE) = FALSE THEN EXIT;
                    Rec.Status := Rec.Status::Final;
                    Rec.MODIFY;
                end;
            }
        }
    }

    var


}

