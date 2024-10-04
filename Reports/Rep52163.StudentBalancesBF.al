report 52163 "Student Balances BF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Academics/Reports/SSR/BF.Student Balances.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
#pragma warning disable AL0254
            DataItemTableView = SORTING("Current Programme")
#pragma warning restore AL0254
                                ORDER(Ascending)
                                WHERE("Customer Type" = CONST(Student),
                                      "Current Programme" = FILTER(<> ''));
            RequestFilterFields = "No.", "Date Filter", "Current Programme";
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Debit_Amount__LCY__; "Debit Amount (LCY)")
            {
            }
            column(Customer__Credit_Amount__LCY__; "Credit Amount (LCY)")
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(Hesabu; Hesabu)
            {
            }
            column(totalc; totalc)
            {
            }
            column(Totald; Totald)
            {
            }
            column(totalb; totalb)
            {
            }
            column(ClassCode; Customer."Class Code")
            {
            }
            column(CurrentProgramme_Customer; Customer."Current Programme")
            {
            }
            column(BalPerc; BalPerc)
            {
            }
            column(ProgDesc; ProgDesc)
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CurrentSettlementType_Customer; Customer."Current Settlement Type")
            {
            }
            column(CurrentStage_Customer; Customer."Current Stage")
            {
            }
            column(DebitAmount; DebitAmount)
            {

            }
            column(CreditAmount; CreditAmount)
            {

            }
            column(BeginBal; BeginBal)
            {

            }
            column(EndBal; EndBal)
            {

            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No.");
                column(fac; "ACA-Course Registration".Faculty)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF Prog.GET(Customer."Current Programme") THEN
                    ProgDesc := Prog.Description;
                SCode := Creg.Faculty;

                Totald := Totald + Customer."Debit Amount (LCY)";
                totalc := totalc + Customer."Credit Amount (LCY)";
                totalb := totalb + Customer."Balance (LCY)";
                Hesabu := Hesabu + 1;

                BalPerc := 0;
                IF (Customer."Debit Amount (LCY)" <> 0) AND (Customer."Credit Amount (LCY)" <> 0) THEN
                    BalPerc := Customer."Credit Amount (LCY)" / Customer."Debit Amount (LCY)" * 100;

                //Balance BF
                cust2.Reset();
                cust2.SetRange("No.", Customer."No.");
                cust2.SetFilter("Date Filter", '%1..%2', 0D, (StartDate - 1));
                if cust2.Find('-') then begin
                    cust2.CalcFields("Debit Amount", "Credit Amount", Balance, "Balance Due");
                    BeginBal := cust2."Debit Amount" + cust2."Credit Amount";
                end;

                cust2.Reset();
                cust2.SetRange("No.", Customer."No.");
                cust2.SetFilter("Date Filter", '%1..%2', startdate, EndDate);
                if cust2.Find('-') then begin
                    cust2.CalcFields("Debit Amount", "Credit Amount", Balance);
                    CreditAmount := cust2."Credit Amount";
                    DebitAmount := cust2."Debit Amount";
                end;

                //Balance Closing
                cust2.Reset();
                cust2.SetRange("No.", Customer."No.");
                cust2.SetFilter("Date Filter", '%1..%2', 0D, (EndDate));
                if cust2.Find('-') then begin
                    cust2.CalcFields("Debit Amount", "Credit Amount", Balance);
                    EndBal := cust2.Balance;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Creg.RESET;
                Creg.SETRANGE(Creg."Student No.", Customer."No.");
                Creg.SETRANGE(Creg.Reversed, FALSE);
                IF Creg.FIND('-') THEN BEGIN
                    IF Cust.GET(Creg."Student No.") THEN BEGIN
                        Cust."Current Programme" := Creg.Programmes;
                        Cust."Current Settlement Type" := Creg."Settlement Type";
                        Cust."Current Stage" := Creg.Stage;
                        Cust.MODIFY;
                    END;
                END;


                CompInf.GET;
                CompInf.CALCFIELDS(CompInf.Picture);

                Customer.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
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
        Hesabu: Integer;
        totalc: Decimal;
        Totald: Decimal;
        totalb: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CustomerCaptionLbl: Label 'Customer';
        StageCaptionLbl: Label 'Stage';
        BalPerc: Decimal;
        Creg: Record "ACA-Course Registration";
        Cust: Record Customer;
        Prog: Record "ACA-Programme";
        ProgDesc: Text[150];
        CompInf: Record "Company Information";
        Dim: Record "Dimension Value";
        SCode: Text;
        StartDate: date;
        EndDate: date;

        BeginBal: Decimal;

        DebitAmount: Decimal;
        CreditAmount: Decimal;
        EndBal: Decimal;
        PeriodName: Text;
        cust2: Record Customer;



    trigger OnPreReport()
    begin


        //if period = '' then begin
        StartDate := Customer.GetRangeMin("Date Filter");
        EndDate := Customer.GetRangeMax("Date Filter");
        // message(format(TransCode));
        // end;s
    end;


}

