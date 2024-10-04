report 85528 "Marksheet Submission Report"
{
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/markSheetSubmission.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItemName; "ACA-MarkSheet Submission")
        {
            column(Submission_Code; "Submission Code")
            {

            }
            column(AcademicYear_DataItemName; "Academic Year")
            {
            }
            column(Campus_DataItemName; Campus)
            {
            }
            column(DateMarksheetReceived_DataItemName; "Date Marksheet Received")
            {
            }
            column(LecturerStaffID_DataItemName; "Lecturer Staff ID")
            {
            }
            column(ModeOfStudy_DataItemName; "Mode Of Study")
            {
            }
            column(RegistryReceivingStaffID_DataItemName; "Registry Receiving Staff ID")
            {
            }
            column(Stream_DataItemName; Stream)
            {
            }
            column(SubmittingOfficerStaffID_DataItemName; "Submitting Officer Staff ID")
            {
            }
            column(UnitBaseCode_DataItemName; "Unit Base Code")
            {
            }
            column(Compic; CompanyInformation.Picture)
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
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;


    end;

    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
}