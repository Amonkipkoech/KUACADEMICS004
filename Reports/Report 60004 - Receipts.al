/* report 60004 Receipts
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipts.rdl';

    dataset
    {
        dataitem(DataItem1; 61723)
        {
            DataItemTableView = WHERE("Amount Recieved"=FILTER(<>0),
                                      Posted=FILTER(Yes));
            column(No;"No.")
            {
            }
            column(Dcreated;FORMAT(Date))
            {
            }
            column(Cashier;Cashier)
            {
            }
            column(Dposted;FORMAT("Date Posted"))
            {
            }
            column(Tposted;FORMAT("Time Posted"))
            {
            }
            column(BankCode;"Bank Code")
            {
            }
            column(ReceivedFrom;"Received From")
            {
            }
            column(OnBehalfOf;"On Behalf Of")
            {
            }
            column(Amount;"Amount Recieved")
            {
            }
            column(DimensionOne;"Global Dimension 1 Code")
            {
            }
            column(DimensionTwo;"Shortcut Dimension 2 Code")
            {
            }
            column(PostedBy;"Posted By")
            {
            }
            column(Createdy;"Created By")
            {
            }
            column(BankName;"Bank Name")
            {
            }
            column(Cheque;"Cheque No.")
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

    labels
    {
    }
}
 */
