page 69178 "ACA-Library Fines"
{
    PageType = List;
    SourceTable = "ACA-Library Fines";
    SourceTableView = WHERE(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Patron Number"; Rec."Patron Number")
                {
                    ApplicationArea = All;
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(FineID; Rec.FineID)
                {
                    ApplicationArea = All;
                }
                field(description; Rec.description)
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Post)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Do you really want to post the Fines') THEN BEGIN
                        GenSetup.GET;
                        GenSetup.TESTFIELD(GenSetup."Library Fines");

                        LibFines.RESET;
                        LibFines.SETRANGE(LibFines.Posted, FALSE);
                        IF LibFines.FIND('-') THEN BEGIN
                            REPEAT
                                JournalLine.INIT;
                                JournalLine."Journal Template Name" := 'General';
                                JournalLine."Journal Batch Name" := 'Fines';
                                JournalLine."Line No." := JournalLine."Line No." + 1000;
                                JournalLine."Account Type" := JournalLine."Account Type"::"G/L Account";
                                JournalLine."Account No." := GenSetup."Library Fines";
                                JournalLine."Posting Date" := TODAY;
                                JournalLine."Document No." := 'Lib Fines ' + FORMAT(TODAY);
                                JournalLine.Description := COPYSTR(LibFines.description, 1, 50);
                                JournalLine.Amount := LibFines.Amount * -1;
                                JournalLine.INSERT;

                                LibFines.Posted := TRUE;
                                LibFines.MODIFY;
                            UNTIL LibFines.NEXT = 0;
                        END;
                    END;
                    MESSAGE('Journal created Successfuly');
                end;
            }
        }
    }

    var
        JournalLine: Record "Gen. Journal Line";
        GenSetup: Record "ACA-General Set-Up";
        LibFines: Record "ACA-Library Fines";
}

