report 51076 "Student IDs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student IDs.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("Customer Posting Group" = CONST('STUDENT'),
                                      "Customer Type" = FILTER(Student));
            RequestFilterFields = "No.";
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(IDNo; Customer."ID No")
            {
            }
            column("Count"; COUNT)
            {
            }
            column(Pics; Customer.Image)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Customer.Image);
                //Customer.SETAUTOCALCFIELDS(Picture);
                Customer.CALCFIELDS(Image);
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
        "Count": Integer;
}

