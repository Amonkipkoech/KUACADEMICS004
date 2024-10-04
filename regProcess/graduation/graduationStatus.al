page 86624 "Process Graduation"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = gradStudents;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(studNo; Rec.studNo)
                {
                    ApplicationArea = All;
                }
                field(studName; Rec.studName)
                {
                    ApplicationArea = All;
                }
                field(graduationStatus; Rec.graduationStatus)
                {
                    ApplicationArea = All;
                }
                field(programme; Rec.programme)
                {
                    ApplicationArea = All;
                }
                field(unitsCount; Rec.unitsCount)
                {
                    ApplicationArea = All;
                }
                field("Average Grade"; Rec."Average Grade")
                {
                    ApplicationArea = All;
                }
                field(GradRemark; Rec.GradRemark)
                {
                    ApplicationArea = All;
                }
                field("Graduating Grade"; Rec."Graduating Grade")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }




            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(updates)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    updateProg();
                end;
            }
        }
    }
    procedure updateProg()
    var
        trans: record "Final Exam Result2";
        gradstu: Record gradStudents;
    begin
        gradstu.Reset();
        gradstu.SetRange(graduationStatus, gradstu.graduationStatus::Completed);
        if gradstu.Find('-') then begin
            repeat
                trans.Reset();
                trans.SetRange(StudentID, gradstu.studNo);
                if trans.Find('-') then begin
                    gradstu.programme := trans.ProgrammeID;
                    gradstu.Modify();
                end;
            until gradstu.Next() = 0;
        end;
    end;
}