page 40039 "time table list part"
{
    Caption = 'time table list part';
    PageType = ListPart;
    SourceTable = Timetable;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Programs; Rec.Programs)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.', Comment = '%';
                }
                field("Unit Base Code"; Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Base Code field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Day field.', Comment = '%';
                }
                field(TimeSlot; Rec.TimeSlot)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TimeSlot field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Lecture Hall"; Rec."Lecture Hall")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecture Hall field.', Comment = '%';
                }
                field("Sitting Capacity"; Rec."Sitting Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sitting Capacity field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer field.', Comment = '%';
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
}
