report 51867 SupplimentaryReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/suppList.rdl';

    dataset
    {
        dataitem(suppList; "Aca-Special Exams Details")
        {
            CalcFields = Campus;
            RequestFilterFields = "Current Semester";
            //DataItemTableView = WHERE("Current Semester" = const('MAY-AUG23'));

            column(AcademicYear_suppList; "Academic Year")
            {
            }
            column(Catogory_suppList; Catogory)
            {
            }
            column(StudentNo_suppList; "Student No.")
            {
            }
            column(UnitCode_suppList; "Unit Code")
            {
            }
            column(UnitDescription_suppList; "Unit Description")
            {
            }
            column(Programme;Programme)
            {
                
            }
            column(pic; info.Picture)
            {

            }
            column(name; info.Name)
            {

            }
            column(Campus; Campus)
            {

            }
            column(Current_Academic_Year; "Current Academic Year")
            {

            }
            column(Current_Semester; "Current Semester")
            {
            }
            column(studentName; studentName)
            {

            }
            column(studyMode; studyMode)
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
        info.get();
        info.CalcFields(Picture);
    end;

    var

        info: Record "Company Information";
}