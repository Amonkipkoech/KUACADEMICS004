page 68019 "ACA-Reversal xxxxxxxxxxxxxx"
{
    PageType = Card;
    SourceTable = 91;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(PDate; PDate)
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
                field(DocNo; DocNo)
                {
                    Caption = 'Doc No';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Posting)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    GLEntry.SETRANGE("Document No.", DocNo);
                    GLEntry.SETRANGE("Posting Date", PDate);
                    IF GLEntry.FIND('-') THEN BEGIN
                        GLEntry.DELETEALL;
                    END;


                    CustLed.RESET;
                    CustLed.SETCURRENTKEY("Document No.", "Posting Date");
                    CustLed.SETRANGE("Document No.", DocNo);
                    CustLed.SETRANGE("Posting Date", PDate);
                    IF CustLed.FIND('-') THEN BEGIN
                        CustLed.DELETEALL;
                    END;

                    BankLedg.RESET;
                    BankLedg.SETCURRENTKEY("Document No.", "Posting Date");
                    BankLedg.SETRANGE("Document No.", DocNo);
                    BankLedg.SETRANGE("Posting Date", PDate);
                    IF BankLedg.FIND('-') THEN BEGIN
                        BankLedg.DELETEALL;
                    END;

                    DCustLedg.RESET;
                    DCustLedg.SETCURRENTKEY("Document No.", "Posting Date");
                    DCustLedg.SETRANGE("Document No.", DocNo);
                    DCustLedg.SETRANGE("Posting Date", PDate);
                    IF DCustLedg.FIND('-') THEN BEGIN
                        DCustLedg.DELETEALL;
                    END;


                    VendLedg.RESET;
                    VendLedg.SETCURRENTKEY("Document No.", "Posting Date");
                    VendLedg.SETRANGE("Document No.", DocNo);
                    VendLedg.SETRANGE("Posting Date", PDate);
                    IF VendLedg.FIND('-') THEN BEGIN
                        VendLedg.DELETEALL;
                    END;

                    DVendLedg.RESET;
                    DVendLedg.SETCURRENTKEY("Document No.", "Posting Date");
                    DVendLedg.SETRANGE("Document No.", DocNo);
                    DVendLedg.SETRANGE("Posting Date", PDate);
                    IF DVendLedg.FIND('-') THEN BEGIN
                        DVendLedg.DELETEALL;
                    END;

                    ResLedg.RESET;
                    ResLedg.SETCURRENTKEY("Document No.", "Posting Date");
                    ResLedg.SETRANGE("Document No.", DocNo);
                    ResLedg.SETRANGE("Posting Date", PDate);
                    IF ResLedg.FIND('-') THEN BEGIN
                        ResLedg.DELETEALL;
                    END;

                    VATEntry.RESET;
                    VATEntry.SETRANGE("Document No.", DocNo);
                    VATEntry.SETRANGE("Posting Date", PDate);
                    IF VATEntry.FIND('-') THEN BEGIN
                        VATEntry.DELETEALL;
                    END;

                    CHeader.RESET;
                    CHeader.SETRANGE(CHeader."No.", DocNo);
                    CHeader.SETRANGE(CHeader."Posting Date", PDate);
                    IF CHeader.FIND('-') THEN
                        CHeader.DELETEALL;

                    PInvoice.RESET;
                    PInvoice.SETRANGE(PInvoice."No.", DocNo);
                    PInvoice.SETRANGE(PInvoice."Posting Date", PDate);
                    IF PInvoice.FIND('-') THEN
                        PInvoice.DELETEALL;



                    MESSAGE('Reversal entries completed successfully.');
                end;
            }
        }
    }

    var
        GLEntry: Record 17;
        GLE: Record 17;
        CustLed: Record 21;
        BankLedg: Record 271;
        DCustLedg: Record 379;
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
        CHeader: Record 114;
        ResLedg: Record 203;
        PInvoice: Record 112;
        CustL: Record 21;
        SDate: Integer;
}

