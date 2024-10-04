report  52072 "Student Balances1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Academics/Reports/SSR/Student Balances.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
#pragma warning disable AL0254
            DataItemTableView = SORTING("Current Programme")
#pragma warning restore AL0254
                                ORDER(Ascending)
                                WHERE("Customer Type" = CONST(Student),
                                      "Current Programme" = FILTER(<> ''),
                                      "In Current Sem" = FILTER(> 0));
            RequestFilterFields = "No.", "Date Filter", "Balance (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)", "Current Programme";
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
                //CompInf.CALCFIELDS(CompInf.Picture);
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
}

