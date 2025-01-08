report 40004 "NCK Report "
{
    Caption = 'NCK Report ';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/SSR/NCKSummaryReport.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "First Choice Semester";
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(Name; CompanyInformation.Name)
            {

            }
            column(Application_No_; "Application No.")
            {

            }
            column(FirstName_DataItemName; "First Name")
            {
            }
            column(OtherNames_DataItemName; "Other Names")
            {
            }
            column(Surname_DataItemName; Surname)
            {
            }
            column(Gender_DataItemName; Gender)
            {
            }
            column(Email; Email)
            {
            }
            column(Admission_No; "Admission No")
            {
            }
            column(ID_Number; "ID Number")
            {
            }
            column(Birth_Cert_No; "Birth Cert No")
            {
            }
            column(Passport_Number; "Passport Number")
            {
            }
            column(Mobile; "Telephone No. 1")
            {
            }
            column(seq; seq)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                seq := seq + 1;
            end;
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
            area(Processing)
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
    end;

    var
        myInt: Integer;
        CompanyInformation: Record 79;
        seq: Integer;
}
