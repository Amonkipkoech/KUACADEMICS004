report 86524 "Student List per Unit"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/studList.rdl';


    dataset
    {
        dataitem(studList; "ACA-Student Units")
        {
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Student_Type; "Student Type")
            {

            }
            column(Campus_Code; "Campus Code")
            {

            }
            column(Unit; Unit)
            {

            }
            column(pic;CompanyInformation.Picture)
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