report 51813 "CAT-Cafe Revenue Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/CAT-Cafe Revenue Reports.rdl';

    dataset
    {
        dataitem(DataItem1; 61777)
        {
            RequestFilterFields = Counts, "Posting Date";
            column(pic; info.Picture)
            {
            }
            column(address; Address)
            {
            }
            column(tel; Tel)
            {
            }
            column(fax; Fax)
            {
            }
            column(pin; PIN)
            {
            }
            column(email; Email)
            {
            }
            column(vat; VAT)
            {
            }
            column(dates; FORMAT(TODAY, 0, 4))
            {
            }
            column(datefilter; datefilter)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(CafeCash; "CAFE CASH")
            {
            }
            column(CafeCredit; "CAFE CREDIT")
            {
            }
            column(CafeAdv; "CAFE ADVANCE")
            {
            }
            column(CafeTot; "CAFE TOTAL")
            {
            }
            column(ManCash; "MAN CASH")
            {
            }
            column(ManCred; "MAN CREDIT")
            {
            }
            column(ManAdv; "MAN ADVANCE")
            {
            }
            column(ManTotal; "MAN TOTAL")
            {
            }
            column(GTotal; "GRAND TOTAL")
            {
            }

            trigger OnPreDataItem()
            begin
                IF datefilter = 0D THEN datefilter := TODAY;

                info.RESET;
                IF info.FIND('-') THEN
                    info.CALCFIELDS(info.Picture);

                Address := info.Address + ', ' + info."Address 2" + ', ' + info.City;
                Tel := 'TEL:' + info."Phone No.";
                Email := 'EMAIL:' + info."E-Mail";

                //PIN:='PIN NO.: ';
                VAT := 'VAT: ' + info."VAT Registration No.";

                SETFILTER("Posting Date", '=%1', datefilter);
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

    trigger OnInitReport()
    begin
        datefilter := TODAY;
    end;

    var
        info: Record 79;
        Address: Text[250];
        Tel: Code[100];
        Fax: Code[20];
        PIN: Code[20];
        Email: Text[50];
        VAT: Code[20];
        datefilter: Date;
}

