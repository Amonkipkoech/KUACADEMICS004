report 86613 updateGl
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(glEntry; "G/L Entry")
        {
            RequestFilterFields = "G/L Account No.", "Posting Date";
            column(G_L_Account_No_; "G/L Account No.")
            {

            }
            dataitem(glAccount; "G/L Account")
            {
                RequestFilterFields = "No.";

                column(No_; "No.")
                {

                }
                trigger OnAfterGetRecord()
                var
                    glEntries: Record "G/L Entry";
                begin

                    glEntries.Reset();
                    glEntries.SetRange("G/L Account No.", glEntry."G/L Account No.");
                    glEntries.SetRange("Posting Date", glEntry."Posting Date");
                    if glEntries.Find('-') then begin
                        repeat
                            glEntries."G/L Account No." := glAccount."No.";
                            glEntries.Modify()
                        until glEntries.Next() = 0;
                    end

                end;
                // trigger OnAfterGetRecord()
                // var
                //     glAcc: Record "G/L Account";
                //     progre: Dialog;
                //     records: Integer;
                // begin

                //     // Clear(records);
                //     // glEntry.Reset();
                //     // glEntry.SetRange(glEntry."G/L Account No.", glAccount."No.");
                //     // progre.Open('Updating Records'+ '#1',records);

                //     // repeat

                //     //     if glEntry.Find('-') then begin
                //     //         glAcc.Reset();
                //     //         glAcc.SetRange("No.", glAccount."No.");
                //     //         if glAcc.Find('-') then begin
                //     //             if glAcc."New Code" <> '' then
                //     //                 glEntry."G/L Account No." := glAcc."New Code";
                //     //             glEntry.Modify()
                //     //         end;

                //     //     end;
                //     //     records := records + 1
                //     // until glEntry.Next() = 0
                // end;
                //  trigger OnAfterGetRecord()


            }

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