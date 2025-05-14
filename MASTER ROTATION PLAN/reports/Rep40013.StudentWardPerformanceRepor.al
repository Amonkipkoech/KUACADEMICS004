report 40013 "Student Ward Performance Repor"
{
    Caption = 'Student Ward Performance Report';
    DefaultLayout = RDLC;
    RDLCLayout = './MASTER ROTATION PLAN/reports/StudentWardPerformanceReport.rdl';
    dataset
    {
        dataitem(StudentWardLine; "Student Ward Line")
        {
            RequestFilterFields = StudentNo, Semester;
            column(GroupId; GroupId)
            {
            }
            column(StudentNo; StudentNo)
            {
            }
            column(Student_Name; "Student Name2")
            {
            }
            column(Student_Phone_Number; "Student Phone Number2")
            {
            }
            column(Student_Program_; "Student Program2 ")
            {
            }
            column(RotationWardArea; "Rotation Ward Area")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(Comment; Comment)
            {
            }
            column(Semester; Semester)
            {
            }
            column(RotationArea; "Rotation Area")
            {
            }
            column(RotationWardName; "Rotation Ward Name")
            {
            }
            column(Attendance; Attendance)
            {
            }
            column(Achievements; Achievements)
            {
            }
            column(info_pic; info.Picture)
            {
            }
            column(info_name; info.Name)
            {
            }
            column(info_phone; info."Phone No.")
            {
            }
            column(info_mail; info."E-Mail")
            {
            }
            column(seq; seq)
            {
            }
            trigger OnAfterGetRecord()
            var
                CustomerRec: Record Customer;
                Session: Record "ACA-Course Registration";
            begin
                seq := seq + 1;
                if CustomerRec.Get(StudentNo) then begin
                    "Student Name2" := CustomerRec.Name;
                    "Student Phone Number2" := CustomerRec."Phone No.";
                end else begin
                    "Student Name2" := '';
                    "Student Phone Number2" := '';
                end;
                Session.Reset();
                Session.SetRange("Student No.", StudentNo);
                if Session.FindFirst() then
                    "Student Program2 " := Session.ProgramName
                else
                    "Student Program2 " := '';

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
    trigger OnInitReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
    end;



    var
        myInt: Integer;
        seq: Integer;
        info: Record 79;
        "Student Name2": Text[50];
        "Student Phone Number2": text[30];
        "Student Program2 ": Text[50];
}
