page 40023 "Time Table"
{
    Caption = 'Time Table';
    PageType = List;
    SourceTable = "ACA-Units Offered";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(Week; REC.Week)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the week field.';
                }
                field("Date Of The Week"; rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(Programs; Rec.Programs)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.';
                }
                field("Program Name"; Rec."Program Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program Name field.';
                }
                field("Unit Base Code"; Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Base Code field.';
                }

                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Day field.';
                }
                field(TimeSlot; Rec.TimeSlot)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TimeSlot field.';
                }
                field("Lecture Hall"; Rec."Lecture Hall")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecture Hall field.';
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(ModeofStudy; Rec.ModeofStudy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ModeofStudy field.', Comment = '%';
                }
                field("Registered Students"; Rec."Registered Students")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registered Students field.', Comment = '%';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Campus field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Marks")
            {
                ApplicationArea = All;
                image = ImportCodes;
                RunObject = xmlport "xmlimportTimeTable";
                // trigger OnAction()
                // begin
                //     if ((UserId <> 'APPKINGS') or (UserId <> 'Frankie') or (UserId <> 'GKIMATHI') or (UserId <> 'EKIOKO')) then
                //         ERROR('You are not allowed to Access This!!');
                // end;

            }
        }

    }
}
