report 86522 "Units On Offer Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/unitsOffer.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(unitsOnOffer; "ACA-Semester Units On Offer")
        {
            RequestFilterFields = "Academic Year", Semester, "Programme Code", "Mode of Study";
            column(Academic_Year; "Academic Year")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Mode_of_Study; "Mode of Study")
            {

            }
            column(Campus_Code; "Campus Code")
            {

            }
            column(Lecturer_Code; "Lecturer Code")
            {

            }
            column(Stage_Code; "Stage Code")
            {

            }

            column(Program_Duration; "Program Duration")
            {

            }
            column(ProgrammeCode_unitsOnOffer; "Programme Code")
            {
            }
            column(Code_unitsOnOffer; "Unit Code")
            {
            }
            column(Desription_unitsOnOffer; Desription)
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }

        }
    }

    requestpage
    {
        layout
        {

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