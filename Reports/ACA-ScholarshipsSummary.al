report 86617 "Scholarship-Batch Summary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/acaScholarshipSummary.rdl';


    dataset
    {
        dataitem(scholarshipabatch; "ACA-Scholarship Batches")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(Document_Date; format("Document Date"))
            {

            }
            column(Academic_Year; "Academic Year")
            {

            }
            column(Scholarship_Type; "Scholarship Type")
            {

            }
            column(Batch_No_; "Batch No.")
            {

            }
            column(Batch_Date; format("Batch Date"))
            {

            }
            column(Semester; Semester)
            {

            }
            column(Scholarship_Name; "Scholarship Name")
            {

            }
            column(No__of_Students_; "No. of Students ")
            {

            }
            column(Receipt_Amount; "Receipt Amount")
            {

            }
            column(Allocated_Amount; "Allocated Amount")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(name; CompanyInformation.Name)
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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;


    var
        myInt: Integer;
        CompanyInformation: Record 79;

}