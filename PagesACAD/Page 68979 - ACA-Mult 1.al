page 68979 "ACA-Mult 1"
{
    PageType = List;
    SourceTable = "ACA-Multiple Student Records";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Times Repeated"; Rec."Times Repeated")
                {
                    ApplicationArea = All;
                }
                field("Balance Amount"; Rec."Balance Amount")
                {
                    ApplicationArea = All;
                }
                field("Correct No."; Rec."Correct No.")
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
                Caption = 'Posting';
                Image = Print;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    procc.OPEN('Executing: #1#####################################');
                    multiplerec.RESET;
                    IF multiplerec.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            procc.UPDATE(1, multiplerec."Student No." + ':' + multiplerec."Student Name");
                            SLEEP(100);

                            IF multiplerec."Student No." <> multiplerec."Correct No." THEN BEGIN
                                custleder.RESET;
                                custleder.SETRANGE(custleder."Customer No.", multiplerec."Student No.");
                                IF custleder.FIND('-') THEN BEGIN
                                    REPEAT
                                        custleder."Customer No." := multiplerec."Correct No.";
                                        custleder.MODIFY;
                                    UNTIL custleder.NEXT = 0;
                                END;
                                detailedcus.RESET;
                                detailedcus.SETRANGE(detailedcus."Customer No.", multiplerec."Student No.");
                                IF detailedcus.FIND('-') THEN BEGIN
                                    REPEAT
                                        detailedcus."Customer No." := multiplerec."Correct No.";
                                        detailedcus.MODIFY;
                                    UNTIL detailedcus.NEXT = 0;
                                END;
                                studPayments.RESET;
                                studPayments.SETRANGE(studPayments."Student No.", multiplerec."Student No.");
                                IF studPayments.FIND('-') THEN BEGIN
                                    REPEAT
                                        studPayments."Student No." := multiplerec."Correct No.";
                                        studPayments.MODIFY;
                                    UNTIL studPayments.NEXT = 0;
                                END;

                                examRes.RESET;
                                examRes.SETRANGE(examRes."Student No.", multiplerec."Student No.");
                                IF examRes.FIND('-') THEN BEGIN
                                    REPEAT
                                        examRes."Student No." := multiplerec."Correct No.";
                                        examRes.MODIFY;
                                    UNTIL examRes.NEXT = 0;
                                END;

                                studunits.RESET;
                                studunits.SETRANGE(studunits."Student No.", multiplerec."Student No.");
                                IF studunits.FIND('-') THEN BEGIN
                                    REPEAT
                                        studunits."Student No." := multiplerec."Correct No.";
                                        studunits.MODIFY;
                                    UNTIL studunits.NEXT = 0;
                                END;

                                studReceipts.RESET;
                                studReceipts.SETRANGE(studReceipts."Student No.", multiplerec."Student No.");
                                IF studReceipts.FIND('-') THEN BEGIN
                                    REPEAT
                                        studReceipts."Student No." := multiplerec."Correct No.";
                                        studReceipts.MODIFY;
                                    UNTIL studReceipts.NEXT = 0;
                                END;
                                cust.RESET;
                                cust.SETRANGE(cust."No.", multiplerec."Student No.");
                                IF cust.FIND('-') THEN BEGIN
                                    cust.DELETE;
                                END;
                            END;
                        END;
                        UNTIL multiplerec.NEXT = 0;
                    END;

                    procc.CLOSE;
                end;
            }
        }
    }

    var
        cust: Record 18;
        detailedcus: Record 379;
        custleder: Record 21;
        studPayments: Record 61536;
        studunits: Record 61549;
        examRes: Record 61548;
        studReceipts: Record 61538;
        multiplerec: Record 61748;
        procc: Dialog;
}

