report 51863 "Students Registered Per Unit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/studentsReg.rdl';


    dataset
    {
        dataitem(StudUnits; "ACA-Student Units")
        {
            //CalcFields = ModeOfStudy;
            RequestFilterFields = Semester, Unit;
            column(Student_No_; "Student No.")
            {

            }
            column(AcademicYear_StudUnits; "Academic Year")
            {
            }
            column(Semester_StudUnits; Semester)
            {
            }
            column(Stage_StudUnits; Stage)
            {
            }
            column(Unit_StudUnits; Unit)
            {
            }
            column(Description_StudUnits; Description)
            {
            }
            column(Programme_StudUnits; Programme)
            {
            }
            // column(ModeOfStudy; ModeOfStudy)
            // {

            // }
            column(Campus_Code;"Campus Code")
            {

            }
           
            column(pic; info.Picture)
            {

            }
            column(name; info.Name)
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
        info.get();
        info.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        info: Record "Company Information";
}