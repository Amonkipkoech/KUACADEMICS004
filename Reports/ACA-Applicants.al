report 86521 "ACA-APPLICANTS Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/acaAplicants.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(applicant; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "First Degree Choice", "Settlement Type";

            column(Pic; CompanyInformation.Picture)
            {

            }
            column(programName; programName)
            {

            }
            column(FirstName_applicant; "First Name")
            {
            }
            column(Surname_applicant; Surname)
            {
            }
            column(OtherNames_applicant; "Other Names")
            {
            }
            column(Gender_applicant; Gender)
            {
            }
            column(DateOfBirth_applicant; "Date Of Birth")
            {
            }
            column(Nationality_applicant; Nationality)
            {
            }
            column(Disability_applicant; Disability)
            {
            }
            column(SettlementType_applicant; "Settlement Type")
            {
            }
            column(IDNumber_applicant; "ID Number")
            {
            }
            column(TelephoneNo1_applicant; "Telephone No. 1")
            {
            }
            column(Email_applicant; Email)
            {
            }
            column(Religion_applicant; Religion)
            {
            }
            column(Denomination_applicant; Denomination)
            {
            }
            column(ModeofStudy_applicant; "Mode of Study")
            {
            }
            column(Status; Status)
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