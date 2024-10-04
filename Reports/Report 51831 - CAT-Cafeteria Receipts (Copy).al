report 51831 "CAT-Cafeteria Receipts (Copy)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/CAT-Cafeteria Receipts (Copy).rdl';

    dataset
    {
        dataitem(DataItem1; 61783)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Doc. No.";
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
            column(dettotal; DetTotal)
            {
            }
            column(dates; FORMAT(TODAY, 0, 4))
            {
            }
            column(recNo; "Receipt No.")
            {
            }
            column(transType; FORMAT("Transaction Type"))
            {
            }
            column(totals; totals)
            {
            }
            column(AmountPaid; Amount)
            {
            }
            column(change; Amount - "Recept Total")
            {
            }
            column(Amounts; "Recept Total")
            {
            }
            column(creditEmp; creditEmp)
            {
            }
            column(users; 'You were served by: ' + User)
            {
            }
            column(BonApettie; '************** BON APETTIE **************')
            {
            }
            column(endOfReceipt; 'End of Fiscal Receipt')
            {
            }
            column(double_Line; '==============================')
            {
            }
            dataitem(DataItem2; 61775)
            {
                DataItemLink = "Receipt No." = FIELD("Receipt No.");
                column(MealCode; "Meal Code")
                {
                }
                column(MealDesc; "Meal Descption")
                {
                }
                column(qty; Quantity)
                {
                }
                column(unitPrice; "Unit Price")
                {
                }
                column(TotLine_Amount; "Total Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    DetTotal := 0.0;
                    DetTotal := Quantity * "Unit Price";
                    totals := totals + DetTotal;
                    Amounts := Amounts;
                    change := Amounts - totals;//"Cafeteria Receipts"."Recept Total";
                end;
            }

            trigger OnAfterGetRecord()
            begin

                info.RESET;
                IF info.FIND('-') THEN
                    info.CALCFIELDS(info.Picture);

                Address := info.Address + ', ' + info."Address 2" + ', ' + info.City;
                Tel := 'TEL:' + info."Phone No.";
                Email := 'EMAIL:' + info."E-Mail";

                //PIN:='PIN NO.: ';
                VAT := 'VAT: ' + info."VAT Registration No.";
                totals := 0.0;
                change := 0.0;
                CALCFIELDS("Recept Total");
                CALCFIELDS("Customer Name");

                CALCFIELDS("Employee Name");

                creditEmp := '';
                IF "Employee No" <> '' THEN
                    creditEmp := "Employee No" + ': ' + "Employee Name";
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
}

