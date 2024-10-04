report 86523 "Class Attendance"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/attReg.rdl';

    dataset
    {
        dataitem(att; "Class Attendance Details")
        {

            column(AttendanceDate_att; "Attendance Date")
            {
            }
            column(StudentNo_att; "Student No.")
            {
            }
            column(StudentName_att; "Student Name")
            {
            }
            column(LecturerCode_att; "Lecturer Code")
            {
            }
            column(UnitCode_att; "Unit Code")
            {
            }
            column(Present_att; Present)
            {
            }
            column(Semester_att; Semester)
            {
            }
            column(pic ;CompanyInformation.Picture)
            {
                
            }
        }
    }

    requestpage
    {
        layout
        {

        }


    }
    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        myInt: Integer;
        CompanyInformation: Record 79;
}