report 51482 "Students Revenue Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Revenue Summary.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = WHERE("Global Dimension No." = CONST(4));
            RequestFilterFields = "Semester Filter";
            column(Code_DimensionValue; "Dimension Value".Code)
            {
            }
            column(CompName; CompIf.Name)
            {
            }
            column(Name_DimensionValue; "Dimension Value".Name)
            {
            }
            column(SemesterFilter_DimensionValue; "Dimension Value"."Semester Filter")
            {
            }
            dataitem("ACA-Charge"; "ACA-Charge")
            {
                DataItemTableView = WHERE(Show = CONST(true));
                column(Code_Charge; "ACA-Charge".Code)
                {
                }
                column(Description_Charge; "ACA-Charge".Description)
                {
                }
                column(BillAmount; BillAmount)
                {
                }
                column(RecAmount; RecAmount)
                {
                }
                column(Balance; Bal)
                {
                }
                column(Perc; Perc)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BillAmount := 0;
                    RecAmount := 0;
                    Bal := 0;
                    Perc := 0;
                    Cust.RESET;
                    Cust.SETFILTER(Cust."Current Faculty", "Dimension Value".Code);
                    Cust.SETFILTER(Cust."Semester Filter", "Dimension Value".GETFILTER("Dimension Value"."Semester Filter"));
                    Cust.SETFILTER(Cust."Charge Filter", "ACA-Charge".Code);
                    IF Cust.FIND('-') THEN BEGIN
                        REPEAT
                            Cust.CALCFIELDS(Cust."Charges Amount");
                            Cust.CALCFIELDS(Cust.Balance);
                            Cust.CALCFIELDS(Cust."Credit Amount");
                            IF Cust."Credit Amount" > Cust."Charges Amount" THEN
                                RecAmount := RecAmount + Cust."Charges Amount";
                            BillAmount := BillAmount + Cust."Charges Amount";
                        UNTIL Cust.NEXT = 0;
                    END;
                    Bal := BillAmount - RecAmount;
                    IF (BillAmount > 0) AND (RecAmount > 0) THEN
                        Perc := (RecAmount / BillAmount) * 100;

                    IF BillAmount = 0 THEN
                        CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompIf.GET;
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
        Cust: Record 18;
        BillAmount: Decimal;
        RecAmount: Decimal;
        Bal: Decimal;
        Perc: Decimal;
        CompIf: Record 79;
}

