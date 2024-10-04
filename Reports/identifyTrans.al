report 86615 updateTrans
{
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(glEntry; "G/L Entry")
        {
            RequestFilterFields = "Posting Date";
            column(Entry_No_; "Entry No.")
            {

            }
            column(G_L_Account_No_; "G/L Account No.")
            {

            }
            trigger OnAfterGetRecord()
            var
                coa: record "G/L Account";
                glentries: record "G/L Entry";
            begin

                coa.Reset();
                coa.SetRange("No.", glEntry."G/L Account No.");
                if not coa.Find('-') then begin
                    glEntry.todelete := true;
                    glEntry.Modify();
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