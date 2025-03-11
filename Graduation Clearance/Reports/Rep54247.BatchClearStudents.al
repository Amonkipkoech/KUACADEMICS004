report 86000 "Batch Clear Students"
{
    Caption = 'Batch Clear Students';
    ProcessingOnly = true;
    dataset
    {
        dataitem(StudentClerance; "Student Clerance")
        {
            RequestFilterFields = "Department Code", School, "Student No";
            DataItemTableView = where(Status = filter('Pending'));
            column(ClearanceNo; "Clearance No")
            {
            }
            column(StudentNo; "Student No")
            {
            }
            column(StudentName; "Student Name ")
            {
            }
            column(Status; Status)
            {
            }
            column(School; School)
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            trigger OnAfterGetRecord()
            begin
                repeat
                    studClr.Reset();
                    studClr.SetRange(Status, studClr.Status::Pending);
                    studClr.SetRange("Student No", StudentClerance."Student No");
                    if studClr.Find('-') then begin
                        studClr."Department Cleared" := true;
                        studClr."HoD Name" := UserId;
                        studClr."School Cleared" := true;
                        studClr."School Cleared Name" := UserId;
                        studClr."ICT Cleared" := true;
                        studClr."Accomodation Cleared Name" := UserId;
                        studClr."Dean of Students" := true;
                        studClr."Dean of Students Name" := UserId;
                        studClr.Modify();
                    end;
                until StudentClerance.Next() = 0;
                Message('Students Cleared Successfully');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        studClr: Record "Student Clerance";
}
