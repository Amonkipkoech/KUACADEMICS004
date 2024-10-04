page 68110 "ACA-Catering Funds Transfer"
{
    PageType = List;
    SourceTable = 61182;
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
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
                Image = PostDocument;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Rec.TESTFIELD(Posted, FALSE);
                    IF CONFIRM('Do you really want to post the selected transfer?') THEN BEGIN
                        CateringSetUp.GET;
                        CateringSetUp.TESTFIELD(CateringSetUp."Catering Control Account");
                        IF Rec."Transfer Type" = Rec."Transfer Type"::"To Catering" THEN BEGIN
                            Rec.VALIDATE(Amount);
                            JournLine.INIT;
                            JournLine."Journal Template Name" := CateringSetUp."Sales Template";
                            JournLine."Journal Batch Name" := CateringSetUp."Sales Batch";
                            JournLine."Line No." := JournLine."Line No." + 1;
                            JournLine."Account Type" := JournLine."Account Type"::Customer;
                            JournLine."Account No." := Rec."Student No";
                            JournLine."Posting Date" := Rec.Date;
                            JournLine."Document No." := 'Transfer ' + FORMAT(Rec."Line No");
                            JournLine.Description := 'Fees to Catering Transfer';
                            JournLine."Bal. Account No." := CateringSetUp."Catering Control Account";
                            JournLine.Amount := Rec.Amount;
                            JournLine.INSERT;

                            IF CLedger.FINDLAST THEN LastEntry := CLedger."Entry No";
                            CLedger.INIT;
                            CLedger."Entry No" := LastEntry + 1;
                            CLedger."Customer No" := Rec."Student No";
                            CLedger."Entry Type" := CLedger."Entry Type"::"Debit Transfer";
                            CLedger.Date := Rec.Date;
                            CLedger.Description := 'Fees to Catering Tution';
                            CLedger.Amount := Rec.Amount;
                            CLedger."User ID" := USERID;
                            CLedger.INSERT;
                        END;

                        IF Rec."Transfer Type" = Rec."Transfer Type"::"To Fees" THEN BEGIN
                            Rec.VALIDATE(Amount);
                            JournLine.INIT;
                            JournLine."Journal Template Name" := CateringSetUp."Sales Template";
                            JournLine."Journal Batch Name" := CateringSetUp."Sales Batch";
                            JournLine."Line No." := JournLine."Line No." + 1;
                            JournLine."Account Type" := JournLine."Account Type"::Customer;
                            JournLine."Account No." := Rec."Student No";
                            JournLine."Posting Date" := Rec.Date;
                            JournLine."Document No." := 'Transfer ' + FORMAT(Rec."Line No");
                            JournLine.Description := 'Fees from Catering Tution';
                            JournLine."Bal. Account No." := CateringSetUp."Catering Control Account";
                            JournLine.Amount := -Rec.Amount;
                            JournLine.INSERT;

                            IF CLedger.FINDLAST THEN LastEntry := CLedger."Entry No";
                            CLedger.INIT;
                            CLedger."Entry No" := LastEntry + 1;
                            CLedger."Customer No" := Rec."Student No";
                            CLedger."Entry Type" := CLedger."Entry Type"::"Credit Transfer";
                            CLedger.Date := Rec.Date;
                            CLedger.Description := 'Fees from Catering Tution';
                            CLedger.Amount := -Rec.Amount;
                            CLedger."User ID" := USERID;
                            CLedger.INSERT;

                        END;


                        //Post New
                        JournLine.RESET;
                        JournLine.SETRANGE("Journal Template Name", CateringSetUp."Sales Template");
                        JournLine.SETRANGE("Journal Batch Name", CateringSetUp."Sales Batch");
                        IF JournLine.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", JournLine);
                        END;


                        Rec.Posted := TRUE;
                        Rec."Posted By" := USERID;
                        Rec.MODIFY;
                    END;
                end;
            }
            action("Update Catering Only")
            {
                Image = UndoShipment;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec."Transfer Type" = Rec."Transfer Type"::"To Catering" THEN BEGIN
                        IF CLedger.FINDLAST THEN LastEntry := CLedger."Entry No";
                        CLedger.INIT;
                        CLedger."Entry No" := LastEntry + 1;
                        CLedger."Customer No" := Rec."Student No";
                        CLedger."Entry Type" := CLedger."Entry Type"::"Debit Transfer";
                        CLedger.Date := Rec.Date;
                        CLedger.Description := 'Fees to Catering Tution';
                        CLedger.Amount := Rec.Amount;
                        CLedger."User ID" := USERID;
                        CLedger.INSERT;
                    END;
                    IF Rec."Transfer Type" = Rec."Transfer Type"::"To Fees" THEN BEGIN
                        IF CLedger.FINDLAST THEN LastEntry := CLedger."Entry No";
                        CLedger.INIT;
                        CLedger."Entry No" := LastEntry + 1;
                        CLedger."Customer No" := Rec."Student No";
                        CLedger."Entry Type" := CLedger."Entry Type"::"Credit Transfer";
                        CLedger.Date := Rec.Date;
                        CLedger.Description := 'Fees from Catering Tution';
                        CLedger.Amount := -Rec.Amount;
                        CLedger."User ID" := USERID;
                        CLedger.INSERT;
                    END;
                    MESSAGE('Catering Updated Succussfully');
                end;
            }
        }
    }

    var
        JournLine: Record 81;
        CateringSetUp: Record 61171;
        CateFundTrans: Record 61182;
        CLedger: Record 61176;
        LastEntry: Integer;
}

