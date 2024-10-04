report 77742 "Stud Bal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Stud Bal.rdl';

    dataset
    {
        dataitem(DataItem1; 18)
        {
            RequestFilterFields = Balance, "Global Dimension 1 Code";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Campus; Customer."Global Dimension 1 Code")
            {
            }
            column(Bal; Customer.Balance)
            {
            }
            column(serial; serial)
            {
            }

            trigger OnAfterGetRecord()
            begin
                serial := serial + 1;
            end;

            trigger OnPreDataItem()
            begin
                serial := 0;
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
        serial: Integer;
        customer: Record customer;
}

