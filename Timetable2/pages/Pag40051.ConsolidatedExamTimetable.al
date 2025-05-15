page 40051 "Consolidated  Exam Timetable"
{
    Caption = 'Consolidated  Exam Listpart';
    PageType = ListPart;

    SourceTable = "Examination Timetable";

    // Only show records where Status = Approved
    SourceTableView = where(Status = const(Approved));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.', Comment = '%';
                }
                field(Semester; rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.', Comment = '%';
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.', Comment = '%';
                }
                field(Month; REC.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.', Comment = '%';
                }
                field(Week; REC.Week)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.', Comment = '%';
                }
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
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                    Caption = 'Invigilator Number';
                    ToolTip = 'Specifies the value of the Lecturer field.', Comment = '%';
                }
                field("Lecturer Name"; REC."Lecturer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Invigilator Name';
                    ToolTip = 'Specifies the value of the Lecturer field.', Comment = '%';
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


                field("Registered Students"; Rec."Registered Students")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registered Students field.', Comment = '%';
                }

            }
        }
    }
}
