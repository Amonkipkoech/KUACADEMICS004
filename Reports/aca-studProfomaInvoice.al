report 86612 "Student Proforma Invoice2"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/studProforma.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItemName; "ACA-Course Registration")

        {
            DataItemTableView = where(Semester = const('JAN-APR24'));
            RequestFilterFields = "Student No.";
            CalcFields = ProgramName;
            column(Student_No_; "Student No.")
            {

            }

            column(Student_Name; "Student Name")
            {

            }
            column(Stage; Stage)
            {

            }
            column(Campus_Code; "Campus Code")
            {

            }
            column(ProgramName; ProgramName)
            {

            }
            column(Settlement_Type; "Settlement Type")
            {

            }
            column(Total_Billed; "Total Billed")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(CompName; CompanyInformation.Name)
            {

            }
            column(Semester; Semester)
            {

            }

        }
    }

    trigger OnInitReport()
    begin


        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);

        END;
        sems.Reset();
        sems.SetRange("Current Semester", true);
        if sems.Find('-') then begin
            currentSem := sems.Code;
        end;

    end;




    var
        myInt: Integer;
        CompanyInformation: Record 79;
        currentSem: Text[20];
        sems: record "ACA-Semester";

}