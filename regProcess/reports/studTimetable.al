report 86620 "StudentTimetable"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/studTT.rdl';

    dataset
    {
        dataitem(DataItemName; "ACA-Student Units")
        {
            RequestFilterFields = "Student No.", Semester;
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(ModeOfStudy; ModeOfStudy)
            {

            }
            column(TimeSlot; TimeSlot)
            {

            }
            column(LectureHall; LectureHall)
            {

            }
            column(Lecturer; Lecturer)
            {

            }
            column(Stream; Stream)
            {

            }
            column(Unit_Description; "Unit Description")
            {

            }
            column(Unit; Unit)
            {

            }
            column(Day; Day)
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
}