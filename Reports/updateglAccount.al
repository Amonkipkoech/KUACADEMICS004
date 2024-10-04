report 86614 updateGlacc
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

        dataitem(glAccount; "G/L Account")
        {
            //RequestFilterFields = "No.";

            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            var
                glAcc: Record "G/L Account";
                coaNew: Record coaUpdate;
            begin

                glAccount.Reset();
                glAccount.SetRange("Income/Balance", "Income/Balance"::"Balance Sheet");
                if glAccount.Find('-') then begin
                    repeat
                        glAcc.Reset();
                        glAcc.SetRange("No.", glAccount."No.");
                        if glAcc.Find('-') then begin
                            coaNew.Reset();
                            coaNew.SetRange(erpCode, glAcc."No.");
                            if coaNew.Find('-') then begin
                                //glAcc.Name := coaNew.desc;
                                glAcc."Search Name" := coaNew.desc;
                                glAcc.Modify();
                            end;
                        end;
                    until glAccount.Next() = 0;
                end;
                // if glAccount.Find('-') then begin
                //     repeat
                //         glAcc.Reset();
                //         glAcc.SetRange("No.", glAccount."No.");
                //         if glAcc.Find('-') then begin

                //             glAccount.Rename(glAcc."New Code");
                //             //glAccount.Modify();


                //             //  glAccount.Rename(glAccount."No.",
                //             //  glAccount."Search Name",
                //             //  glAccount."Reconciliation Account",
                //             //  glAccount."Gen. Bus. Posting Group",
                //             //  glAccount."Gen. Prod. Posting Group",
                //             //  glAccount."Consol. Debit Acc.",
                //             //  glAccount."Consol. Credit Acc.",
                //             //  glAccount.Name,
                //             //  glAccount."Account Type",
                //             //  glAccount."Account Category");
                //             //glAccount.Modify();

                //         end;
                //     until glAccount.Next() = 0;
                // end
            end;

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