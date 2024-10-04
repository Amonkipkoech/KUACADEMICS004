report 86621 LecturerTimetable
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/lecTT.rdl';

    dataset
    {
        dataitem(DataItemName; "ACA-Units Offered")
        {
            RequestFilterFields = "Academic Year", Semester, Lecturer, "Lecture Hall", "Unit Base Code", TimeSlot;
            column(AcademicYear_DataItemName; "Academic Year")
            {
            }
            column(Campus_DataItemName; Campus)
            {
            }
            column(Day_DataItemName; Day)
            {
            }
            column(Department_DataItemName; Department)
            {
            }
            column(LectureHall_DataItemName; "Lecture Hall")
            {
            }
            column(Lecturer_DataItemName; Lecturer)
            {
            }
            column(ModeofStudy_DataItemName; ModeofStudy)
            {
            }
            column(RegisteredStudents_DataItemName; "Registered Students")
            {
            }
            column(Semester_DataItemName; Semester)
            {
            }
            column(Stream_DataItemName; Stream)
            {
            }
            column(TimeSlot_DataItemName; TimeSlot)
            {
            }
            column(UnitBaseCode_DataItemName; "Unit Base Code")
            {
            }
            column(name; CompanyInformation.Name)
            {

            }
            column(pic; CompanyInformation.Picture)
            {

            }
            column(Semester; Semester)
            {

            }
            column(LecName; LecName)
            {

            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Registered Students");
                hrEmp.Reset();
                hrEmp.SetRange("No.", Lecturer);
                if hrEmp.Find('-') then begin
                    LecName := hrEmp."Full Name";
                end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnInitReport()
    begin

        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;


    end;

    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
        hrEmp: Record "HRM-Employee (D)";
        LecName: Text[150];
}