page 86015 "Student clearance List"
{
    Caption = 'Student clearance List';
    PageType = List;
    CardPageId = "Student Clearance Card";
    SourceTable = "Student Clerance";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Clearance No"; Rec."Clearance No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearance No field.', Comment = '%';
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.', Comment = '%';
                }
                field("Student Name "; Rec."Student Name ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Batch Clear Students")
            {
                Image = Process;
                Promoted = true;
                RunObject = report "Batch Clear Students";
                ApplicationArea = All;

            }

        }
    }
    procedure ClearDuplicates()
    var
        studClr: Record "Student Clerance";
        tempTable: Record "Temp Table";
    begin
        studClr.Reset;
        studClr.SetCurrentKey("Student No");
        if studClr.Find('-') then begin
            repeat
                studClr.SETRANGE("Student No", studClr."Student No");
                studClr.FIND('+');
                studClr.SETRANGE("Student No");
                tempTable.Init();
                tempTable."Clearance No" := studClr."Clearance No";
                tempTable."Student No" := studClr."Student No";
                tempTable."Department Code" := studClr."Department Code";
                tempTable."Student Name " := studClr."Student Name ";
                tempTable.School := studClr.School;
                tempTable.Status := studClr.Status;
                tempTable.Insert();
            until studClr.Next = 0;
        end;
    end;

    procedure clearStudents()
    var
        studClr: Record "Student Clerance";
    begin
        //studCl.Reset()
    end;




}
