page 67038 "Lecturer Units List"
{
    PageType = List;
    SourceTable = 65202;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ModeOfStudy; Rec.ModeOfStudy)
                {
                    ApplicationArea = All;
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(unique; Rec.unique)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(TimeSlot; Rec.TimeSlot)
                {
                    ApplicationArea = All;
                }
                field("Registered Students"; Rec."Registered Students")
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours"; Rec."No. Of Hours")
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Posted On"; Rec."Posted On")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }

                field("Available From"; Rec."Available From")
                {
                    ApplicationArea = All;
                }
                field("Available To"; Rec."Available To")
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Marks Submitted"; Rec."Marks Submitted")
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

