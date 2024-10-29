report 86520 "Students Programme Data"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/studProgData.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(studentDATA; "ACA-Applic. Form Header")
        {

            column(ApplicationNo_studentDATA; "Application No.")
            {
            }
            column(AdmissionNo_studentDATA; "Admission No")
            {
            }
            column(SettlementType_studentDATA; "Settlement Type")
            {
            }
            column(FirstDegreeChoice_studentDATA; "First Degree Choice")
            {
            }
            column(ModeofStudy_studentDATA; "Mode of Study")
            {
            }
            column(Campus_studentDATA; Campus)
            {
            }
            column(ApplicationDate_studentDATA; "Application Date")
            {
            }
            column(IntakeCode_studentDATA; "Intake Code")
            {
            }
            column(AcademicYear_studentDATA; "Academic Year")
            {
            }
            column(AdmissionStatus_studentDATA; "Admission Status")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(Name; CompanyInformation.Name)
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