report 86628 "ACA-Fee Structure"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/feeStructure2.rdl';

    dataset
    {
        dataitem(tuition; "ACA-Fee By Stage")
        {
            RequestFilterFields = "Programme Code", "Settlemet Type";
            column(Stage_Code; "Stage Code")
            {

            }
            column(Year1s1; Year1s1)
            {

            }
            column(Year1s2; Year1s2)
            {

            }
            column(Year2s1; Year2s1)
            {

            }
            column(Year2s2; Year2s2)
            {

            }
            column(Year3s1; Year3s1)
            {

            }
            column(Year3s2; Year3s2)
            {

            }
            column(Year4s1; Year4s1)
            {

            }
            column(Year4s2; Year4s2)
            {

            }

            dataitem(ChargeCode; "ACA-Stage Charges")
            {
                DataItemLink = "Settlement Type" = field("Settlemet Type");
                column(StageCharge; "Stage Code")
                {

                }
            }
            trigger OnAfterGetRecord()
            begin
                tuitionfee.Reset();
                tuitionfee.SetRange("Programme Code", tuition."Programme Code");
                tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                //tuitionfee.SetRange("Stage Code", tuition."Stage Code");
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y1S1');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year1s1 := tuitionfee."Break Down";
                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y1S2');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year1s2 := tuitionfee."Break Down";
                        y1Total := Year1s1 + Year1s2;
                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y2S1');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year2s1 := tuitionfee."Break Down";

                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y2S2');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year2s2 := tuitionfee."Break Down";
                        y2Total := Year2s1 + Year2s2;

                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y3S1');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year3s1 := tuitionfee."Break Down";
                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y3S2');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year3s2 := tuitionfee."Break Down";
                        y3Total := Year3s1 + Year3s2;
                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y4S1');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year4s1 := tuitionfee."Break Down";
                    end;
                end;
                if tuitionfee.Find('-') then begin
                    tuitionfee.SetRange("Settlemet Type", tuition."Settlemet Type");
                    tuitionfee.SetFilter("Stage Code", '%1', 'Y4S2');
                    if tuitionfee.FindFirst() then begin
                        tuitionfee.CalcSums(tuitionfee."Break Down");
                        Year4s2 := tuitionfee."Break Down";
                        y4Total := Year4s1 + Year4s2;
                    end;
                end;



            end;
        }

    }





    var
        tuitionfee: Record "ACA-Fee By Stage";
        adminFee: Record "ACA-Stage Charges";
        Year1s1: Decimal;
        Year1s2: Decimal;
        y1Total: Decimal;
        Year2s1: Decimal;
        Year2s2: Decimal;
        y2Total: Decimal;
        Year3s1: Decimal;
        Year3s2: Decimal;
        y3Total: Decimal;
        Year4s1: Decimal;
        Year4s2: Decimal;
        y4Total: Decimal;


}