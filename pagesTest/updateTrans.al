report 52809 updates
{
    ProcessingOnly = true;
    dataset
    {
        dataitem(TestBuffer; TestBuffer)
        {
            RequestFilterFields = newAcc, oldAcc;

            trigger OnAfterGetRecord()
            var
                cust: Record Customer;
                glEntry: Record "G/L Entry";
                custLedgerEntry: Record "Cust. Ledger Entry";
                detaliedEntry: Record "Detailed Cust. Ledg. Entry";
            begin
                glEntry.Reset();
                glEntry.SetRange("Bal. Account No.", TestBuffer.oldAcc);
                if glEntry.Find('-') then begin
                    repeat
                        glEntry."Bal. Account No." := TestBuffer.newAcc;
                        glEntry.Modify();
                    until glEntry.Next() = 0;
                end;
                custLedgerEntry.Reset();
                custLedgerEntry.SetRange("Customer No.", TestBuffer.oldAcc);
                if custLedgerEntry.Find('-') then begin
                    repeat
                        custLedgerEntry."Customer No." := TestBuffer.newAcc;
                        custLedgerEntry.Modify();
                    until custLedgerEntry.Next() = 0;
                end;
                detaliedEntry.Reset();
                detaliedEntry.SetRange("Customer No.", TestBuffer.oldAcc);
                if detaliedEntry.Find('-') then begin
                    repeat
                        detaliedEntry."Customer No." := TestBuffer.newAcc;
                        detaliedEntry.Modify();
                    until detaliedEntry.Next() = 0;
                end;
                cust.Reset();
                cust.SetRange("No.", TestBuffer.oldAcc);
                if cust.Find('-') then begin
                    cust.Delete();
                end;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
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