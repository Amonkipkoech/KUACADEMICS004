page 68710 "ACA-Units/Subject List"
{
    Editable = false;
    PageType = List;
    SourceTable = 61517;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
                field(programDuration; Rec.programDuration)
                {
                    ApplicationArea = All;
                }
                field("Reserved Room"; Rec."Reserved Room")
                {
                    ApplicationArea = All;
                }
                field("Credit Hours"; Rec."Credit Hours")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Ignore in Final Average"; Rec."Ignore in Final Average")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Programme Filter"; Rec."Programme Filter")
                {
                    ApplicationArea = All;
                }
                field("Stage Filter"; Rec."Stage Filter")
                {
                    ApplicationArea = All;
                }
                field("Unit Filter"; Rec."Unit Filter")
                {
                    ApplicationArea = All;
                }
                field("Semester Filter"; Rec."Semester Filter")
                {
                    ApplicationArea = All;
                }
                field("Lecture Room Filter"; Rec."Lecture Room Filter")
                {
                    ApplicationArea = All;
                }
                field("Total Income"; Rec."Total Income")
                {
                    ApplicationArea = All;
                }
                field("Students Registered"; Rec."Students Registered")
                {
                    ApplicationArea = All;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                }
                field("Class Filter"; Rec."Class Filter")
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Day Filter"; Rec."Day Filter")
                {
                    ApplicationArea = All;
                }
                field("Unit Class Filter"; Rec."Unit Class Filter")
                {
                    ApplicationArea = All;
                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = All;
                }
                field("Exam Filter"; Rec."Exam Filter")
                {
                    ApplicationArea = All;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field(Tested; Rec.Tested)
                {
                    ApplicationArea = All;
                }
                field(Prerequisite; Rec.Prerequisite)
                {
                    ApplicationArea = All;
                }
                field("Lesson Filter"; Rec."Lesson Filter")
                {
                    ApplicationArea = All;
                }
                field("Common Unit"; Rec."Common Unit")
                {
                    ApplicationArea = All;
                }
                field("No. Units"; Rec."No. Units")
                {
                    ApplicationArea = All;
                }
                field("Programme Option"; Rec."Programme Option")
                {
                    ApplicationArea = All;
                }
                field("Reg. ID Filter"; Rec."Reg. ID Filter")
                {
                    ApplicationArea = All;
                }
                field("Student No. Filter"; Rec."Student No. Filter")
                {
                    ApplicationArea = All;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                }
                field("Unit Registered"; Rec."Unit Registered")
                {
                    ApplicationArea = All;
                }
                field("Re-Sit"; Rec."Re-Sit")
                {
                    ApplicationArea = All;
                }
                field(Audit; Rec.Audit)
                {
                    ApplicationArea = All;
                }
                field(Submited; Rec.Submited)
                {
                    ApplicationArea = All;
                }
                field("Exam Status"; Rec."Exam Status")
                {
                    ApplicationArea = All;
                }
                field("Printed Copies"; Rec."Printed Copies")
                {
                    ApplicationArea = All;
                }
                field("Issued Copies"; Rec."Issued Copies")
                {
                    ApplicationArea = All;
                }
                field("Returned Copies"; Rec."Returned Copies")
                {
                    ApplicationArea = All;
                }
                field("Exam Remarks"; Rec."Exam Remarks")
                {
                    ApplicationArea = All;
                }
                field("Details Count"; Rec."Details Count")
                {
                    ApplicationArea = All;
                }
                field("Not Allocated"; Rec."Not Allocated")
                {
                    ApplicationArea = All;
                }
                field("Timetable Priority"; Rec."Timetable Priority")
                {
                    ApplicationArea = All;
                }
                field("Normal Slots"; Rec."Normal Slots")
                {
                    ApplicationArea = All;
                }
                field("Lab Slots"; Rec."Lab Slots")
                {
                    ApplicationArea = All;
                }
                field("Slots Varience"; Rec."Slots Varience")
                {
                    ApplicationArea = All;
                }
                field("Time Table"; Rec."Time Table")
                {
                    ApplicationArea = All;
                }
                field("Exam Not Allocated"; Rec."Exam Not Allocated")
                {
                    ApplicationArea = All;
                }
                field("Exam Slots Varience"; Rec."Exam Slots Varience")
                {
                    ApplicationArea = All;
                }
                field(Show; Rec.Show)
                {
                    ApplicationArea = All;
                }
                field("Estimate Reg"; Rec."Estimate Reg")
                {
                    ApplicationArea = All;
                }
                field("Exams Done"; Rec."Exams Done")
                {
                    ApplicationArea = All;
                }
                field("Default Exam Category"; Rec."Default Exam Category")
                {
                    ApplicationArea = All;
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ApplicationArea = All;
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("New Units")
                {
                    Caption = 'New Units';
                    RunObject = Page "ACA-Units/Subjects";
                    RunPageLink = "New Unit" = FILTER(true);
                    ApplicationArea = All;
                }

                action("Edit Units")
                {
                    Caption = 'Edit Units';
                    RunObject = Page 68743;
                    ApplicationArea = All;
                }
            }
        }
    }
}

