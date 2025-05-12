report 40012 "Consolidated Exam Timetable"
{
    Caption = 'consolidated Exam Timetable';

    DefaultLayout = RDLC;
    RDLCLayout = './Timetable2/Reports/SSR/ConsolidatedExamTimetable.rdl';
    dataset
    {
        dataitem(ExaminationTimetable; "Examination Timetable")
        {
            RequestFilterFields = "Academic Year", Semester, Department, Lecturer, Programs;
            column(infor_name; infor.Name)
            {
            }
            column(infor_pic; infor.Picture)
            {
            }
            column(infor_mail; infor."E-Mail")
            {
            }
            column(infor_address; infor.Address)
            {
            }
            column(infor_phone; infor."Phone No.")
            {
            }
            column(Programs; Programs)
            {
            }
            column(ProgramName; "Program Name")
            {
            }
            column(UnitBaseCode; "Unit Base Code")
            {
            }
            column(Department; Department)
            {
            }
            column(Day; Day)
            {
            }
            column(TimeSlot; TimeSlot)
            {
            }
            column(Semester; Semester)
            {
            }
            column(LectureHall; "Lecture Hall")
            {
            }
            column(SittingCapacity; "Sitting Capacity")
            {
            }
            column(AcademicYear; "Academic Year")
            {
            }
            column(Lecturer; Lecturer)
            {
            }
            column(ModeofStudy; ModeofStudy)
            {
            }
            column(RegisteredStudents; "Registered Students")
            {
            }
            column(Campus; Campus)
            {
            }
            column(Status; Status)
            {
            }
            column(LecturerName; "Lecturer Name")
            {
            }
            column(Month; Month)
            {
            }
            column(Week; Week)
            {
            }
            column(seq; seq)
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                seq := seq + 1;
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        infor.Reset();
        infor.CalcFields(infor.Picture)
    end;

    var
        infor: Record "Company Information";
        seq: Integer;
}
