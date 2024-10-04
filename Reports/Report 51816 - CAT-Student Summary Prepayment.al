report 51816 "CAT-Student Summary Prepayment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/CAT-Student Summary Prepayment.rdl';

    dataset
    {
        dataitem(DataItem1; 61176)
        {
            RequestFilterFields = "Customer No";
            column(EntryNo_CateringPrepaymentLedger; "Entry No")
            {
            }
            column(CustomerNo_CateringPrepaymentLedger; "Customer No")
            {
            }
            column(EntryType_CateringPrepaymentLedger; "Entry Type")
            {
            }
            column(Date_CateringPrepaymentLedger; Date)
            {
            }
            column(Description_CateringPrepaymentLedger; Description)
            {
            }
            column(Amount_CateringPrepaymentLedger; Amount * (-1))
            {
            }
            column(UserID_CateringPrepaymentLedger; "User ID")
            {
            }
            column(Reversed_CateringPrepaymentLedger; Reversed)
            {
            }
            column(ReversedOn_CateringPrepaymentLedger; "Reversed On")
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

    var
        info: Record 79;
        Address: Text[250];
        Tel: Code[100];
        Fax: Code[20];
        PIN: Code[20];
        Email: Text[50];
        VAT: Code[20];
        DetTotal: Decimal;
        totals: Decimal;
        change: Decimal;
        Amounts: Decimal;
        creditEmp: Code[150];
        "Cafeteria Receipts Line": Record 61173;
}

