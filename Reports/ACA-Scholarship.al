report 86616 "Scholarship-Batch Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/acaScholarship.rdl';


    dataset
    {
        dataitem(scholarshipabatch; "ACA-Scholarship Batches")
        {
            RequestFilterFields = "No.";
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
            dataitem("ACA-Imp. Receipts Buffer"; "ACA-Imp. Receipts Buffer")
            {
                DataItemLink = "Transaction Code" = field("No.");
                column(Student_No_; "Student No.")
                {

                }
                column(Names; Name)
                {

                }
                column(Amount; Amount)
                {

                }
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