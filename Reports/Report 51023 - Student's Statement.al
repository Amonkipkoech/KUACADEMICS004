report 51023 "Student's Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Statement.rdl';
    EnableHyperlinks = false;

    dataset
    {
        dataitem(SS; 18)
        {
            DataItemTableView = WHERE("Customer Posting Group" = CONST('STUDENT'),
                                      "Customer Type" = CONST(Student),
                                      "Current Semester" = FILTER(<> ''));
            RequestFilterFields = "Current Semester", "In Current Sem", "Date Filter";
            column(No; SS."No.")
            {
            }
            column(Name; SS.Name)
            {
            }
            column(DebitAmount; SS."Debit Amount")
            {
            }
            column(CreditAmount; SS."Credit Amount")
            {
            }
            column(Balance; SS.Balance)
            {
            }
            column(Number; Number)
            {
            }
            column(ClassCode; SS."Class Code")
            {
            }
            column(CourseDet; SS."Course Details")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Number := Number + 1;
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
        }
    }

    labels
    {
    }

    var
        Number: Integer;
}

