report 51055 "Provisional Transcript2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/provTranscript.rdl';

    dataset
    {
        dataitem(examResults; "ACA-Student Units")

        {
            RequestFilterFields = "Student No.", Semester;
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Campus_Code; "Campus Code")
            {

            }
            column(Unit; Unit)
            {

            }
            column(Stage; Stage)
            {

            }
            column(CATs_Marks; "CATs Marks")
            {

            }
            column(Exam_Marks; "Exam Marks")
            {

            }
            column(Total_Score; "Total Score")
            {

            }
            column(Grade; Grade)
            {

            }
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(CompName; CompanyInformation.Name)
            {

            }
            column(desc; desc)
            {

            }
            trigger OnAfterGetRecord()
            begin
                unitsMaster.Reset();
                unitsMaster.SetRange("Unit Code", examResults.Unit);
                if unitsMaster.Find('-') then begin
                    desc := unitsMaster."Unit Name";
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {

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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);

        END;
    end;


    var
        myInt: Integer;
        CompanyInformation: Record 79;
        unitsMaster: Record "ACA-Units Master Table";
        desc: Text;

}