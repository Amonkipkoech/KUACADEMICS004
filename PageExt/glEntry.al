pageextension 40000 "GL EntryEXT" extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Payment Narration"; Rec."Payment Narration")
            {

            }
        }
    }

    trigger OnOpenPage()
    var
        purchInvoice: Record "Purch. Inv. Line";
        glentry: Record "G/L Entry";
    begin
        glentry.Reset();
        glentry.SetRange("Document Type", glentry."Document Type"::Invoice);
        if glentry.Find('-') then begin
            repeat
                if glentry."Payment Narration" = '' then begin
                    purchInvoice.Reset();
                    purchInvoice.SetRange("Document No.", glentry."Document No.");
                    if purchInvoice.Find('-') then begin
                        glentry."Payment Narration" := purchInvoice.Description;
                        glentry.Modify();
                    end;
                end 
            until glentry.Next() = 0;
        end;
    end;

}