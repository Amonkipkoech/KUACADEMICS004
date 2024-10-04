report 86640 updateBankEntry
{
    Caption = 'Change Bank Account';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    // dataset
    // {
    //     dataitem(bankEntry; "Bank Account Ledger Entry")
    //     {
    //         RequestFilterFields = "Bank Account No.", "Posting Date", "Document No.";
    //         dataitem(bank; "Bank Account")
    //         {
    //             RequestFilterFields = "No.";
    //             trigger OnAfterGetRecord()
    //             var
    //                 banksTrans: Record "Bank Account Ledger Entry";
    //             begin
    //                 banksTrans.Reset();
    //                 banksTrans.SetRange("Bank Account No.", bankEntry."Bank Account No.");
    //                 if banksTrans.Find('-') then begin
    //                     repeat
    //                         banksTrans."Bank Account No." := bank."No.";
    //                         banksTrans.Modify();
    //                     until banksTrans.Next() = 0;
    //                 end;

    //             end;
    //         }







    //     }

    // }
    dataset
    {
        dataitem(buff; finBuffer1)
        {
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {

            }
            dataitem("Bank Account"; "Bank Account")
            {
                RequestFilterFields = "No.";
                trigger OnAfterGetRecord()
                begin
                    repeat
                        "Bank Account Ledger Entry".Reset();
                        "Bank Account Ledger Entry".SetRange("Entry No.", buff.entryNo);
                        if "Bank Account Ledger Entry".Find('-') then begin
                            repeat
                                "Bank Account Ledger Entry"."Bank Account No." := "Bank Account"."No.";
                                "Bank Account".Modify();
                            until "Bank Account".Next() = 0;
                        end;
                    // "Cust. Ledger Entry".Reset();
                    // "Cust. Ledger Entry".SetRange("Document No.", buff."Document No");
                    // if "Cust. Ledger Entry".Find('-') then begin
                    //     repeat
                    //         "Cust. Ledger Entry"."Posting Date" := buff."Posting Date";
                    //         "Cust. Ledger Entry".Modify();
                    //     until "Cust. Ledger Entry".Next() = 0;
                    // end;
                    // "Detailed Cust. Ledg. Entry".Reset();
                    // "Detailed Cust. Ledg. Entry".SetRange("Document No.", buff."Document No");
                    // if "Detailed Cust. Ledg. Entry".Find('-') then begin
                    //     repeat
                    //         "Detailed Cust. Ledg. Entry"."Posting Date" := buff."Posting Date";
                    //         "Detailed Cust. Ledg. Entry".Modify();
                    //     until "Detailed Cust. Ledg. Entry".Next() = 0;
                    // end;
                    until buff.Next() = 0;
                end;
            }
            


            // dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            // {

            // }
            // dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            // {

            // }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;

}